#!/usr/bin/env node

const path = require('node:path');

// ponytail: the event is a fixed command argument so an open stdin cannot stall startup.
const event = process.argv[2];
if (!['SessionStart', 'SubagentStart'].includes(event)) {
  process.stderr.write('Expected SessionStart or SubagentStart.\n');
  process.exit(1);
}

const skill = path.join(__dirname, '..', 'skills', 'research-writing-style');
const context = `MANDATORY WRITING ROUTE
Before drafting or editing text meant to be kept, reread, shared, published, or copied and pasted for human use, or reviewing the prose of such text, read and apply this plugin's research-writing-style skill at ${JSON.stringify(path.join(skill, 'SKILL.md'))} and its durable-prose reference at ${JSON.stringify(path.join(skill, 'references', 'durable-prose.md'))}.
This includes documents, READMEs, reports, manuscripts, letters, website copy, and paste-ready text delivered in chat. Select this route by the intended use of the text, regardless of length, file format, language, or whether the user repeats the request. Temporary chat summaries and progress updates alone do not trigger it. For mixed responses, apply it to the reusable text. Material passed or returned to another agent or a program, such as structured data, tool input, search results, or findings for an orchestrator, is outside this route. The agent that assembles such material into a human deliverable applies the route to the combined text. Text drafted for verbatim inclusion in a human deliverable stays in scope, as do prompts and handoffs the user will send, keep, or reuse.
Every generated or revised deliverable must pass a separate adversarial review before delivery. Read and apply ${JSON.stringify(path.join(skill, 'references', 'prose-review.md'))} at that stage. Review-only requests start from the existing text and do not authorize a rewrite. Check especially for conversation/prompt leakage and user prohibitions turned into unnecessary negative prose. Review the final assembled version, fix verified defects within scope, and recheck changed passages before delivery.
Load the shared files before starting, then load only their applicable references. Reuse instructions already read in the current context. After compaction, reload them when needed. If the files are unavailable, for example after a plugin update in a long-lived session, load research-writing-style from the host's current skill list and read its references from there. If that also fails, report the missing guidance instead of claiming to have applied it.`;

process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: event,
    additionalContext: context,
  },
}));
