# The sawtooth set-count table below 26 -- falsifier, written before the run

**Status:** Design -- falsifier and preconditions stated before the table is read; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Stamp:** 20261011.124637
**Kin:** [the repaired-pair void](20261011-124106_the-sawtooth-repaired-pair-void-at-twenty-eight-sets.md) - [the 26-to-31 result](20261011-123141_the-sawtooth-sweep-26-to-31-no-discriminating-count.md)

## What this door is

The repaired pair at 28 sets was void because the Cartesian arm showed zero conflict misses at every count from 26 to 31, on both sizes, in 24 of 24 rows. The paper named the next door: find a set-count range where the Cartesian arm first shows conflict misses, by a table read before any pair is drawn.

This paper writes the falsifier for that table read, and only then runs it. The driver is the existing untracked `session-output/stride-door/sawtooth_sweep.py`, unchanged, reading the model in `session-output/ring-offset/ring_offset.py`. No new instrument is built.

## The reading, and what it measures

Each row gives, for one set count `s` and one grid size `N`, the Cartesian and polar conflict-miss counts above the compulsory line count, at an 8-way LRU model. A conflict count above zero on the Cartesian arm is the only thing this table can show that the earlier sweep could not.

## Preconditions (must hold for the table to be read at all)

- **P1 (floors reached).** Every miss ratio below 1.05 on both arms, for every row read. A ratio above 1.05 means the trace is not yet at its compulsory floor and the row is not read.
- **P2 (discrimination).** For the range read, at least one count shows Cartesian conflict misses above zero for at least one of the two sizes. Without this the table cannot separate an index effect from a floor on the Cartesian arm.
- **P3 (no fault).** The `fault` field reads 0 on every row, so no miss count sits below its compulsory line count.

## Falsifiers, stated before the run

- **F-first (the named falsifier).** The first nonzero Cartesian conflict count appears at or below 25 sets at 8 ways, for at least one of N = 223 or N = 224. If this does not hold, the claim that the Cartesian arm is conflict-free only because of the 26-to-31 window is false, and the table shows where it breaks.
- **F-all-zero (the range closes).** If every count from 8 to 25 shows `conflict_cart=0` for both sizes, the Cartesian layout is conflict-free across 8 to 31 sets at 8 ways. The sawtooth gcd question then closes as unanswerable in this model, and the next door becomes a dense N grid rather than more pairs.
- **F-fault.** Any row with `fault=1` voids the whole table.

## Range and sizes, fixed before the run

- Set counts: 8 through 25, each read on its own row.
- Sizes: N = 223 and N = 224, the repaired pair, so the gcd class is the only thing that differs between them at each count.
- Nothing else varies.

## Projection, with horizon, assumptions, falsifier, and confidence

- **Horizon:** this scratch model, this lap only.
- **Assumption:** the 8-way LRU model and the row-major Cartesian walk are the model's whole story, as the earlier papers assumed.
- **Falsifier:** F-first above, or F-all-zero if the range closes.
- **Confidence:** moderate that a nonzero Cartesian count appears somewhere below 26, since a smaller set count raises the chance two lines share a set. Low on the exact threshold, which is what the run is for.

## Scope

Scratch model only. No hardware is claimed. The table is free: RUN `python3 -I session-output/stride-door/sawtooth_sweep.py 8 9 10 ... 25 -- 223 224` to re-read it, which reproduces it only while the model's code is unchanged.
