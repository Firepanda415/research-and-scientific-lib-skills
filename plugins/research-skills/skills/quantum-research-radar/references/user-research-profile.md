# User Research Profile

## Table of contents

1. Primary and adjacent research priorities
2. Down-ranking and relevance tests
3. Explanation and language preferences
4. Selection balance and editable emphasis

This profile controls relevance ranking and explanation depth. It intentionally contains research preferences rather than administrative or personal details.

## Primary research priorities

### Tier 1: Highest priority

1. **CV-DV hybrid quantum computing**
   - qumode–qubit and oscillator–qubit architectures;
   - bosonic state preparation, measurement, and truncation;
   - cQED-relevant interactions and hardware-native operations;
   - CV ancillae used to reduce DV register or oracle overhead.

2. **Quantum differential equations and non-unitary dynamics**
   - LCHS;
   - PDE/ODE solvers;
   - Schrödingerization, dilation, and kernel constructions;
   - Hamiltonian simulation and block-encoding;
   - error budgets, truncation, success probability, and resource scaling.

3. **Early fault-tolerant algorithms and phase estimation**
   - QPE, QCELS, RWPE, statistical/robust phase estimation;
   - time-to-solution and algorithmic error;
   - realistic early-FTQC resource models;
   - distributed or heterogeneous execution when technically meaningful.

4. **Quantum chemistry algorithms and scientific applications**
   - ADAPT-VQE and operator-pool design;
   - subspace/GCIM-style methods;
   - UCCSD and chemistry workflow translation;
   - strong classical baselines, convergence, and resource analysis.

5. **QEC, fault tolerance, and trustworthy quantum stacks**
   - qLDPC and decoder work;
   - code/circuit design automation;
   - formal verification, proof assistants, certificates, and compiler correctness;
   - resource estimation and end-to-end reliability.

6. **Scientific quantum software and reproducible workflows**
   - reusable libraries and user-facing APIs;
   - translators, compilers, simulators, validation data, and reporting;
   - benchmark quality, test coverage, failure analysis, and reproducibility.

### Tier 2: Strong adjacent interest

- error mitigation when it affects near-term scientific workflow;
- quantum control, calibration, tomography, and noise diagnosis;
- hardware demonstrations with implications for bosonic/hybrid or early-FTQC algorithms;
- numerical analysis, optimization, formal methods, and software engineering imported into quantum research;
- meaningful AI for quantum science, especially decoding, control, compiler/synthesis, experiment planning, scientific discovery, and research workflow automation.

## Down-rank unless unusually strong

- generic QAOA or variational benchmarks with little mechanism;
- tiny QML classification demonstrations;
- quantum advantage claims without end-to-end resources;
- platform announcements without technical evidence;
- papers whose only connection is a shared keyword;
- minor benchmark gains without ablation or failure analysis;
- generic LLM-for-quantum demos without execution or verification.

## Relevance tests

A paper can be highly relevant in four different ways:

1. **Direct:** it studies the same algorithm, architecture, or application.
2. **Method transfer:** it supplies a reusable theorem, numerical method, compiler, verification technique, or experiment design.
3. **Baseline or falsification:** it provides a comparison, limitation, or negative result that changes how current work should be evaluated.
4. **Roadmap constraint:** it changes credible hardware, QEC, error, or resource assumptions.

Do not restrict tailored picks to direct topical overlap.

## Explanation depth

- Assume strong quantum-computing and DV background.
- Explain CV-specific, hardware-specific, formal-methods, and specialized QEC concepts from first principles when needed.
- Preserve advanced technical terms in English inside Chinese prose.
- Be mathematically precise, but keep a daily brief compact; reserve derivations for requested deep dives.
- Separate the paper's claim from the briefing's interpretation.

## Language and format preferences

- Main prose: Chinese.
- Keep important terms such as `spectrum`, `nondegenerate`, `block-encoding`, `decoder`, `proof assistant`, and `formal verification` in English.
- Use direct paper links and immediately usable formatting.
- Prefer mechanism, evidence, limitations, and research implications over abstract paraphrase.

## Selection balance

When quality permits, avoid a brief composed entirely of one subfield. A useful full brief often combines:

- one direct algorithm/theory item;
- one hardware or architecture item;
- one QEC/reliability/software item;
- one E×U recovery;
- one broad high-impact quantum item;
- a Q×AI item only when it passes the gate.

This is a balance preference, not a quota.

## User-editable emphasis

For a specific run, explicit user instructions override this default profile. Examples:

- “今天重点看 PDE 和 Hamiltonian simulation”;
- “只做 QEC recovery scan”;
- “Quantum × AI 单独多找一些，但保持质量门槛”;
- “这次不考虑我的工作，只评 paper 本身”.
