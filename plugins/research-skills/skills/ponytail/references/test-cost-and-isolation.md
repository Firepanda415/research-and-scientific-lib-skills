# Test cost and isolation

Read for tests involving time, concurrency, subprocesses or global state, or for
work on test runtime or flakiness. Preserve the behavior and independent
scientific evidence the tests protect. Use the project's runner, fixtures and
required checks.

## Control the work the test needs

- Use an existing controllable clock for timing logic. Advance it after the work
  has registered its wait, and observe the relevant state or event. A virtual
  clock in one process does not control a child process or real I/O. For those
  paths, wait for observable readiness with an elapsed-time deadline and return
  as soon as the condition holds. A fixed sleep does not establish readiness.
- Keep real subprocesses for process behavior such as signals, exit status,
  stdio and resource release. Exercise parsing and numerical logic in process
  where that preserves the contract. Reuse existing setup without sharing
  mutable state between cases. Count starts and repeated setup when local speed
  hides CI cost.
- Use existing production boundaries and test facilities. A faster test alone
  does not justify a new product flag, timing parameter or reset hook. External
  effects may use a fixture, but the fixture must not supply the behavior under
  test or its numerical expected value.
- Restore environment variables, clocks and other process state, and close
  watchers, files and children before removing their resources. Prefer scoped
  substitutions to global module replacement. A runner-wide isolation or
  concurrency change needs a measured benefit and compatibility with the
  project's execution model, rather than being a workaround for one leaking test.

## Keep the cost proportional to the claim

Use a small case that distinguishes a deterministic defect. Preserve the
independent repetitions, input scale and numerical accuracy needed for a
statistical or performance claim. Operation counts can guard a known work bound
when those operations determine cost. They do not establish wall-clock speed.
Measure latency or throughput in the project's controlled benchmark workflow
when that is the claim, rather than imposing a tight elapsed-time assertion in
an ordinary unit test. Avoid deliberately explosive inputs merely to trigger
the runner's timeout.

Diagnose waits, contention, leaked state and excessive setup before increasing
timeouts, adding retries or skipping a platform. A real operation may need a
larger timeout, and an unsupported platform capability may need a skip, with the
reason stated. Repeated checks should target an unresolved ordering or timing
failure within the authorized budget. Passing required checks ends validation
unless a remaining concern justifies more work.

## Review the change

- The test still exercises the claimed production path and has an independent
  expectation. Reduced input size or repetition still supports its claim.
- Waits observe a state or event, real process boundaries have appropriate
  checks, and cleanup restores the state other tests use.
- Added setup, process starts, repetitions and runner changes have a concrete
  purpose. Claims of speed improvement use a matched before-and-after measure.

Adapted from OpenCode's [unit-tests skill](https://github.com/anomalyco/opencode/blob/097a93e511e2cd7d4fbfc12e0623b721b02f23b9/.opencode/skills/unit-tests/SKILL.md),
Copyright (c) 2025 opencode, under the [MIT notice](../../../LICENSES/OPENCODE-MIT.txt).
The adaptation uses project-defined tools and budgets, preserves scientific
evidence, and judges additional verification by unresolved risk.
