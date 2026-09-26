#!/usr/bin/env bash
set -euo pipefail
mkdir -p explainer tests/data videos/kerr_intro videos/lchs_overview

cat > README.md <<'EOF'
# Group explainer videos

Shared pipeline in `explainer/`; one folder per video in `videos/`.

| Video         | Version | Status                      |
|---------------|---------|-----------------------------|
| lchs_overview | v2      | published on the group site |
| kerr_intro    | v3      | in review                   |

Build a video with `python -m explainer.build videos/<name>` (needs Manim CE, Typst and
ffmpeg with libass; these are installed on the render workstation only).

Formulas are written in Typst in each video's `narration.py`, rendered to SVG by Typst,
and imported with `explainer/mathsvg.py`. Subtitles are split into lines by
`explainer/subtitles.py` and burned in with libass.

Unit tests: `python3 -m unittest discover -s tests`

Changes in v3: subtitle font size raised from 40 px to 46 px for phone viewing.
EOF

cat > explainer/__init__.py <<'EOF'
EOF

cat > explainer/mathsvg.py <<'EOF'
"""Import Typst-rendered SVG formulas as shape specs for the Manim scenes.

Typst exports each glyph as a filled outline. Every shape is imported filled with the
formula color and with zero stroke width, so glyph outlines do not look bold.
"""
import xml.etree.ElementTree as ET

SVG_NS = "{http://www.w3.org/2000/svg}"


def load_shapes(svg_text):
    """Return one dict per <path> or <rect> element of a Typst SVG."""
    shapes = []
    for el in ET.fromstring(svg_text).iter():
        tag = el.tag.replace(SVG_NS, "")
        if tag not in ("path", "rect"):
            continue
        shapes.append({
            "tag": tag,
            "d": el.get("d"),
            "x": float(el.get("x", 0)),
            "y": float(el.get("y", 0)),
            "width": float(el.get("width", 0)),
            "height": float(el.get("height", 0)),
            "fill": el.get("fill", "#000000"),
            "stroke": el.get("stroke"),
            "stroke_width": float(el.get("stroke-width", 0)),
        })
    return shapes


def to_specs(shapes, color):
    """Convert shapes to the dicts consumed by the scene's formula() helper."""
    specs = []
    for s in shapes:
        filled = s["fill"] != "none"
        spec = {k: s[k] for k in ("tag", "d", "x", "y", "width", "height")}
        spec.update({
            "fill_color": color if filled else None,
            "fill_opacity": 1.0 if filled else 0.0,
            "stroke_width": 0.0,
        })
        specs.append(spec)
    return specs
EOF

cat > explainer/subtitles.py <<'EOF'
"""Split narration sentences into subtitle lines for the burned-in ASS track."""

FONT = "IBM Plex Sans"
FONT_SIZE_PX = 46  # raised from 40 in v3
MAX_CHARS = 70     # keeps each line inside the 1760 px subtitle box at 1080p


def split_lines(text, max_chars=MAX_CHARS):
    """Greedily fill lines word by word up to max_chars characters."""
    lines, current = [], ""
    for word in text.split():
        candidate = f"{current} {word}".strip()
        if len(candidate) <= max_chars:
            current = candidate
        else:
            lines.append(current)
            current = word
    if current:
        lines.append(current)
    return lines
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/data/kerr_K.svg <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 60 30" width="60pt" height="30pt">
  <g fill="#000000">
    <path d="M 1 10 L 5 10 L 5 18 L 1 18 Z"/>
    <path d="M 8 13 L 13 13 L 13 15 L 8 15 Z"/>
    <path d="M 24 3 L 32 3 L 32 11 L 24 11 Z"/>
    <path d="M 25 17 L 31 17 L 31 26 L 25 26 Z"/>
  </g>
  <path d="M 22 14 L 34 14" fill="none" stroke="#000000" stroke-width="0.6"/>
</svg>
EOF

cat > tests/test_mathsvg.py <<'EOF'
import unittest
from pathlib import Path

from explainer.mathsvg import load_shapes, to_specs

SVG = (Path(__file__).parent / "data" / "kerr_K.svg").read_text()


class GlyphImportTest(unittest.TestCase):
    def test_glyphs_are_filled_without_stroke(self):
        specs = to_specs(load_shapes(SVG), "#242b2d")
        glyphs = specs[:4]
        for spec in glyphs:
            self.assertEqual(spec["fill_color"], "#242b2d")
            self.assertEqual(spec["fill_opacity"], 1.0)
            self.assertEqual(spec["stroke_width"], 0.0)

    def test_every_element_is_imported(self):
        self.assertEqual(len(load_shapes(SVG)), 5)


if __name__ == "__main__":
    unittest.main()
EOF

cat > tests/test_subtitles.py <<'EOF'
import unittest

from explainer.subtitles import MAX_CHARS, split_lines


class SplitLinesTest(unittest.TestCase):
    def test_short_sentence_is_one_line(self):
        self.assertEqual(split_lines("The oscillator is weakly nonlinear."),
                         ["The oscillator is weakly nonlinear."])

    def test_long_sentence_respects_limit(self):
        text = ("The Kerr term shifts each Fock level by an amount that grows with the "
                "number of photons already stored in the mode, so the spectrum is uneven.")
        lines = split_lines(text)
        self.assertGreater(len(lines), 1)
        self.assertTrue(all(len(line) <= MAX_CHARS for line in lines))
        self.assertEqual(" ".join(lines), text)


if __name__ == "__main__":
    unittest.main()
EOF

cat > videos/kerr_intro/narration.py <<'EOF'
"""Narration and formulas for the Kerr oscillator explainer (v3)."""

SEGMENTS = [
    {
        "label": "01 / The model",
        "sentences": [
            {"text": "A transmon behaves like an oscillator whose levels are not evenly spaced.",
             "say": "A trans-mon behaves like an oscillator whose levels are not evenly spaced."},
            {"text": "The spacing shrinks by the Kerr coefficient K at every step up the ladder."},
        ],
        "formulas": ["$H = omega a^dagger a + K / 2 a^dagger a^dagger a a$"],
    },
    {
        "label": "02 / Where K comes from",
        "sentences": [
            {"text": "Expanding the Josephson cosine to fourth order gives the coefficient directly.",
             "say": "Expanding the Josephson cosine to fourth order gives the coefficient directly."},
            {"text": "It is set by the charging energy alone."},
        ],
        "formulas": ["$K = -E_C / planck.reduce$"],
    },
    {
        "label": "03 / Simulating it",
        "sentences": [
            {"text": "We compare KERRSIM-DENSE, WIGNER-MPS and HQM-TEBD at N = 40 levels.",
             "say": "We compare Kerr-sim dense, Wigner M P S and H Q M tebd at forty levels."},
            {"text": "All three agree to within the plotted line width."},
        ],
        "formulas": ["$epsilon = norm(rho - rho_\"ref\") / norm(rho_\"ref\")$"],
    },
]
EOF

cat > videos/lchs_overview/narration.py <<'EOF'
"""Narration and formulas for the LCHS overview explainer (v2, published)."""

SEGMENTS = [
    {
        "label": "01 / The problem",
        "sentences": [
            {"text": "We want the solution of a linear differential equation on a quantum computer.",
             "say": "We want the solution of a linear differential equation on a quantum computer."},
        ],
        "formulas": ["$d / (d t) u = -A u$"],
    },
    {
        "label": "02 / The identity",
        "sentences": [
            {"text": "LCHS writes the non-unitary evolution as an integral of unitary ones.",
             "say": "L C H S writes the non-unitary evolution as an integral of unitary ones."},
            {"text": "The weights decay like a Cauchy distribution, 1 / (pi (1 + k^2))."},
        ],
        "formulas": ["$u(t) = integral_RR 1 / (pi (1 + k^2)) U(t, k) u(0) dif k$"],
    },
]
EOF
