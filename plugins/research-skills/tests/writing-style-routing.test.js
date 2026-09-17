const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawn, spawnSync } = require('node:child_process');
const test = require('node:test');

test('writing routing reaches sessions and subagents with Ponytail off and stdin open', async () => {
  const root = path.join(__dirname, '..');
  const script = path.join(root, 'hooks', 'writing-style-routing.js');
  const hooks = JSON.parse(fs.readFileSync(path.join(root, 'hooks', 'hooks.json'), 'utf8')).hooks;
  for (const event of ['SessionStart', 'SubagentStart']) {
    const routes = hooks[event].flatMap(group => group.hooks)
      .filter(hook => hook.command.includes('/writing-style-routing.js'));
    assert.equal(routes.length, 1);
    assert.ok(routes[0].command.endsWith(`" ${event}`));
    if (event === 'SessionStart') {
      for (const source of ['startup', 'resume', 'clear', 'compact']) {
        assert.ok(hooks[event].some(group => new RegExp(group.matcher).test(source)
          && group.hooks.includes(routes[0])), `missing ${source} routing`);
      }
    }
    const child = spawn(process.execPath, [script, event], {
      env: { ...process.env, PONYTAIL_DEFAULT_MODE: 'off' },
      stdio: ['pipe', 'pipe', 'pipe'],
    });
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
    assert.match(context, /remains active when Ponytail is off/);
  }
  const invalid = spawnSync(process.execPath, [script, 'InvalidEvent'], { encoding: 'utf8' });
  assert.equal(invalid.status, 1);
  assert.equal(invalid.stdout, '');
});
