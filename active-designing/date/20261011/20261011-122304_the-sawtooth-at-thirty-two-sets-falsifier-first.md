# The sawtooth at thirty-two sets -- falsifier, written before the run

**Status:** Design -- falsifier stated before any run; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Stamp:** 20261011.122304
**Kin:** [the fixed-set-count result](20261011-121709_the-sawtooth-at-a-fixed-set-count-does-not-isolate-gcd.md) - [the fixed-set-count falsifier](20261011-121519_the-sawtooth-at-a-fixed-set-count-falsifier-first.md)

## Why this door

The fixed-set-count run at 25 sets did not isolate gcd(N, sets). At 25 sets the sizes sat at different
distances from their own compulsory floors: 192 near 25, and 224 and 225 near 29. A miss ratio read
away from the floor measures floor distance as well as index effect, so the pair gap could not be
attributed to gcd.

The result paper names the fix: one fixed set count **above every floor in both pairs**, so each trace
reads near its compulsory rate and the remaining difference is the index. The candidate is 32 sets.

## Setup

- Scratch model, the same LRU model as `session-output/ring-offset/ring_offset.py` (8-way, LINE 8,
  modulo index, unpadded). Driver is the existing untracked `session-output/stride-door/sawtooth_fixed.py`
  with `SETS` set to 32 for this run. No change to the model.
- Fixed set count: **32, for every N, in both arms.** Miss ratio is `misses(trace, 32)` divided by the
  trace's compulsory line count, so 1.0 is the compulsory floor.
- The read is the polar miss ratio over the Cartesian miss ratio at the same 32 sets.
- Pair A, gcd 1 with 32 (odd N): N = 193 and N = 225. gcd(193, 32) = 1 and gcd(225, 32) = 1.
- Pair B, gcd 32 with 32 (multiples of 32): N = 192 and N = 224. gcd(192, 32) = 32 and gcd(224, 32) = 32.

**Note on the pairing, revised before the run.** The 25-set pairs (200 and 225 against 192 and 224) do not
split by gcd at 32 sets: gcd(200, 32) = 8, and gcd(225, 32) = 1. Keeping them would compare gcd classes
that the design does not name. So the pairs were redrawn here, before any trace was generated, to the
clean 1-versus-32 split above. The redraw is recorded in this paper rather than hidden, and the
falsifiers below are written against the redrawn pairs. Pair A and pair B now differ in gcd, not in N
size class alone, so a gap in either direction is the thing F1 and F2 read.

## Pre-run precondition (read before the run, not inferred after)

- **P1 (floors reached).** Every trace's miss ratio at 32 sets is below 1.05 on both arms. If P1 fails,
  the floor-distance confound is still present at this count, the run is void, and nothing is claimed.

## Falsifiers (written before the run)

- **F1 (sawtooth present at fixed sets).** With P1 clear, the mean ratio of pair B exceeds the mean ratio of
  pair A by more than 0.15.
- **F2 (sawtooth absent at fixed sets).** With P1 clear, the absolute gap between the pair means is 0.15 or
  less.
- **F3 (model fault).** Any polar or Cartesian trace shows monotone violations in the miss-by-set-count
  sweep, or the run errors. If F3 fires, the run is void and nothing is claimed.

Both F1 and F2 are read only with P1 and F3 clear. The 0.15 line matches the earlier runs, so the three
results compare directly.

## What would change the plan

If F1 fires, the next door is a wider sweep over more sizes at 32 sets, falsifier first. If F2 fires, the
sawtooth is not a gcd effect at a fixed count above the floors, and the polar penalty stays with the
angular and radial stencil papers. If P1 fails, the next door is a higher set count, again falsifier first.
None of the outcomes claims anything about hardware.
