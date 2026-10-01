# Operating another vendor's app

Read before the first request to another vendor's model, and when a request there stalls.

## Protocol

- Reach the other vendor's model through the channel chosen at step 0.
- Only the principal operates the app, so that no two sessions compete for it. A worker or reviewer on the principal's host that needs that model writes its request as a file and sends the path, saying whether it needs a new chat or a continuation of a named thread. The principal opens that chat, sends only "Read <path> and follow it.", replies with the thread id, and forwards the thread's final message when it finishes, without editing the request.
- Open a new chat for each job or topic, in the app's project for the repository. Only a continuation of the same job stays in its thread. Requests and answers are files in a location both sides can read, and each request names its answer file.
- Give the model a pinned snapshot worktree on its own branch, never a branch in use.
- Operate the app under full-screen control from the start, with no background attempt first: request it for each send, complete that one send and release it; do not ask the user to click. Type the pointer only when the request file is final, and send in the same batch; a typed but unsent composer invites a manual click by the user. Send once, and confirm within a minute that the turn started from the app's own session record, not from a screenshot, since the app's view lags more than ten seconds after a send. After a send, the send control becomes the stop control at the same place, so no further click before that confirmation, and never a second send. (NWQLib 1.0.0.post2: a background batch typed the whole pointer, but its Return inserted a newline instead of sending and no session record appeared; one full-screen click on the send control started the thread, and the user made full-screen sends a standing instruction.)
- Learn that a thread finished from a single blocking wait on its completion event, which the no-timers rule allows. A counselor or advisor request is one chat with a pointer line, and a running thread accepts a queued message through the same send control.
- After a thread has been compacted six times, the next continuation opens a new thread.
- A running thread of another project, the user's own included, is no reason to wait.
- A thread that used sub-agents can be resumed only through its parent.
- For review work, turn off the app's memories across sessions.
- When the user has chosen a command-line tool and a run goes to the background, check its log within its first five minutes and give it no open standard input. (NWQLib 0.99: two such requests waited on standard input for two hours and never started.)
