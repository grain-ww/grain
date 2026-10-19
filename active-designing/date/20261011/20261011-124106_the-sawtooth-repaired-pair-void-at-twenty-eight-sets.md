# The sawtooth with a repaired pair -- void at 28 sets, no gcd reading

**Status:** Landed -- the pre-registered run, scored against its own falsifier
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Stamp:** 20261011.124106 (run after 20261011.124035 and before 20261011.124106; the exact run second was not read)
**Kin:** [the falsifier, written first](20261011-123625_the-sawtooth-repaired-pairing-falsifier-first.md) - [the 26-to-31 result](20261011-123141_the-sawtooth-sweep-26-to-31-no-discriminating-count.md)

## Result in one line

**F3 held (void).** At 28 sets the Cartesian arm shows zero conflict misses for both sizes, so
precondition P2 failed on that arm and the gcd question is not read at this count. The polar arm
also fails P1 (its miss ratio sits above 1.05 on both sizes), so the gap is not read either way.

## What was run

Scratch model, the same LRU model as the 26-to-31 sweep: 8 ways, 8 cells per line, modulo index,
unpadded. Driver: `session-output/stride-door/sawtooth_sweep.py`, untracked, invoked as
`python3 -I sawtooth_sweep.py 28 -- 223 224`. Output saved untracked as
`session-output/stride-door/sawtooth_28_pair_20261011.txt`. Wall time 1.5 seconds on this guest.

| N | gcd(N, 28) | comp cart | comp polar | conflict cart | conflict polar | miss cart | miss polar | ratio |
|---|---|---|---|---|---|---|---|---|
| 223 | 1 | 5002 | 4833 | 0 | 655 | 1.0000 | 1.1355 | 1.1355 |
| 224 | 28 | 5088 | 4929 | 0 | 599 | 1.0000 | 1.1215 | 1.1215 |

Source of every figure: the single run above. Nothing holds the table still; it is free, and
RUN `python3 -I sawtooth_sweep.py 28 -- 223 224` to re-read it, which reproduces it only while the
model's code is unchanged.

## Against the preconditions and falsifiers

- **P1 (floors reached, every miss ratio below 1.05 on both arms): fails.** The polar arm reads
  1.1355 and 1.1215. The Cartesian arm reads 1.0000 for both sizes, so only the polar arm breaks P1.
- **P2 (at least one trace of each size shows conflict misses on both arms): fails.** The Cartesian
  arm reads zero conflict misses for both sizes, so the count cannot discriminate on that arm.
- **P3 (no fault): holds.** Both `fault` fields read 0, so no miss count sits below its compulsory
  line count.
- **F1 (gap above 0.15): not read.** The gap is 1.1215 minus 1.1355, which is -0.0140 and is shown
  only for completeness. P1 failed, so the gap carries no reading.
- **F2 (gap at or under 0.15): not read**, for the same reason.
- **F3 (void): holds.** P2 failed on the Cartesian arm at s = 28, so nothing is read about gcd at
  this count.

## Why the Cartesian arm is silent here

The 26-to-31 sweep already showed the same silence: every trace at every count from 26 to 31, on
both sizes, carries zero Cartesian conflict misses (24 of 24 rows read `conflict_cart=0`, held in
`session-output/stride-door/sawtooth_sweep_20261011.txt`). Holding N near 224 changed the pair, not
the arm. So the problem is the Cartesian layout at 8 ways over these set counts. Its row-major walk
is conflict-free at every count in the range, which means the range cannot separate an index effect
from a floor on that arm. The repaired pair was the right repair for the gcd question, and the
arm it was measured on has no conflicts to measure.

## What this retires

The 223-224 pair at 28 sets is retired as a discriminator for this model, as the falsifier's own
F3 branch anticipated. The gcd-class question is not answered by any set count in 26 to 31 on this
model, so the sawtooth reading stays a series-level observation (the ratio's shape across N) and
not a gcd test.

## Projection, with its horizon, assumptions, falsifier, and confidence

- **Horizon:** the next scratch-model lap only.
- **Assumption:** the Cartesian arm's zero conflicts come from the layout and the 8-way LRU model,
  and would stay zero at any count in 26 to 31 for any N near 224 (an inference from 24 rows, not a proof).
- **Falsifier:** a Cartesian conflict count above zero at some count in 26 to 31 for some N near 224
  or 192 would overturn that assumption. None has appeared in 24 rows.
- **Confidence:** high that the 28-set pair is void as written; moderate that the whole 26-to-31
  range is conflict-free on the Cartesian arm, since only 8 ways and one line size were tried.

## Next door (falsifier first, not run)

A set-count range where the Cartesian arm first shows conflict misses, found by a table read before
any pair is drawn. The next lap should write a falsifier before it runs the table: for example, that
the first nonzero Cartesian conflict count appears at or below 25 sets at 8 ways, with the P2
precondition restated for the new count. If no count in a range the lap names shows Cartesian
conflicts, the sawtooth gcd question closes as unanswerable in this model, and the next door
becomes a dense N grid instead of more pairs. The hardware door, a raw TLB-miss or vendor event,
stays the maintainer's word.

## Scope

Scratch model only. No hardware is claimed, no real cache is measured, and no witness binds these
numbers. The run used an untracked driver; the saved output is untracked too, so this paper is the
record of the reading.
