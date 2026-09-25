# Default house style

These defaults keep a series of explainers visually consistent. A destination with its own style module or brand overrides them.

## Frame and pacing

- 16:9 at 1920 by 1080 and 30 frames per second, H.264 video with AAC audio, loudness normalized to −16 LUFS.
- A 14.2 by 8 unit design frame with a 0.9 unit subtitle strip below it.
- A silent title card of about five seconds, narrated sections, and a closing card held about three seconds after the last line.
- Short fades between sections. Motion follows the narration and serves the explanation.

## Color roles

| Role | Hex |
|---|---|
| Background (paper) | `#f6f5f1` |
| Text and neutral lines (ink) | `#242b2d` |
| Secondary text and axes (muted) | `#5b6262` |
| The work's own method or result, key highlights (accent) | `#793e4b` |
| Hairlines and card borders (line) | `#d4d5ce` |
| Subtitle strip and panels (wash) | `#ecece5` |
| Oscillators and continuous-variable quantities (teal) | `#2b6c70` |
| Qubits, quantum hardware, and qubit-only baselines (blue) | `#3d5a86` |
| Classical computation, weights, and reference energies (gold) | `#a06b12` |

Keep each role fixed within a video, and label series so that meaning does not depend on color alone.

## Typography

- Text in IBM Plex Sans, Regular for body and Medium for titles. Section labels are small, upper-case, letter-spaced, in the accent color, and numbered as "01 / Title".
- Mathematics typeset with New Computer Modern Math in ink, with colored parts that follow the color roles.
- On-screen text of at least about 15 points at 1080p for labels and 19 points for sentences, with lines kept within about 12.5 frame units.
- True minus signs (U+2212) in numbers and "±" for uncertainty.

## Title and closing cards

- Title card: venue and year as a section label, the title in two or three lines, the authors with equal-contribution marks as in the paper, and the affiliations. Break a long author list at a name boundary.
- Closing card: a one- or two-sentence takeaway within the paper's scope, then the citation, DOI, arXiv number, and code or data link.

## Subtitles

- One line at a time, no wider than 1760 px at 1080p when measured in the subtitle font, timed in proportion to its length within each narrated sentence and held up to 0.8 s into pauses. Split a longer sentence into balanced lines of at most about 70 characters. Prefer a break after a comma or period, and avoid ending a line on an article, preposition, or conjunction. If a break still separates a value from its unit or splits an expression such as "n − 1", reword the sentence or write the expression without spaces.
- Check that every subtitle character exists in the subtitle font. IBM Plex Sans lacks the superscript minus and the subscript j, so libass draws them from a fallback font or not at all. Write such values as decimals or in words when the fallback looks wrong.
- IBM Plex Sans at 46 px in ink, centered in the subtitle strip.

## Voice

- Kokoro voice `am_puck`, a young male American English voice, at speed 1.08. The user chose this voice, so keep it unless they ask for another.
- Pauses of about 0.28 s between sentences and 0.45 s between segments.

## Poster

A dedicated 1920 by 1080 still with one large equation or diagram, a short label, and no small text. Check it at about 200 px wide, the size of a page thumbnail.
