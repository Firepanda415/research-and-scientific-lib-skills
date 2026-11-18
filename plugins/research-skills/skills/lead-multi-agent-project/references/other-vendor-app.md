# Operating another vendor's app

Read before the first request to another vendor's model, and when a request there stalls.

## Protocol

- Reach the other vendor's model through the channel chosen at step 0.
- Only the principal operates the app, so that no two sessions compete for it. A worker or reviewer on the principal's host that needs that model writes its request as a file and sends the path, saying whether it needs a new chat or a continuation of a named thread. The principal opens that chat, sends only "Read <path> and follow it.", replies with the thread id, and forwards the thread's final message when it finishes, without editing the request.
- Route related work to its active role thread in the repository's app project. Use a new thread when an owner first joins, has ended or reached a limit, or the review requires fresh eyes. Follow explicit user, project and host session rules. Put requests and answers in a shared location and name the answer file in each request.
- Give the model a pinned snapshot worktree on its own branch, never a branch in use.
- Use background control. Full-screen control interrupts the user with a separate approval even in bypass mode. If background control cannot send, try another route that needs no approval, then report the blocked step. Do not ask the user to click.
- In the target thread, enter the pointer when the request file is final. Send once in the same batch using the displayed control for the current composer state ([Claude Code on macOS](#claude-code-desktop-on-macos)), since Return can insert a newline. Within a minute, confirm in the target session's message log that the instruction reached the intended turn. For a file handoff, also verify a recorded read or an acknowledgement specific to the file's contents.
- Receive completion through the host event. While the principal has independent work, let it continue and collect returned reports at a work boundary. A single blocking wait is appropriate when the result is the next dependency.
- After a thread has been compacted six times, the next continuation opens a new thread.
- A running thread of another project, the user's own included, is no reason to wait.
- A thread that used sub-agents can be resumed only through its parent.
- For review work, turn off the app's memories across sessions.
- When the user has chosen a command-line tool and a run goes to the background, check its log within its first five minutes and give it no open standard input. (NWQLib 0.99: two such requests waited on standard input for two hours and never started.)

## Claude Code desktop on macOS

Check the composer hint in the target session. If the user sent a queued message manually, check the session log before taking any further action. In the tested macOS app, Command+Enter sends from an idle composer and queues the message during an active turn. For immediate delivery, use the displayed **Send** action for an unsent instruction or **Send now** on its queued copy. The desktop view can lag after delivery and **Stop** can take the place of **Send**, so verify receipt in the log before touching that control again.
