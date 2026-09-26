#!/usr/bin/env bash
set -euo pipefail
mkdir -p scratch runs

cat > scratch/2026-09-26-raw.txt <<'EOF'
sep 26
- XXZ chain L=40, Jz=1.5, open bc, Neel initial state. TEBD 2nd order, dt=0.02, t_final=10. commit c41f9e2
- chi=64 run: relative energy drift creeps up after t~6, 2.1e-3 at t=10 (runs/tebd_chi64.log)
- prob truncation?? chi too small
- reran with chi=128 (runs/tebd_chi128.log): drift 2.0e-3 at t=10, basically the same. discarded weight way smaller though, see log
- staggered magnetization: chi64 and chi128 agree to ~1e-5 up to t=5 (didn't compare later times)
- try dt=0.01 tomorrow? also compare magnetization past t=5
- wall time: chi64 ~40 min, chi128 ~3.1 h, 16 cores
EOF

cat > runs/tebd_chi64.log <<'EOF'
# tebd.py commit c41f9e2 | model=xxz L=40 Jz=1.5 bc=open init=neel | order=2 dt=0.02 t_final=10 | chi_max=64 | 16 threads
t      rel_energy_drift   max_discarded_weight
2.0    3.1e-06            4.2e-09
4.0    2.4e-05            1.8e-08
6.0    2.9e-04            7.5e-08
8.0    1.1e-03            2.3e-07
10.0   2.1e-03            3.4e-07
wall 00:41:12
EOF

cat > runs/tebd_chi128.log <<'EOF'
# tebd.py commit c41f9e2 | model=xxz L=40 Jz=1.5 bc=open init=neel | order=2 dt=0.02 t_final=10 | chi_max=128 | 16 threads
t      rel_energy_drift   max_discarded_weight
2.0    3.0e-06            1.1e-12
4.0    2.3e-05            6.0e-12
6.0    2.8e-04            2.2e-11
8.0    1.0e-03            5.9e-11
10.0   2.0e-03            9.7e-11
wall 03:06:40
EOF
