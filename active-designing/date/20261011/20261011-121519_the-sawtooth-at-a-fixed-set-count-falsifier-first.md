# The sawtooth at a fixed set count -- falsifier, written before the run

**Status:** Design -- falsifier stated before any run; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Stamp:** 20261011.121519
**Kin:** [the confounded sawtooth result](20261011-121203_the-sawtooth-result-confounded.md) - [the sawtooth falsifier](20261011-121102_the-sawtooth-falsifier-first.md)

## Why this door

The confounded sawtooth run assumed the floor sat at about 25 sets for every size. It did not: the
rounded set count read 25, 26, 29, 29, so the pairs compared different gcd values against different
set counts at once. The result paper names the fix: fix the set count per run, so gcd(N, sets) is set
by design rather than inferred from a floor that moves with N.

This door fixes the set count at one value for every size, in both the polar and the Cartesian arm.

## Setup

- Scratch model, the same LRU model as `session-output/ring-offset/ring_offset.py` (8-way, LINE 8,
  modulo index, unpadded). Driver is a new scratch file, `session-output/stride-door/sawtooth_fixed.py`,
  untracked.
- **Fixed set count: 25, for every N, in both arms.** Miss counts are the raw `misses(trace, 25)` counts,
  divided by each trace's compulsory line count, so a ratio of 1.0 is the compulsory floor.
- The read is the polar miss ratio over the Cartesian miss ratio at the same 25 sets, not the floor ratio
  of the earlier paper. The earlier metric needed the floor, and the floor is what moved.
- Pair A, gcd 1 with 25: N = 192 and N = 224 (gcd(192,25) = 1, gcd(224,25) = 1).
- Pair B, gcd 25 with 25: N = 200 and N = 225 (gcd(200,25) = 25, gcd(225,25) = 25).

## Falsifiers (written before the run)

- **F1 (sawtooth present at fixed sets).** The mean ratio of pair B exceeds the mean ratio of pair A by
  more than 0.15.
- **F2 (sawtooth absent at fixed sets).** The absolute gap between the pair means is 0.15 or less. This is
  the prediction if gcd(N, sets) does not move the ratio at a fixed set count.
- **F3 (model fault).** Any polar or Cartesian trace shows monotone violations in the miss-by-set-count
  sweep, or the run errors. If F3 fires, the run is void and nothing is claimed.

Both F1 and F2 can be read only with F3 clear. The 0.15 line is the same line the confounded run used, so
the two results compare directly.

## What would change the plan

If F1 fires, the next door is a wider sweep over more gcd classes at 25 sets, falsifier written first. If
F2 fires, the sawtooth cause is not a gcd effect at this set count, and the polar penalty stays with the
angular and radial neighbour stencil papers. Neither outcome claims anything about hardware.
