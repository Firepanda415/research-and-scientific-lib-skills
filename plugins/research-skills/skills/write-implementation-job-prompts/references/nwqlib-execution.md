Use the actual project toolchain and ensure checks import the target checkout
when shadowed installations are possible. For NWQLib and its linked worktrees,
resolve the external project-guidance directory from the user's current project
instructions, then read its live `BASELINE.md` and `ENVIRONMENT.md`;
carry the checked external runner and exact full ref/SHA into every required
Python, pytest, Ruff, notebook, and build command. Consult the relevant current
onboarding and delivery rules in `COLLABORATION.md` as the prompt author, and
direct the implementer to `IMPLEMENTER-NOTES.md` in that same directory.
These external project records are not shipped with this plugin. Resolve their
actual locations before issuing an NWQLib job; do not invent replacement rules.
Resolve historical engine/worktree assumptions against the user's current
instructions and the live baseline/environment; do not copy stale commands.
Keep this project machinery in the NWQLib handoff rather than forcing it on
other projects.
