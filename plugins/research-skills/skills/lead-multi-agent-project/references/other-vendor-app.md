# Operating another vendor's app

Read before the first request to another vendor's model, and when a request there stalls.

## Protocol

- Reach the other vendor's model through the channel chosen at step 0.
- Only the principal operates the app, so that no two sessions compete for it. A worker or reviewer on the principal's host that needs that model writes its request as a file and sends the path, saying whether it needs a new chat or a continuation of a named thread. The principal opens that chat, sends only "Read <path> and follow it.", replies with the thread id, and forwards the thread's final message when it finishes, without editing the request.
- Route related work to its active role thread in the repository's app project. Use a new thread when an owner first joins, has ended or reached a limit, or the review requires fresh eyes. Follow explicit user, project and host session rules. Put requests and answers in a shared location and name the answer file in each request.
- Give the model a pinned snapshot worktree on its own branch, never a branch in use.
- Operate the app under background control, never full-screen: full-screen approval is a separate prompt that interrupts the user, and a bypass permission mode does not cover it. Do not ask the user to click. If background control cannot send, try another route that needs no approval, then report the blocked step. Type the pointer only when the request file is final, and send in the same batch; a typed but unsent composer invites a manual click by the user. Send with one click on the displayed send control, because Return can insert a newline instead of sending. Confirm within a minute that the turn started from the app's own session record, not from a screenshot or the click's result, since the app's view lags more than ten seconds after a send. After a send, the send control becomes the stop control at the same place, so no further click before that confirmation, and never a second send. (NWQLib 1.0.0.post2: a typed pointer's Return inserted a newline and no session record appeared.)
- Receive completion through the host event. While the principal has independent work, let it continue and collect returned reports at a work boundary. A single blocking wait is appropriate when the result is the next dependency. Send a pointer to the request file in the selected role thread.
- After a thread has been compacted six times, the next continuation opens a new thread.
- A running thread of another project, the user's own included, is no reason to wait.
- A thread that used sub-agents can be resumed only through its parent.
- For review work, turn off the app's memories across sessions.
- When the user has chosen a command-line tool and a run goes to the background, check its log within its first five minutes and give it no open standard input. (NWQLib 0.99: two such requests waited on standard input for two hours and never started.)
