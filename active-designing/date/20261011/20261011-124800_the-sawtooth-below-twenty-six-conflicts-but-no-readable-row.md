# The sawtooth below twenty-six sets -- conflicts appear, but no row is readable

**Status:** Design -- result of the table pre-registered at 20261011.124637; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Stamp:** 20261011.124800
**Kin:** [the falsifier](20261011-124637_the-sawtooth-set-count-table-below-twenty-six-falsifier-first.md) - [the repaired-pair void](20261011-124106_the-sawtooth-repaired-pair-void-at-twenty-eight-sets.md)

## What ran

The driver `session-output/stride-door/sawtooth_sweep.py`, unchanged, over set counts 8 through 25 at 8 ways, for N = 223 and N = 224. The raw output is saved untracked at `session-output/stride-door/sawtooth_below26_20261011.txt`. The run took under a few seconds. The table is free: RUN `python3 -I session-output/stride-door/sawtooth_sweep.py 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 -- 223 224` to re-read it, while the model's code is unchanged.

## The raw counts, which are the one real finding

Cartesian conflict misses above the compulsory line count, by set count:

| Sets | N = 223 | N = 224 |
|---|---|---|
| 8 | 6,692 | 7,423 |
| 9 | 6,935 | 7,044 |
| 10 | 187 | 388 |
| 11 | 172 | 316 |
| 12 to 25 | 0 | 0 |

Observation, not inference: the Cartesian arm shows conflicts at 8, 9, 10 and 11 sets, and shows none at any count from 12 to 25. The earlier 26-to-31 window held zero at every count, so the Cartesian arm is conflict-free from 12 to 31 sets and conflicted below that, in this model.

## Against the preconditions, which the table could not clear

- **P1 (every miss ratio below 1.05 on both arms): fails on all 36 rows.** The polar arm reads 1.48 to 2.80 across the range, so no row reaches its floor. The Cartesian arm clears P1 only at 12 sets and above, where it is conflict-free.
- **P2 (discrimination): holds for the raw counts** at 8 to 11 sets, but P1 failed on every row, so the count is not read against a floor.
- **P3 (no fault): holds.** Every `fault` field reads 0.
- **F-first (first nonzero Cartesian count at or below 25 sets): holds on the raw count**, at 10 sets for N = 223 (187 conflicts).
- **F-all-zero (range closes): does not hold.** Conflicts appear at 8 to 11 sets.
- **F-fault: does not hold.**

So the table answers the question it was built for in one sense: the Cartesian arm does show conflicts below 12 sets. It does not answer the gcd question, because the polar arm never reaches its floor in this range, and the pre-registered P1 has to clear before a ratio is read. The gcd comparison stays unread.

## Why P1 is the binding limit, and what it says

The polar arm's miss ratio is 1.14 at 28 sets and 1.48 to 2.80 across 8 to 25 sets. It falls as the set count rises, which means the polar layout's conflict floor sits well above the compulsory line count at 8 ways over this whole range. P1 was written as a floor test for a reason: a ratio read above its floor measures the layout and the trace together. Here the floor test fails everywhere, so the reading the paper wanted (a sawtooth in the ratio across N) has no clean denominator in this model.

## What this retires, and what it does not

- **Retired:** the sawtooth as a gcd discriminator at 8 ways in this model, under P1 as written. No row here meets the floor on the polar arm.
- **Not retired:** the raw Cartesian observation. The Cartesian arm is conflict-free at 12 to 31 sets and conflicted at 8 to 11, which is a layout fact in this model and holds for both sizes.
- **Not decided:** whether P1 should be restated for a conflict-count reading that does not need the polar floor. Restating a precondition after a fail is a design ruling, and this lap does not make it.

## Projection, with horizon, assumptions, falsifier, and confidence

- **Horizon:** this scratch model, the next lap that touches it.
- **Assumption:** the 8-way LRU model and the two layouts are the model's whole story, as the earlier papers assumed.
- **Falsifier:** a real or second model whose polar arm reaches the 1.05 floor at 8 to 11 sets would overturn the claim that P1 is unreachable in this range. A Cartesian count at 12 to 25 sets above zero would overturn the conflict-free observation above 11.
- **Confidence:** high on the raw counts, since they are one deterministic run; moderate that the 12-set boundary is a property of the layout rather than of the chosen N values; low on any gcd reading, which this range does not support.

## Next door, and who decides it

The next door is a ruling rather than a run: restate the reading for conflict counts without a polar floor, or drop the gcd question for this model and move to a dense N grid. A restated P1 needs a new falsifier written before any run, so the lap that takes the ruling writes that falsifier first.

**Recommend: check in (Claude)** -- choosing whether P1 is restated is a design question about the measurement, and no written policy settles it.

## Scope

Scratch model only. No hardware is claimed. The table is untracked output, so this paper is the record of the reading.
