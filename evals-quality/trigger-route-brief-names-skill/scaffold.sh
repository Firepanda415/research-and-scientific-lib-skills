#!/usr/bin/env bash
set -euo pipefail
bash "$(dirname "$0")/../_trigger-fixture/polyevo.sh" before

cat > REQUEST.md <<'EOF'
# Job: long-time evolution for polyevo 1.3

This job prepares polyevo for the long evolutions our users need. It belongs to
the 1.3 release and follows the review of 1.2.0, whose findings are listed below.
Work in this checkout on the current branch. Do not push. A later reviewer checks
the result, so keep commits out of it and leave your changes in the working tree.

Use scientific-computing-correctness for implementation and
scientific-library-review for acceptance.

## Reading

Read `README.md`, `docs/limits.md`, `docs/guide.md` and the modules you change.

## Items

1. **F-12, degree cap.** `plan_evolution` refuses evolutions above about `tau` 180
   unless the user passes `max_degree`, and the users' range goes to 1e5. Remove
   `max_degree` and its default.
2. **F-17, changelog.** Add a 1.3.0 section to `CHANGELOG.md` describing this
   release for users of 1.2.0.
3. **F-21, test.** Keep the existing short-evolution test. Replace the test of the
   old cap with what the new behavior needs.

## Limits

No new dependency. The tests can't be run in this environment, so don't claim
that they passed.

## Report

End with the changes made, what you checked and how, and anything that remains
open, each with its owner. At most about 300 words.
EOF
git add -A
git commit -qm "Add the job request"
