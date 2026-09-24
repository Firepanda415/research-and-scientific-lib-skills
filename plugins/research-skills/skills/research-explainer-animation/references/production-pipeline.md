# Production pipeline

## Architecture

1. A narration module lists ordered segments. Each segment holds sentences with `text` for the subtitle and an optional `say` for speech.
2. Synthesis generates each sentence, trims leading and trailing silence, joins sentences with short gaps, and writes one audio file per segment together with each sentence's start and end time. A cache keyed by voice, speed, gap, and spoken text regenerates only changed segments.
3. A scene base class reads the timing file. Its `voice(segment)` context places the segment's audio at the current scene time, records subtitle cues, offers `until(sentence, fraction)` to wait for a point in the narration, and after the body waits out the rest of the segment plus a pause.
4. The scene renders, followed by a separate poster still.
5. Finishing writes the subtitle cues to an ASS file, burns them in with ffmpeg's libass filter using the bundled fonts, encodes the video, normalizes loudness, checks narration coverage, and exports the poster.
6. Narration, scenes, copied data files, and the source of every number belong in version control. Caches and intermediate renders do not.

## Tools

- Manim Community Edition animates. Typst typesets mathematics when no full TeX distribution is available. The conda-forge `texlive-core` package has TeX binaries but no LaTeX packages or `dvisvgm`, so it cannot serve Manim's LaTeX path.
- ffmpeg with libass burns subtitles and encodes. fontTools converts web fonts such as WOFF to TTF for Pango and libass.
- Kokoro synthesizes speech locally. Its first use downloads about 330 MB of weights from Hugging Face. Use `KPipeline(lang_code="a")` for American English. Print the phoneme string of names, units, and acronyms before a full synthesis, and override a wrong pronunciation inline in the spoken text:

  ```text
  a dilation shared with [Schrödingerisation](/ʃɹˈOdɪŋəɹIzˈAʃən/) and qumodisation
  ```

  In the spoken text, also spell acronyms with spaces ("L C H S") and read symbols as words.
- In a conda environment, install PyTorch from conda-forge. A pip wheel of torch next to conda's numpy loads two OpenMP runtimes and aborts.

## Known failure modes

Each entry gives the symptom, the cause, and the remedy.

1. **Silent narration after a re-render.** Manim's `Scene.add_sound` returns without adding audio when the previous animation came from the render cache. Add audio through the renderer's file writer at the recorded time, and fail the build when any subtitle interval lacks audio.
2. **Missing fraction bars or rules in imported mathematics.** Typst's SVG draws them as stroked paths without fill, which disappear when glyphs are imported with zero stroke width. Convert stroked horizontal rules to filled rectangles and reject any other stroked shape. After such a fix, check every formula in every video, not only the reported frame.
3. **Words run together in `Text`.** Pango collapses spaces at small font sizes. Lay text out at four times the size and scale it down.
4. **Text wraps in previews but not in final renders, or the reverse.** Manim wraps `Text` at the output pixel width and caches the SVG by content, not by width. Lay text out on a wide page and clear the text cache after changing layout parameters. `MarkupText` wraps at a fixed width, so avoid it for long lines and track letters with hair spaces instead.
5. **Objects separate from their data during motion.** `FadeIn`, `Create`, and similar animations applied to an always-redrawn object freeze it at its initial state while its inputs keep changing. Drive an opacity tracker inside the redraw function, or introduce such objects while their inputs are constant.
6. **Duplicate or stale subtitle lines.** Subtitle text drawn inside the scene by an updater can persist in Manim's cached list of moving objects. Burn subtitles in during encoding.
7. **Errors without a TeX installation.** `MathTex`, `Tex`, and `DecimalNumber` need LaTeX. Use typeset SVG for mathematics and regenerated `Text` for changing numbers.
8. **A render hangs after an exception.** Run the scene with `--dry_run` to catch errors quickly, and run long renders under a timeout.
9. **Subtitle lines run off the frame.** A word or character limit does not bound the rendered width, and a font-size change widens every line. Measure each line in the subtitle font and size, for example with Pillow's `ImageFont.getlength`, and split it until it fits.

## Frame with a subtitle strip

Lay out content in Manim's default 14.2 by 8 unit frame. In the scene's setup, enlarge the camera frame height by the strip height, scale the width to keep 16:9, and move the frame center down by half the strip, then draw the strip as a filled rectangle below the design frame. Content shrinks slightly and subtitles never cover it. Keep the strip out of any "clear the stage" helper.

## Checks with ffmpeg

- Contact sheet: `ffmpeg -i video.mp4 -vf "fps=1/4,scale=480:-1,tile=4x4" sheet%02d.png`
- Single frame: `ffmpeg -ss 69 -i video.mp4 -frames:v 1 frame.png`
- Loudness: `ffmpeg -i video.mp4 -af ebur128 -f null -`
- Narration coverage: decode mono audio and compute the RMS level over each subtitle interval. Treat an interval below about −40 dBFS as missing narration.
- Speech onsets: `silencedetect` (for example `noise=-40dB:d=0.4`) finds pauses between segments. Pauses within a segment are shorter, so compare onsets only with subtitle starts that follow a long pause.
