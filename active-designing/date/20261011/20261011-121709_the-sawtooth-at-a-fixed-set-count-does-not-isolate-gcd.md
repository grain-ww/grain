# The sawtooth at a fixed set count -- result (no gcd effect read, and a second confound named)

**Status:** Design -- result of the pre-registered fixed-set sawtooth run; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Stamp:** 20261011.121709 (run began `20261011.121612`, finished `20261011.121659`)
**Kin:** [the falsifier, written first](20261011-121519_the-sawtooth-at-a-fixed-set-count-falsifier-first.md) - [the confounded run](20261011-121203_the-sawtooth-result-confounded.md)

## Result in one line

At a fixed 25 sets, the pair means differ by **0.058** (pair B minus pair A), under the 0.15 line the
falsifier set. F2 holds on its own terms. The run does not isolate gcd, though, because the sizes also
sit at different distances from their own floors, and that second effect is the larger one.

## Measured (scratch LRU model, 8-way, LINE 8, modulo index, unpadded; 25 sets in every row)

| N | gcd(N, 25) | Pair | Polar misses / compulsory | Cartesian misses / compulsory | Ratio at 25 sets | Monotone violations (polar, cart) |
|---|---|---|---|---|---|---|
| 192 | 1 | A | 1.0199 | 1.0000 | 1.0199 | 0, 0 |
| 224 | 1 | A | 1.5283 | 1.0000 | 1.5283 | 0, 0 |
| 200 | 25 | B | 1.1611 | 1.0000 | 1.1611 | 0, 0 |
| 225 | 25 | B | 1.5025 | 1.0000 | 1.5025 | 0, 0 |

- Pair A mean: (1.0199 + 1.5283) / 2 = **1.274**.
- Pair B mean: (1.1611 + 1.5025) / 2 = **1.332**.
- Gap, B minus A: **0.058**. Falsifier F1 needed more than 0.15. F1 did not fire.
- F2 needed 0.15 or less. F2 holds on its own threshold.
- F3 (model fault): zero monotone violations on every polar and Cartesian curve, and no errors. F3 did not fire,
  so the run stands.

Source: `session-output/stride-door/sawtooth_fixed.py`, raw output `sawtooth_fixed_20261011.txt`. Both are
scratch and untracked. Read them by running the driver again; the numbers above are from the single run.

## Why this does not isolate gcd

The four sizes fall into one ordering by N alone: 192 at 1.02, 200 at 1.16, 224 at 1.53, 225 at 1.50. Each
pair holds one low size and one high size, so the pair means mostly track N, and the gcd class is a small
addend on top.

The reason is the set count itself. The confounded run measured each size's own floor: N = 192 reaches its
compulsory rate near 25 sets, while N = 224 and 225 reach it near 29. At a fixed 25 sets, the 192 polar trace
sits at its floor, and the 224 and 225 traces sit below theirs, where conflict and capacity misses appear. So
the fixed-count design sets **distance from each size's own floor**, which varies with N, rather than
**gcd(N, sets)** alone. A reading of "the gcd class barely matters" here is therefore a reading about
distance-from-floor as much as about gcd.

The working-set point is worth stating plainly. At 25 sets, 8 ways, the cache holds 200 lines, while the
polar traces carry 3,600 to 4,900 distinct lines. The miss counts are dominated by capacity, not by the
index arrangement this door set out to test. A fixed set count below every floor reads capacity, not
gcd.

## What holds, and what does not

- **Holds, on the scratch model:** the 0.058 gap is inside the pre-registered line; the model shows no
  monotone fault on any curve.
- **Does not hold:** any claim that gcd(N, sets) drives the polar ratio. This run measured a
  size-and-floor effect and a gap too small to attribute to gcd.
- **Not claimed:** anything about hardware, a real cache, or the N=192 padded ratio of 2.62 and 2.63 (that figure
  is at each size's own floor and is not comparable to these fixed-count ratios).

## Next door

One fixed set count **above every floor in both pairs**, so that every trace reads near its compulsory rate and
the only remaining difference is the index. Candidate: 32 sets, since both floors read 29 or below. The falsifier
for that run must be written first and must name the threshold, and the floor each size reaches must be read
before the run, not inferred after it. This door stays scratch-only until the maintainer's word on a hardware route.
