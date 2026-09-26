#!/usr/bin/env bash
set -euo pipefail
mkdir -p notes sim

cat > params.toml <<'EOF'
# Device parameters for qubit Q3, from the spectroscopy fit (frequencies are E/h).
EJ_over_h_GHz = 12.5
EC_over_h_GHz = 0.25
EOF

cat > notes/transmon_to_kerr.md <<'EOF'
# Transmon to Kerr oscillator (derivation for the simulation)

Start from the transmon Hamiltonian

$$H = 4E_C n^2 - E_J\cos\varphi .$$

**Step 1.** Expand the cosine to fourth order:

$$-E_J\cos\varphi \approx -E_J + \frac{E_J}{2}\varphi^2 - \frac{E_J}{24}\varphi^4 .$$

**Step 2.** Introduce ladder operators
$\varphi = (2E_C/E_J)^{1/4}(a+a^\dagger)$ and $n = \frac{i}{2}(E_J/2E_C)^{1/4}(a^\dagger-a)$.
The quadratic part becomes $\hbar\omega_p(N + 1/2)$ with $\hbar\omega_p = \sqrt{8E_JE_C}$ and $N = a^\dagger a$.

**Step 3.** The quartic term is $-\frac{E_C}{12}(a+a^\dagger)^4$. Expanding and normal
ordering gives

$$(a+a^\dagger)^4 = 6N(N-1) + 12N + 3 ,$$

so the quartic term equals $-\frac{E_C}{2}N(N-1) - E_C N$ up to a constant.

**Step 4.** Dropping constants and dividing by $\hbar$:

$$H/\hbar = (\omega_p - E_C)N - \frac{E_C}{2}N(N-1) .$$

**Step 5.** Matching to the standard form $H/\hbar = \omega_{01}N + \frac{K}{2}N(N-1)$ gives

$$\omega_{01} = \omega_p - E_C/\hbar, \qquad K = -\frac{E_C}{2\hbar} .$$

The anharmonicity is $\alpha = 2K$.

**Validity.** This is the standard result, valid in the charge regime $E_J/E_C \ll 1$.

**For the simulation.** Pass `omega = omega_01` and `chi = K` to
`kerr_oscillator_hamiltonian` in `sim/kerr.py`.
EOF

cat > sim/kerr.py <<'EOF'
"""Kerr oscillator Hamiltonian for the continuous-variable simulator."""


def kerr_oscillator_hamiltonian(n_levels, omega, chi):
    """Return H as a dense diagonal matrix (list of lists) in the Fock basis.

    Units: hbar = 1 and angular frequencies in rad/ns, so H has units of rad/ns.

        H = omega * N + chi * N**2,    N = a^dagger a,

    truncated to the Fock states |0>, ..., |n_levels - 1>.
    """
    return [[(omega * n + chi * n * n) if m == n else 0.0 for m in range(n_levels)]
            for n in range(n_levels)]
EOF
