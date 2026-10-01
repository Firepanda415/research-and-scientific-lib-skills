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
    const routed = [
      ...['SKILL.md', path.join('references', 'durable-prose.md'), path.join('references', 'prose-review.md'),
        path.join('references', 'api-docstrings.md')]
        .map(file => path.join(root, 'skills', 'research-writing-style', file)),
      path.join(root, 'skills', 'work-email', 'SKILL.md'),
    ];
    for (const file of routed) {
      assert.ok(fs.existsSync(file), `missing routed file ${file}`);
      assert.ok(context.includes(JSON.stringify(file.split(path.sep).join('/'))));
    }
    assert.match(context, /a document whose readers include people other than the user and agents/);
    assert.match(context, /When the readers are unclear, treat the text as the user's own/);
    assert.match(context, /code comments, docstrings, commit messages and pull-request descriptions/);
  }
  const invalid = spawnSync(process.execPath, [script, 'InvalidEvent'], { encoding: 'utf8' });
  assert.equal(invalid.status, 1);
  assert.equal(invalid.stdout, '');
});
