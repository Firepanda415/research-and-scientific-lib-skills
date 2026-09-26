#!/usr/bin/env bash
set -euo pipefail
mkdir -p sweep status logs

cat > sweep/PLAN.md <<'EOF'
# Ladder quench sweep (allocation qsim-26b)

Sizes L = 8, 10, 12, 14, 16 (L x 4 ladder), one Slurm job per size, submitted with
`sweep/submit_sweep.sh`.

## What a healthy job looks like

- Phase 1, DMRG ground state. Prints one line at the start and one when it converges,
  nothing in between. Expected duration: L8 about 40 min, L10 1.5 to 3 h, L12 2 to 4 h,
  L14 4 to 7 h. (In the test sweep L10 took 2 h 40 min.)
- Phase 2, TEBD time evolution to t = 40 with 10 checkpoints. Prints one line per
  checkpoint. Checkpoint spacing: L8 about 12 min, L10 and larger about 40 min (plus or
  minus 10). Checkpoints go to /scratch/qsim01/sweep/ckpt/ and are written as
  `<name>.h5.tmp`, then renamed.
- Restart from a checkpoint: `sbatch sweep/job.sbatch L12 --resume ckpt/L12_step0003.h5`.

## Retries and budget

- submit_sweep.sh retries automatically once on OUT_OF_MEMORY with doubled memory.
  Any other retry is my call.
- Allocation: 2,000 node-hours, about 1,310 used as of 2026-09-25 20:00.

## Validation

After all sizes finish I run `validate_sweep.py` (energy drift below 1e-3, truncation
below 1e-6). Nothing is validated before that.

## Log

- 2026-09-25 22:10: I put 1005 (L16) on hold myself. I want to look at the L14 memory
  profile before L16 takes 4 nodes for 24 h.
EOF

cat > status/squeue.txt <<'EOF'
$ squeue -u qsim01 -o "%.8i %.12j %.9T %.10M %.11l %.6D %R"     # 2026-09-26 09:30:04
   JOBID         NAME     STATE       TIME  TIME_LIMIT  NODES NODELIST(REASON)
    1001    sweep_L10   RUNNING    2:50:02     8:00:00      1 cn041
    1002    sweep_L12   RUNNING    8:19:53    12:00:00      2 cn[017-018]
    1005    sweep_L16   PENDING       0:00    24:00:00      4 (JobHeldUser)
    1007    sweep_L14   PENDING       0:00    16:00:00      4 (Resources)
EOF

cat > status/sacct.txt <<'EOF'
$ sacct -X -S 2026-09-25T20:00 -o JobID,JobName,State,ExitCode,Start,End,Elapsed,ReqMem   # 09:30:20
JobID     JobName     State       ExitCode  Start                End                  Elapsed   ReqMem
1001      sweep_L10   RUNNING     0:0       2026-09-26T06:40:02  Unknown              02:50:18  64G
1002      sweep_L12   RUNNING     0:0       2026-09-26T01:10:11  Unknown              08:20:09  128G
1003      sweep_L8    COMPLETED   0:0       2026-09-26T05:02:40  2026-09-26T07:55:31  02:52:51  32G
1004      sweep_L14   OUT_OF_ME+  0:125     2026-09-25T23:58:09  2026-09-26T04:12:44  04:14:35  256G
1005      sweep_L16   PENDING     0:0       Unknown              Unknown              00:00:00  512G
1007      sweep_L14   PENDING     0:0       Unknown              Unknown              00:00:00  512G
EOF

cat > status/sstat.txt <<'EOF'
$ sstat -j 1001,1002 -o JobID,AveCPU,MaxRSS     # 2026-09-26 09:30:31
JobID          AveCPU      MaxRSS
1001.batch     02:49:40    41.2G
1002.batch     05:37:58    97.8G

$ sstat -j 1001,1002 -o JobID,AveCPU,MaxRSS     # 2026-09-26 09:40:33
JobID          AveCPU      MaxRSS
1001.batch     02:59:38    41.3G
1002.batch     05:37:58    97.8G
EOF

cat > status/ckpt_ls.txt <<'EOF'
$ ls -l --time-style=+%m-%d_%H:%M /scratch/qsim01/sweep/ckpt/     # 09:31
-rw-r--r-- 1 qsim01 qsim 1.1G 09-26_07:07 L8_step0006.h5
-rw-r--r-- 1 qsim01 qsim 1.1G 09-26_07:19 L8_step0007.h5
-rw-r--r-- 1 qsim01 qsim 1.1G 09-26_07:31 L8_step0008.h5
-rw-r--r-- 1 qsim01 qsim 1.1G 09-26_07:43 L8_step0009.h5
-rw-r--r-- 1 qsim01 qsim 1.1G 09-26_07:55 L8_step0010.h5
-rw-r--r-- 1 qsim01 qsim 6.2G 09-26_04:45 L12_step0001.h5
-rw-r--r-- 1 qsim01 qsim 6.2G 09-26_05:26 L12_step0002.h5
-rw-r--r-- 1 qsim01 qsim 6.2G 09-26_06:07 L12_step0003.h5
-rw-r--r-- 1 qsim01 qsim 3.1G 09-26_06:48 L12_step0004.h5.tmp
EOF

cat > logs/sweep_L8.log <<'EOF'
[05:02:44] sweep_L8 start: 8x4 ladder, chi_max=512, dt=0.01, t_final=40, commit 5be21a0
[05:02:45] phase 1: DMRG ground state
[05:41:10] phase 1 done: E0 = -35.402118, max truncation 3.0e-10
[05:41:11] phase 2: TEBD time evolution, 10 checkpoints
[05:55:02] t=4.00   checkpoint 1/10 written
... (checkpoints 2/10 to 9/10 every 12 min, omitted)
[07:55:05] t=40.00  checkpoint 10/10 written
[07:55:20] WARNING: energy drift |E(t)-E0|/|E0| = 3.2e-02 at t=40.00 exceeds tolerance 1.0e-03
[07:55:29] results written to out/L8.h5
[07:55:30] done
EOF

cat > logs/sweep_L10.log <<'EOF'
[06:40:05] sweep_L10 start: 10x4 ladder, chi_max=768, dt=0.01, t_final=40, commit 5be21a0
[06:40:06] phase 1: DMRG ground state
EOF

cat > logs/sweep_L12.log <<'EOF'
[01:10:14] sweep_L12 start: 12x4 ladder, chi_max=1024, dt=0.01, t_final=40, commit 5be21a0
[01:10:15] phase 1: DMRG ground state
[04:04:40] phase 1 done: E0 = -53.118274, max truncation 2.1e-9
[04:04:41] phase 2: TEBD time evolution, 10 checkpoints
[04:45:20] t=4.00   checkpoint 1/10 written
[05:26:02] t=8.00   checkpoint 2/10 written
[06:07:41] t=12.00  checkpoint 3/10 written
[06:48:09] t=16.00  writing checkpoint 4/10 to /scratch/qsim01/sweep/ckpt/L12_step0004.h5.tmp
EOF

cat > logs/sweep_L14.log <<'EOF'
[23:58:12] sweep_L14 start: 14x4 ladder, chi_max=1280, dt=0.01, t_final=40, commit 5be21a0
[23:58:13] phase 1: DMRG ground state
slurmstepd: error: Detected 1 oom_kill event in StepId=1004.batch. Some of your processes may have been killed by the cgroup out-of-memory handler.
EOF

cat > logs/submit_wrapper.log <<'EOF'
[2026-09-25 23:57:40] submitted sweep_L14 as job 1004 (--mem=256G, --nodes=4, --time=16:00:00)
[2026-09-26 04:13:02] job 1004 (sweep_L14) ended OUT_OF_MEMORY; auto-retry 1/1 with --mem=512G: submitted job 1007
EOF
