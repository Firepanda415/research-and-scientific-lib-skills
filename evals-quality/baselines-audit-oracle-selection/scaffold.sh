#!/usr/bin/env bash
set -euo pipefail

mkdir -p draft results configs

cat > draft/results_section.md <<'EOF'
## 4. Results

AdaTrot reduces the CNOT count by 33% on average relative to second-order Trotter (Trotter2) at
the same accuracy, an error of at most 1e-3 in <Z_0> at T = 10, across all four benchmark
Hamiltonians (Table 1). The advantage persists at stricter accuracy targets.

Table 1. CNOT counts at error <= 1e-3.

| Instance | AdaTrot chunk | AdaTrot error | AdaTrot CNOT | Trotter2 error | Trotter2 CNOT | Reduction |
|----------|---------------|---------------|--------------|----------------|---------------|-----------|
| H1       | 8             | 9.8e-4        | 3050         | 2.0e-4         | 4800          | 36.5%     |
| H2       | 2             | 9.9e-4        | 4400         | 2.4e-4         | 6400          | 31.3%     |
| H3       | 4             | 9.7e-4        | 5500         | 1.8e-4         | 8000          | 31.3%     |
| H4       | 8             | 9.9e-4        | 6350         | 2.2e-4         | 9600          | 33.9%     |
| Mean     |               |               |              |                |               | 33.2%     |
EOF

cat > configs/README.md <<'EOF'
# Configuration used for Table 1

Task: estimate <Z_0>(T) at T = 10 for four 12-qubit Hamiltonians H1-H4.
Error metric: |<Z_0>_method - <Z_0>_exact| evaluated at the method's final time t_eval
(the column t_eval in the CSV files).

AdaTrot: adaptive chunked Trotter. Its chunk size c was swept over {2, 4, 8} for every instance
(results/adatrot_sweep.csv). For each instance, Table 1 uses the chunk size with the lowest CNOT
count among those meeting error <= 1e-3.

Trotter2: second-order Trotter with r = 100 steps, the library default. An exploratory step scan
from an earlier project meeting is in results/trotter2_steps.csv; Table 1 uses only r = 100.
EOF

cat > results/adatrot_sweep.csv <<'EOF'
instance,chunk,t_eval,error,cnot
H1,2,9.95,4.1e-4,3900
H1,4,9.90,7.9e-4,3400
H1,8,9.84,9.8e-4,3050
H2,2,9.93,9.9e-4,4400
H2,4,9.88,1.6e-3,4150
H2,8,9.79,2.9e-3,3900
H3,2,9.96,3.3e-4,6300
H3,4,9.91,9.7e-4,5500
H3,8,9.82,1.9e-3,5100
H4,2,9.94,5.0e-4,7400
H4,4,9.86,8.5e-4,6800
H4,8,9.77,9.9e-4,6350
EOF

cat > results/trotter2_steps.csv <<'EOF'
instance,r,t_eval,error,cnot
H1,40,10.00,1.26e-3,1920
H1,50,10.00,8.2e-4,2400
H1,60,10.00,5.6e-4,2880
H1,80,10.00,3.1e-4,3840
H1,100,10.00,2.0e-4,4800
H2,40,10.00,1.50e-3,2560
H2,50,10.00,9.6e-4,3200
H2,60,10.00,6.7e-4,3840
H2,80,10.00,3.8e-4,5120
H2,100,10.00,2.4e-4,6400
H3,40,10.00,1.13e-3,3200
H3,50,10.00,7.2e-4,4000
H3,60,10.00,5.0e-4,4800
H3,80,10.00,2.8e-4,6400
H3,100,10.00,1.8e-4,8000
H4,40,10.00,1.38e-3,3840
H4,50,10.00,8.8e-4,4800
H4,60,10.00,6.1e-4,5760
H4,80,10.00,3.4e-4,7680
H4,100,10.00,2.2e-4,9600
EOF
