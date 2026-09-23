# Source and Query Map

## Table of contents

1. Source hierarchy and time windows
2. Fresh quantum feed
3. User-tailored topic graph
4. Expected × Unexpected recovery
5. Quantum × AI
6. Hardware, platform, and research infrastructure
7. Candidate verification and search discipline

## Source hierarchy

### Tier 1: Primary technical sources

Use these to support scientific claims:

- arXiv abstract/full text and version history;
- journal or conference paper page;
- DOI landing page and supplementary information;
- official code repository, release notes, documentation, benchmark, or dataset;
- official laboratory or company technical report when it contains inspectable methods and data;
- proof artifact, formal library, or reproducibility package.

### Tier 2: Discovery and attention signals

Use these to find candidates, not as sole evidence:

- SciRate and category popularity lists;
- citation/related-paper graphs;
- author pages and lab publication lists;
- conference programs and workshop schedules;
- scholarly search indexes;
- curated newsletters and expert social posts.

### Tier 3: Context only

News coverage, press releases, and general summaries can explain ecosystem significance but must not substitute for the technical artifact.

## Time windows

- **Fresh:** current date through previous 3 calendar days.
- **Rolling recovery:** 4–60 days before current date.
- **Older than 60 days:** include when requested or when a material trigger or important scientific connection makes recovery useful.

Use first-public date and material-update date separately.

## Lane A: Fresh quantum feed

Search:

- `quant-ph` new submissions and cross-lists;
- relevant physics, computer science, mathematics, and engineering cross-lists;
- major journal recent-publication pages;
- fresh technical platform/software releases;
- community-attention feeds as a discovery signal.

For the fresh window, prefer a direct listing (`https://arxiv.org/list/quant-ph/new`, `https://arxiv.org/list/quant-ph/recent`, or the arXiv API sorted by submission date) over search-engine queries. If only indexed search is available, state in the coverage note that the fresh window may be incomplete.

Query concepts:

```text
quantum computing new paper [date]
site:arxiv.org/abs quantum [topic] [recent date]
site:[journal-domain] quantum [topic]
quantum software release notes [recent date]
```

Do not rank from title or popularity alone.

## Lane B: User-tailored topic graph

### CV-DV and bosonic

```text
continuous-variable qubit hybrid
qumode qubit oscillator hybrid
bosonic quantum algorithm
cavity oscillator ancilla
SNAP displacement state preparation
bosonic error correction hybrid architecture
```

### Differential equations and simulation

```text
linear combination of Hamiltonian simulation LCHS
Schrodingerization non-unitary dynamics
quantum differential equation PDE ODE
Hamiltonian dilation dissipative evolution
block-encoding differential equations
quantum algorithm heat equation
```

### Early fault tolerance and QPE

```text
early fault-tolerant phase estimation
QCELS robust phase estimation
random-walk phase estimation
statistical phase estimation
QPE resource estimation surface code
```

### Quantum chemistry and scientific workflows

```text
ADAPT-VQE operator pool benchmark
quantum chemistry subspace method
GCIM quantum chemistry
UCCSD compiler translator workflow
quantum chemistry resource estimation
scientific quantum software reproducibility
```

### QEC, verification, and trustworthy stacks

```text
quantum error correction formal verification
qLDPC distance certificate
quantum compiler correctness
fault-tolerant circuit verification
QEC design automation
quantum program proof assistant
```

Expand with synonyms, citations, related authors, and neighboring methods. Do not require exact project-name matches.

## Lane C: Expected × Unexpected recovery

Search both quantum and neighboring categories. Useful category families include:

- formal logic, programming languages, and software engineering;
- AI/ML and scientific machine learning;
- control systems and signal processing;
- optimization and operations research;
- numerical analysis and scientific computing;
- coding theory, cryptography, and combinatorics.

Query families:

```text
quantum Lean proof assistant formalization
quantum SAT SMT certificate verified reduction
quantum model checking compiler correctness
quantum program synthesis automated design
quantum control system identification
quantum calibration active learning Bayesian optimization
quantum numerical analysis stability error bound
quantum experiment design autonomous laboratory
quantum reproducibility benchmark limitation negative result
```

When one strong paper appears, follow:

- its authors;
- cited predecessor methods;
- papers that cite it;
- cross-listed categories;
- associated repositories and workshops.

## Lane D: Quantum × AI

Search from both directions.

### AI for Quantum

```text
machine learning quantum error correction decoder
reinforcement learning quantum control calibration
graph neural network QEC decoder
foundation model quantum circuit synthesis
LLM quantum software verification
active learning quantum experiment design
machine learning noise characterization quantum hardware
AI quantum compiler routing
```

### Quantum for AI

```text
fault-tolerant quantum machine learning resource estimate
quantum algorithm machine learning classical baseline
quantum kernel scaling data loading
quantum generative model benchmark
```

### AI-enabled Quantum Science

```text
machine learning discovers quantum protocol
AI quantum physics scientific discovery
generative model quantum code discovery
neural representation quantum many-body experiment
autonomous quantum laboratory
```

Apply the dedicated quality gate. Search results alone do not establish qualification.

## Lane E: Hardware, platform, and research infrastructure

Search:

```text
quantum hardware demonstration paper
quantum SDK compiler simulator release notes
quantum benchmark dataset release
bosonic hardware experiment
fault-tolerant stack software release
quantum resource estimation tool release
```

Prefer versioned technical artifacts and papers over marketing announcements.

## Verification checklist per candidate

Before ranking, locate as many as applicable:

- primary paper;
- version/date history;
- supplementary material;
- code/data/proof artifact;
- strongest baseline;
- scale and hardware/noise assumptions;
- independent commentary or follow-up;
- correction or limitation information.

## Search discipline

- Use broad queries for recall, then narrow with primary-source inspection.
- For broad daily briefs, include recovery beyond the obvious `quant-ph` feed.
- Use both default time horizons unless the requested scope or period differs.
- Search author names when a relevant cluster emerges.
- Keep rejection reasons when needed for a comparison or an authorized tracking workflow; do not create a ledger for ordinary discovery.
- Never treat an abstract aggregator's wording as authoritative when the paper is available.
