---
name: research-explainer-animation
description: Plan, script, animate, and check narrated explainer videos of research papers, code repositories, or scientific methods, with voiceover and burned-in subtitles. Use for paper explainer videos, animated abstracts, programmatic animations such as Manim, and revisions of such videos. A single static figure or diagram uses figure-designer.
---

# Research explainer animation

Make a short narrated video that explains one piece of research to a scientifically literate viewer who has not read it. Treat the video as a publication about the work. Every claim, number, equation, and plotted curve must trace to the source, and the rendered video must be inspected before delivery.

## Prepare from the source

1. Read the whole source. For a paper, include the tables, figure captions, and appendices behind the numbers you will quote. For a repository without a paper, read its README, documentation, examples, and tests, and explain only behavior the code supports.
2. Write a claim map before the script. Cover the problem, why it is hard, the key idea, what is new relative to cited prior work, how the method works block by block, the results with their conditions, and the stated limitations. Record the table, section, or file behind each number, and mark derived numbers, such as a percentage computed from two table entries, as derived.
3. Plot real data. Look for the authors' data and code, including repositories named in the paper and the user's local copies. Before using a plotted quantity, trace it to its data and recompute any derived value or fit from that data. Compare the traced or recomputed values with the reported ones. Rerun an expensive simulation or experiment only with the user's approval. Label schematic inputs as illustrative.
4. Find the destination project's existing animation pipeline and style module and reuse them, so a new video matches earlier ones. The project's own guidance supplies paths, environment and build commands, and the way videos attach to a page. Resolve the toolchain from the project's declarations before running code.

## Script the narration

- Aim for the shortest video that carries the problem, the idea, the method, the evidence, and the scope. A paper typically needs three to four and a half minutes, about 450 to 600 spoken words.
- Follow the claim map: problem, obstacle, idea, mechanism, evidence, comparison and trade-offs, then a takeaway. Credit prior work where the method builds on it, and state the contribution in the paper's own terms. Carry the paper's hedges and conditions into the narration.
- Narration and on-screen text are durable prose. Apply `research-writing-style`, including its mandatory review, before synthesis.
- Split the script into segments of one to four sentences. Each sentence has subtitle text and, when needed, separate spoken text that spells out acronyms, reads symbols aloud, or overrides a pronunciation.
- Use the voice the user chose for earlier videos. Without a recorded choice, synthesize one short passage with a few candidate voices, send the samples, and let the user choose. Record the choice where the project keeps such decisions.

Read [production pipeline](references/production-pipeline.md) for the synthesis, timing, rendering, subtitle, and encoding architecture and its known failure modes. Read [house style](references/house-style.md) for the default visual and audio style.

## Animate

- Give each sentence one visual idea, and start its animation when that sentence starts, using timings measured from the synthesized audio.
- Keep color roles, typography, section labels, the title card, the closing card, and the subtitle strip consistent across videos.
- Typeset equations with a math typesetter and draw plots from data. Show units, uncertainty with its statistic, and true minus signs.
- Build a separate poster still with large elements that stays legible at thumbnail width.

## Check before delivery

These checks are required. A narrated video can fail silently in ways that a successful render does not reveal.

- Inspect the whole render as contact sheets, for example one frame every four or five seconds, and inspect dense frames at full size. Look for clipped or overlapping text, labels drawn over axes, incomplete formulas such as missing fraction bars, and objects that separate from the data they represent during motion.
- Confirm that every subtitle line has narration under it and that subtitle starts align with speech onsets.
- Compare every number on screen and in the narration with the claim map.
- When the video is embedded in a site, build the site, run its tests, and check the page and the player at desktop and phone widths.
- The agent cannot hear the audio. Ask the user to listen for pronunciation and pacing, and name the words most at risk.

## Deliver and revise

Send the finished video with its length, summarize its content and data sources, and list what the user should still check by ear or by eye. For a timestamped comment, locate the frame, fix the cause rather than the single frame, and search the rest of the video, and other videos built with the same pipeline, for the same defect.
