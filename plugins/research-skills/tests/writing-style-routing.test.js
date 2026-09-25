const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawn, spawnSync } = require('node:child_process');
const test = require('node:test');

const root = path.join(__dirname, '..');
const script = path.join(root, 'hooks', 'writing-style-routing.js');

// Codex keys hook trust by handler position and these registration fields. The plain
// `node` command also runs unchanged when a host starts it through PowerShell.
const writingHandler = event => ({
  type: 'command',
  command: `node "\${CLAUDE_PLUGIN_ROOT}/hooks/writing-style-routing.js" ${event}`,
  timeout: 5,
  statusMessage: 'Loading writing requirements...',
});

test('hooks.json registers only the writing route, at its trusted positions', () => {
  const config = JSON.parse(fs.readFileSync(path.join(root, 'hooks', 'hooks.json'), 'utf8'));
  assert.deepEqual(config, {
    hooks: {
      SessionStart: [{ matcher: 'startup|resume|clear|compact', hooks: [writingHandler('SessionStart')] }],
      SubagentStart: [{ hooks: [writingHandler('SubagentStart')] }],
    },
  });
  // Codex finds hooks/hooks.json by default when the manifest names no hooks file.
  const manifest = JSON.parse(fs.readFileSync(path.join(root, '.codex-plugin', 'plugin.json'), 'utf8'));
  assert.equal(manifest.hooks, undefined);
});

test('writing routing reaches sessions and subagents with stdin open', async () => {
  for (const event of ['SessionStart', 'SubagentStart']) {
    const child = spawn(process.execPath, [script, event], { stdio: ['pipe', 'pipe', 'pipe'] });
    let stdout = '';
    child.stdout.on('data', chunk => { stdout += chunk; });
    const code = await new Promise((resolve, reject) => {
      const guard = setTimeout(() => {
        child.kill();
        reject(new Error('writing hook waited for stdin'));
      }, 3000);
      child.on('close', code => { clearTimeout(guard); resolve(code); });
      child.on('error', error => { clearTimeout(guard); reject(error); });
    });
    assert.equal(code, 0);
    const output = JSON.parse(stdout);
    assert.equal(output.hookSpecificOutput.hookEventName, event);
    assert.equal(output.systemMessage, undefined);
    const context = output.hookSpecificOutput.additionalContext;
    for (const file of ['SKILL.md', path.join('references', 'durable-prose.md'), path.join('references', 'prose-review.md')]) {
      assert.ok(context.includes(JSON.stringify(path.join(root, 'skills', 'research-writing-style', file))));
    }
    assert.match(context, /Temporary chat summaries and progress updates alone do not trigger it/);
    assert.match(context, /paste-ready text delivered in chat/);
    assert.match(context, /returned to another agent or a program/);
  }
  const invalid = spawnSync(process.execPath, [script, 'InvalidEvent'], { encoding: 'utf8' });
  assert.equal(invalid.status, 1);
  assert.equal(invalid.stdout, '');
});
