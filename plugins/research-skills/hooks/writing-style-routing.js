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
Every generated or revised deliverable must pass an adversarial review, a stage separate from drafting, before delivery. Read and apply ${JSON.stringify(path.join(skill, 'references', 'prose-review.md'))} at that stage. That reference decides when its document-level review and an independent reviewer are also used. Review-only requests start from the existing text and do not authorize a rewrite. Check especially for conversation/prompt leakage, and for user prohibitions or removed items turned into unnecessary negative prose. Review the final assembled version, fix verified defects within scope, and recheck changed passages before delivery.
Load the shared files before starting, then load only their applicable references. Reuse instructions already read in the current context. After compaction, reload them when needed. If the files are unavailable, for example after a plugin update in a long-lived session, load research-writing-style from the host's current skill list and read its references from there. If that also fails, report the missing guidance instead of claiming to have applied it.
CURRENT STATE IN DURABLE FILES
Documents, project memory, instructions, code comments, and tests describe the current state and its reasons, because later readers, including agents, act on what they say. Mark a temporary arrangement as temporary and name what ends it. When work removes an item or ends an arrangement, delete in the same change the rules, references, and tests that exist only because of it, within the files the work is authorized to change, and report leftovers outside those files rather than editing them. A reference that serves a current obligation, such as a compatibility path for old data, a migration, or a check that rejects old input that users may still send, stays. History belongs in version control, dated records, decision records, or a changelog or migration note when users must act. Elsewhere, a note, prohibition, or instruction to ignore the item needs a stated reason why the item must stay absent, such as a contract, a security or resource limit, a measured failure, or an explicit user request to keep it out. A test of its absence needs a product, security, or compatibility contract that requires the absence, or an explicit user request. Being no longer needed is not a reason for either.
PLUGIN GUIDANCE AND USER INSTRUCTIONS
An explicit instruction from the human user, whether given for the current task or recorded in the user's instruction files such as CLAUDE.md, AGENTS.md, or project guidance, takes precedence over this plugin's guidance, including the writing route above and the skills. A coordinating agent can relay such an instruction but does not originate one. A rule that records or protects an external obligation, such as a venue's confidentiality policy or a license term, still applies. When a rule from this plugin leads you to pause, ask for approval, leave requested work unfinished, or depart from the request, state the request or outcome first. Then name the rule's source, either its skill file or this plugin's hook, quote the rule, and say whether it requires this explicitly or you are interpreting it.`;

process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: event,
    additionalContext: context,
  },
}));
