const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const test = require('node:test');
const vm = require('node:vm');
const { createRequire } = require('node:module');
const { filterSkillBodyForMode, getFallbackInstructions, getPonytailInstructions } = require('../hooks/ponytail-instructions');

test('each runtime mode emits the current skill, and a missing skill uses the compact fallback', () => {
  const root = path.join(__dirname, '..');
  const body = fs.readFileSync(path.join(root, 'skills/ponytail/SKILL.md'), 'utf8');
  const filename = path.join(root, 'hooks/ponytail-instructions.js');
  const localRequire = createRequire(filename);
  const sandbox = {
    __dirname: path.dirname(filename),
    module: { exports: {} },
    require: name => name === 'fs'
      ? { readFileSync() { throw new Error('skill unavailable'); } }
      : localRequire(name),
  };
  vm.runInNewContext(fs.readFileSync(filename, 'utf8'), sandbox, { filename });
  for (const mode of ['lite', 'full', 'ultra']) {
    assert.equal(getPonytailInstructions(mode),
      `PONYTAIL MODE ACTIVE — level: ${mode}\n\n${filterSkillBodyForMode(body, mode)}`);
    assert.equal(sandbox.module.exports.getPonytailInstructions(mode), getFallbackInstructions(mode));
  }
});
