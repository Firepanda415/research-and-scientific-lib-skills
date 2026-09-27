# Physics-from-Math Explainer

## Contents

1. Knowledge-gap and language guidance
2. Exact, approximate, and effective statement labels
3. Hidden assumptions and derivation chains
4. Mathematical and physical interpretations
5. Markdown study-note formatting
6. Operator, RWA, and Hamiltonian-reduction templates
7. Quality checklist

## When to use

Key judgment points once the skill is triggered:

- The user says the knowledge gap may be large, or asks for hidden assumptions: insert a prerequisite block before deriving anything.
- The user asks whether a Hamiltonian is hardware-native or only an effective Hamiltonian: label the status of every equation explicitly.
- For requested Markdown study notes, use the relevant parts of the note structure and keep them copy-paste safe. Ordinary questions should receive a direct answer at the requested depth.

---

## Output language and terminology

Write in the user's language. In a non-English answer, keep technical terms from quantum mechanics, operator theory, and superconducting circuits in English by default (e.g. operator, commutator, Fock state, rotating frame, RWA, effective Hamiltonian, detuning, anharmonicity), unless the user prefers translated terms. Translate ordinary and elementary mathematical words.

---

## Core response structure

Use the following components for requested study notes. Select only those needed for the explanation; the section sequence is not mandatory.

### 0. Knowledge gap assessment

Start by saying whether the knowledge gap is large.

If the gap is manageable, state what hidden assumptions need to be made explicit.

Example structure:

```markdown
## 0. Knowledge gap assessment

Not too large, but a few premises that physics texts usually leave implicit need stating first:

1. ...
2. ...
3. ...
```

If the gap is large, insert a short prerequisite block before deriving anything.

---

### 1. State the executable conclusion first

Give the usable result before the derivation.

For example:

```markdown
## 1. Conclusion

For a static single mode with no pump, in the rotating frame of $H_0=\omega N$, RWA reduces to the rule:

$$
(a^\dagger)^r a^s \mapsto \text{keep only if } r=s.
$$
```

Then immediately state the limitation:

```markdown
The general criterion is not $r=s$ but whether the term is slow, or resonant, in the chosen rotating frame.
```

---

### 2. Define all variables before using them

Before any formula, define every symbol that appears in it.

Use compact tables:

```markdown
| Symbol | Meaning |
|---|---|
| $a$ | annihilation operator |
| $a^\dagger$ | creation operator |
| $N=a^\dagger a$ | Fock number operator |
| $\omega$ | oscillator angular frequency |
```

For formulas involving advanced concepts, add one sentence explaining the role of the concept.

---

### 3. Separate exact identities from approximations

Always label the status of equations:

- exact identity
- definition
- approximation
- RWA effective replacement
- convention
- low-energy expansion
- frequency renormalization

Use wording such as:

```markdown
This is not an exact operator equality. It is the effective replacement after RWA in the chosen rotating frame.
```

Use arrows carefully:

```markdown
$$
(a+a^\dagger)^4 \overset{\mathrm{RWA}}{\longrightarrow} 6N(N-1)+12N+3.
$$
```

Do not present approximation arrows as algebraic equality.

---

### 4. Make hidden assumptions explicit

For physics approximations, explicitly list assumptions:

```markdown
This step assumes:

1. single mode
2. weak nonlinearity
3. low excitation
4. no strong pump
5. no unintended resonance
6. $\hbar=1$ unless otherwise stated
```

For RWA, state the actual scale condition:

```markdown
If the dropped term rotates at frequency $\Omega$ and has strength $g$, the step requires:

$$
\lvert g\rvert \ll \lvert \Omega\rvert.
$$
```

---

### 5. Explain the derivation chain in small steps

Use the pattern:

1. Raw Hamiltonian
2. Identify variables
3. Choose frame / picture
4. Expand if needed
5. Introduce ladder operators
6. Normal order if needed
7. Apply RWA
8. Drop constant term
9. Absorb linear term into frequency
10. Define effective coefficient
11. State final effective Hamiltonian
12. State validity conditions

For Josephson-to-Kerr explanations, use this chain. It keeps $H$ in energy units until the explicit division by $\hbar$, and each step names its role or its status label from section 3.

```markdown
Raw Hamiltonian (energy units, Josephson energy $E_J$, charging energy $E_C=e^2/(2C_\Sigma)$ for elementary charge $e$ and total capacitance $C_\Sigma$, Cooper-pair number $n_q$ conjugate to the phase $\varphi$ with $[\varphi,n_q]=i$):

$$
H=4E_Cn_q^2-E_J\cos\varphi.
$$

Low-energy expansion (valid for small phase fluctuations, terms of order $\varphi^6$ and higher dropped):

$$
-E_J\cos\varphi\approx-E_J+\frac{E_J}{2}\varphi^2-\frac{E_J}{24}\varphi^4.
$$

Definition (ladder operators and plasma frequency, chosen so that $[a,a^\dagger]=1$ and the quadratic part of $H$ is diagonal):

$$
\varphi=\left(\frac{2E_C}{E_J}\right)^{1/4}(a+a^\dagger),\qquad n_q=\frac{i}{2}\left(\frac{E_J}{2E_C}\right)^{1/4}(a^\dagger-a),\qquad \hbar\omega_p=\sqrt{8E_JE_C}.
$$

Exact identity (given the definition, with $N=a^\dagger a$):

$$
H_2=4E_Cn_q^2+\frac{E_J}{2}\varphi^2=\hbar\omega_p\left(N+\frac{1}{2}\right).
$$

Exact identity (since $\varphi^4=\frac{2E_C}{E_J}(a+a^\dagger)^4$):

$$
H_4=-\frac{E_J}{24}\varphi^4=-\frac{E_C}{12}(a+a^\dagger)^4.
$$

RWA effective replacement (frame rotating at $\omega_p$, keep terms with equal numbers of $a$ and $a^\dagger$, requires $E_C\ll\hbar\omega_p$):

$$
(a+a^\dagger)^4\overset{\mathrm{RWA}}{\longrightarrow}6a^{\dagger2}a^2+12a^\dagger a+3=6N(N-1)+12N+3.
$$

RWA effective quartic term (constant $-E_C/4$ dropped):

$$
H_4\overset{\mathrm{RWA}}{\longrightarrow}-\frac{E_C}{2}N(N-1)-E_CN.
$$

Effective Hamiltonian after frequency renormalization (constants $-E_J$ and $\hbar\omega_p/2$ dropped, linear term $-E_CN$ absorbed into the frequency):

$$
H_{\mathrm{eff}}=(\hbar\omega_p-E_C)N-\frac{E_C}{2}N(N-1).
$$

Units (divide by $\hbar$, so every coefficient becomes an angular frequency):

$$
\frac{H_{\mathrm{eff}}}{\hbar}=\left(\omega_p-\frac{E_C}{\hbar}\right)N-\frac{E_C}{2\hbar}N(N-1).
$$

Coefficient matching (convention $\frac{H_{\mathrm{eff}}}{\hbar}=\omega_{01}N+\frac{K}{2}N(N-1)$, which defines $\omega_{01}$ and $K$, with $\hbar\omega_{01}=E_1-E_0$ and $\hbar\omega_{12}=E_2-E_1$ for the Fock-state eigenvalues $E_n$ of $H_{\mathrm{eff}}$):

$$
\omega_{01}=\omega_p-\frac{E_C}{\hbar},\qquad K=-\frac{E_C}{\hbar}<0,\qquad \alpha=\omega_{12}-\omega_{01}=K.
$$

Validity conditions:

- $E_J/E_C\gg1$, which gives $E_C\ll\hbar\omega_p$ and small phase fluctuations.
- Low excitation, $\langle n\rvert\varphi^2\lvert n\rangle=\sqrt{2E_C/E_J}\,(2n+1)\ll1$ for every occupied Fock level $n$.
- First order in the $\varphi^4$ term. The $\varphi^6$ term and second-order effects of the discarded quartic terms change $K$ at relative order $\sqrt{E_C/E_J}$.
- Noncompact $\varphi$. This ignores the offset-charge dispersion, which is exponentially small in $\sqrt{8E_J/E_C}$.
```

---

### 6. Give both mathematical and physical interpretations

After deriving an equation, add a short interpretation.

Example:

```markdown
Mathematically, $a$ lowers the eigenvalue of $N$ by 1.

Physically, $a$ removes one excitation, so $N$ counts one fewer excitation after $a$ acts.
```

For circuit variables:

```markdown
$\varphi$ is a coordinate-like (position-like) variable.
$n_q$ is a momentum-like (charge-like) variable.
Here $n_q$ is not the Fock number operator $N=a^\dagger a$.
```

---

### 7. Correct likely misconceptions directly

When the user's statement is almost right but has one important flaw, use:

```markdown
Your understanding is essentially right, with one correction:
```

Then state the correction.

Examples:

```markdown
$4E_Cn_q^2$ is not negligible. Together with $\frac{E_J}{2}\varphi^2$ it forms a harmonic oscillator.
```

```markdown
$r=s$ is not the definition of RWA. It is the simplified rule for the static single-mode case.
```

---

### 8. Include a minimal memory version

End substantial explanations with a compact summary:

```markdown
## Minimal memory version

1. ...
2. ...
3. ...

$$
\text{Josephson cosine}
\rightarrow
\text{Duffing-type quartic Hamiltonian}
\rightarrow
\text{RWA Kerr-type Hamiltonian}.
$$
```

The minimal memory version should contain only equations and rules the user should retain.

---

## Markdown formatting rules

Keep Markdown notes copy-paste safe for the user's target renderer. By default, target a Markdown editor with `$`-delimited math rendering, such as VS Code. When the target renderer needs other math delimiters, such as `\(...\)` and `\[...\]`, use those in place of the defaults below and keep the other rules.

### Inline math

Use `$...$` for inline math by default, rather than `\(...\)`.

### Display math

Use `$$...$$` for all display equations by default, rather than `\[...\]`.

Correct:

```markdown
$$
N\lvert n\rangle=n\lvert n\rangle.
$$
```

Incorrect for the default target:

```markdown
\[
N|n\rangle=n|n\rangle.
\]
```

### Ket notation

Use `\lvert` and `\rangle`.

Correct:

```markdown
$$
\lvert n\rangle
$$
```

Avoid raw `|n\rangle`, especially in Markdown tables, because `|` can be parsed as a table separator.

### Avoid standalone equals signs

Do not put `=` on its own line inside display math, because copying can turn it into a Markdown heading underline.

Avoid:

```markdown
$$
H_{\mathrm{Kerr}}
=
\omega_{\mathrm{eff}}N+\frac{K}{2}N(N-1).
$$
```

Prefer one-line equations:

```markdown
$$
H_{\mathrm{Kerr}}=\omega_{\mathrm{eff}}N+\frac{K}{2}N(N-1).
$$
```

For long equations, use `aligned` with `&=`:

```markdown
$$
\begin{aligned}
H_{\mathrm{Kerr}}
&=\omega_{\mathrm{eff}}N+\frac{K}{2}N(N-1).
\end{aligned}
$$
```

### Avoid indenting display equations inside numbered lists

Prefer:

```markdown
12. RWA gives a Kerr-type nonlinearity:

$$
H_{\mathrm{Kerr}}=\omega_{\mathrm{eff}}N+\frac{K}{2}N(N-1).
$$
```

Do not indent the display math by four spaces unless code block behavior is intended.

### Tables

Use tables for symbol definitions and comparisons.

If a table cell needs ket notation, write:

```markdown
$\lvert n\rangle$
```

not:

```markdown
$|n\rangle$
```

---

## Tone and style

Use a structured, self-study-note style.

Prioritize:

- direct conclusion first
- numbered sections
- compact tables
- explicit assumptions
- derivation in small steps
- formula status labels
- physical intuition after the math
- common pitfalls
- minimal memory version

Avoid:

- vague advice
- excessive conversational filler
- unexplained notation
- hidden approximations
- presenting effective approximations as exact equalities
- long paragraphs without structure
- decorative punctuation

---

## Standard explanation templates

### Template A: Operator identity

```markdown
## 1. Conclusion

$$
\text{target identity}
$$

This step is an exact operator identity / a definition / an effective approximation.

## 2. Variables

| Symbol | Meaning |
|---|---|

## 3. Check on a basis

...

## 4. Derivation by operator algebra

...

## 5. Physical intuition

...

## 6. Minimal memory version

...
```

### Template B: Approximation such as RWA

```markdown
## 0. Knowledge gap assessment

...

## 1. Conclusion

...

## 2. Chosen frame

...

## 3. Term-by-term phase

...

## 4. Condition for keeping a term

...

## 5. Dropped and kept terms

...

## 6. Failure conditions

...

## 7. Minimal memory version

...
```

### Template C: Hamiltonian reduction

```markdown
## 0. Knowledge gap assessment

...

## 1. Raw Hamiltonian

...

## 2. Variables and commutators

...

## 3. Expansion / approximation

...

## 4. Quadratic part

...

## 5. Nonlinear part

...

## 6. RWA / effective Hamiltonian

...

## 7. Coefficient matching

...

## 8. Physical meaning

...

## 9. Validity conditions

...

## 10. Minimal logic chain

...
```

---

## Quality checklist

Before finalizing an answer, check:

1. Are all variables defined before use?
2. Did the answer say whether equations are exact or approximate?
3. Are hidden assumptions listed?
4. Is RWA described as a frame-dependent effective approximation?
5. Is each technical term used in one consistent form, following the terminology rule above?
6. Are display equations using `$$...$$`, or the target renderer's delimiters?
7. Is inline math written with `$...$`, or the target renderer's delimiters?
8. Is ket notation written with `\lvert ...\rangle`?
9. Is there no standalone `=` line?
10. Is there no raw `|n\rangle` inside Markdown tables?
11. Is there a minimal memory version?
12. If the user asks for Markdown notes, is the output copy-paste safe for the target renderer?
