# The sawtooth with a repaired pairing -- falsifier, written before the run

**Status:** Design -- falsifier and preconditions stated before any run; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Stamp:** 20261011.123625
**Kin:** [the 26-to-31 falsifier](20261011-123052_the-sawtooth-sweep-26-to-31-falsifier-first.md) - [the 26-to-31 result](20261011-123141_the-sawtooth-sweep-26-to-31-no-discriminating-count.md)

## Why this door

The 26-to-31 sweep ended at F4: no set count in that range passed the discrimination precondition (P2) on both arms. The paper named the repair. Its pairs were a pairing fault: gcd(192, s) and gcd(224, s) differ across the sweep, and the pair label names no single gcd class. A count with a conflict-free size set against a conflicting one could not show an index effect, and the result said so.

This paper repairs the pairing. It holds N near 224 and varies gcd alone, so the two sizes differ by one grid line and the set count is the only thing that moves the gcd class.

## The repaired pair (chosen from the gcd table, read before the run)

Values are gcd(N, s), computed with `math.gcd` on this machine:

| N | s=26 | s=27 | s=28 | s=29 | s=30 | s=31 |
|---|---|---|---|---|---|---|
| 223 | 1 | 1 | 1 | 1 | 1 | 1 |
| 224 | 2 | 1 | **28** | 1 | 2 | 1 |

At **s = 28**, N = 224 has gcd 28 and N = 223 has gcd 1. At every other count in 26 to 31 the two sizes share gcd 1 or 2, so s = 28 is the one count where the pair differs in gcd class. 223 is prime, so its gcd is 1 at every count in the range. The primary read is s = 28 alone. The other five counts are reported as a control on the pairing, not as a second test.

## Setup

- Same scratch LRU model as the earlier runs (8 ways, line 8, modulo index, unpadded). No change to the model.
- Driver: the untracked `session-output/stride-door/sawtooth_sweep.py`, with `SETS = 28` and the two sizes 223 and 224 in the pair. It computes the same four readings per trace.
- Ratio read: `miss_polar / miss_cart` at the same set count, each divided by its own compulsory line count.
- **Gap** = ratio(224) minus ratio(223), at s = 28.
- **Conflict misses** = total misses minus compulsory lines, per trace.

## Pre-run preconditions

- **P1 (floors reached).** Every trace's miss ratio is below 1.05 on both arms. If P1 fails, the gap is not read.
- **P2 (the count can discriminate).** At s = 28, at least one trace of each size shows a nonzero conflict-miss count on both arms. If P2 fails, the result is void for discrimination and is reported as such, not read as F2.
- **P3 (no fault).** No monotone violation in the one-count reading, and the run does not error.

## Falsifiers (written before the run)

- **F1 (gcd moves the index effect).** At s = 28, with P1 to P3 clear, the gap exceeds 0.15.
- **F2 (gcd does not move it).** At s = 28, with P1 to P3 clear, the absolute gap is 0.15 or less.
- **F3 (void).** P2 fails at s = 28 on either arm. Nothing is read about gcd at this count.

## Known confounds, named before the run

- Floor distance. Compulsory lines scale with N, so the two sizes sit at slightly different distances from their floors. Adjacent sizes keep that difference to one grid line, but it is not zero. A gap near 0.15 is not enough to read as F1 without checking that P1 holds on both.
- One count, one pair. A clean F1 at s = 28 says the gcd class of 224 matters at that count. It does not yet say gcd is the driver, since 28 is also a count where conflicts may come from other structure in the model.

## What would change the plan

If F1 holds, the next door is the same pair at s = 26 and 30, where gcd(224, s) is 2 and gcd(223, s) is 1, to see whether a small gcd moves the gap. If F2 holds at s = 28, the gcd-driven reading is weakened in this model and the next door is a dense N grid around 224, not more pairs. If F3 holds, the next door is a count where P2 is expected to pass, chosen before the run, and the 224 pair is retired as a discriminator for this model.

## Scope

Scratch model only. No hardware is claimed, no real cache is measured, and no witness binds these numbers. The result paper, when it lands, will say which of F1, F2 or F3 held, with the falsifier quoted above it.
