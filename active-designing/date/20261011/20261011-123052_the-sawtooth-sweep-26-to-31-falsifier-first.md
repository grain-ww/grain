# The sawtooth across 26 to 31 sets -- falsifier, written before the run

**Status:** Design -- falsifier stated before any run; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Stamp:** 20261011.123052
**Kin:** [the 32-set falsifier](20261011-122304_the-sawtooth-at-thirty-two-sets-falsifier-first.md) - [the 32-set result](20261011-122457_the-sawtooth-at-thirty-two-sets-saturates-to-compulsory.md)

## Why this door

At 32 sets every trace reads a miss ratio of 1.0000, so every miss is compulsory and the gap between the
two pairs is zero by construction. A saturated ratio cannot show an index effect. The 32-set paper
named the next door: a sweep over 26 to 31 sets, with a precondition that a set count can discriminate
before it is read. This paper writes that precondition first.

## Setup

- Same scratch LRU model as the 32-set and 25-set runs (`session-output/ring-offset/ring_offset.py`,
  8 ways, line 8, modulo index, unpadded). No change to the model.
- Driver: a new untracked file `session-output/stride-door/sawtooth_sweep.py`, which is the 32-set
  driver with `SETS` taken from the command line. It computes the same four readings per trace.
- Set counts swept: **26, 27, 28, 29, 30, 31**, one run per count, in both arms.
- Pairs, the same as the 32-set run: pair A is N = 193 and 225; pair B is N = 192 and 224. The gcd of
  each N with each set count is printed beside its row, since 225 shares factors with 27, 30 and 28
  below and the 32-set split does not carry over unchanged.
- Read: `miss_polar / miss_cart` at the same set count. The read is the ratio of miss ratios, each
  divided by its own compulsory line count, as in the earlier runs.
- **Conflict misses** are defined here as total misses minus compulsory lines, per trace. A trace with
  zero conflict misses has no index effect to read at that set count.

**Note on the gcd split, stated before the run.** gcd(192, s) and gcd(224, s) are not the same at every
s in 26 to 31, so the pair label does not name one gcd class per set count. The paper reads gcd per
trace at each count and reports it beside each row, rather than assuming the 32-set split holds.

## Pre-run preconditions (read before the run, not inferred after)

- **P1 (floors reached).** At each set count, every trace's miss ratio is below 1.05 on both arms.
  This is the 32-set precondition carried over. If P1 fails at a count, that count's gap is not read.
- **P2 (the count can discriminate).** At each set count, at least one trace in each pair shows a
  nonzero conflict-miss count on both arms. A count where every conflict count is zero is saturated
  like 32 sets, and it cannot discriminate, so it is reported as **void for discrimination** and not
  read as F2. P2 was not required for the 32-set paper, and that omission is named there.
- **P3 (no fault).** No trace shows a monotone violation in the one-count reading, and the run does
  not error.

## Falsifiers (written before the run)

- **F1 (sawtooth present across the sweep).** At every set count where P1, P2 and P3 are clear, the mean
  ratio of pair B exceeds the mean ratio of pair A by more than 0.15. Read as a sweep, F1 needs the
  gap to hold at every clear count, not at one.
- **F2 (sawtooth absent across the sweep).** At every set count where P1, P2 and P3 are clear, the
  absolute gap between the pair means is 0.15 or less.
- **F3 (mixed).** The clear counts disagree: F1 holds at some and F2 at others. Read as a finding that
  the index effect depends on the set count, with no single answer across 26 to 31.
- **F4 (no discriminating count).** No set count in 26 to 31 passes P2 on both arms. The sweep then
  says nothing about gcd, and the next door is a count below 26 where conflicts still exist.

## What would change the plan

If F1 holds at every clear count, the next door is a wider sweep over more sizes, falsifier first. If
F2 holds, the sawtooth is not a gcd effect in this model at these counts, and the polar penalty stays
with the angular and radial stencil papers. If F3 or F4 holds, the next door is a set count below 26,
where conflicts exist, again falsifier first. None of the outcomes claims anything about hardware, a
cache in use, or any real machine.

## Witness

None. This is a scratch-model reading; the room is research for understanding. The reading is free
and repeatable by running the driver on the same N values, and the result paper will carry its own
command line.
