# BVD-Ocelot — synthetic F115 vulnerability benchmark

**This is a deliberately-vulnerable benchmark fork. Do NOT deploy it, and do NOT
send its changes upstream to [ThreeMammals/Ocelot](https://github.com/ThreeMammals/Ocelot).**

This repository is a Fluid Attacks fork of Ocelot used as a labeled dataset for
training and evaluating the SIFTS **F115 — Security Controls Bypass or Absence**
detector. Selected host functions from clean upstream code have been minimally
mutated into genuine, reproducible F115 instances (twins): the clean version is
the parent commit, the vulnerable version is the child commit.

It is the same category of resource as OWASP WebGoat, DVWA and NIST SARD:
intentionally vulnerable code, openly labeled as such, for testing security
tooling. The injected weaknesses are well-known, publicly-documented classes
(e.g. CWE-290, CWE-348, CWE-285), not novel exploits.

## Ground truth

Every injected sample is recorded in [`GROUND_TRUTH.csv`](./GROUND_TRUTH.csv):
file, line range, archetype, F115 subcategory, fit quality, trigger, exploit,
clean-twin commit, vulnerable commit, and verification status.

The detector under evaluation must NOT be given `GROUND_TRUTH.csv` (nor the
commit messages): the eval harness holds these out so the detector sees only the
code. The ground truth is committed here purely for auditability and scoring.

Candidates that were proposed but **rejected** by the genuineness gate (functions
with no genuine host role for the claimed class — "forced" candidates that would
produce mislabeled samples) are recorded in
[`GROUND_TRUTH_rejected.csv`](./GROUND_TRUTH_rejected.csv), with the failing test
and reason. The rejections are kept deliberately: they document why those
functions are *not* in the benchmark and keep the dataset honest.

## Layout

- Baseline (clean, runnable): commit `f7a1aeb3` adds the Nix dev setup; see [`NIX.md`](./NIX.md).
- One vulnerable sample per commit on top of the baseline. Each commit message
  documents the sample; `GROUND_TRUTH.csv` is the authoritative index.

## Verification

Samples that are request-time controls are verified dynamically with the Nix
harness (gateway + downstream stub); the exploit succeeds on the vulnerable
commit and fails on the clean twin. Samples that are not reachable runtime
controls are verified statically and marked `verification=static` in the CSV.
