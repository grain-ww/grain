# The alignment door on the line stride, falsifiers written before the run

**Status:** Landed -- falsifiers stamped `20261011.064146` and committed before the run; the run is read at the foot of this paper (stride 0 at every N, so the definition does not test stride)
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Kin:** [the set-spread stagger](20261011-052411_the-alignment-door-set-spread-stagger-falsifier-first.md) - [the structured stagger](20261011-051108_the-alignment-door-structured-stagger-falsifier-first.md) - [the per-ring offset](20261011-044643_the-alignment-door-per-ring-offset-falsifier-first.md) - [the line-padded rings](20261011-031717_the-line-padded-rings-falsifier-first.md)

## What this tests

Four partition changes have now left the polar-to-Cartesian sawtooth where it stood. A per-set
relabel, a constant stagger, a set-spread stagger, and a seeded random offset per ring either moved
nothing or widened the spread. The set-spread paper named the next door as "a different cause, such
as the stride between line addresses". This paper names that door before any run.

The cause under test is the step between the line indices a polar walk visits in sequence. A walk
that steps through lines at a fixed stride `d` hits set `(L0 + i * d) % sets`. If `gcd(d, sets)` is
large, the walk touches only `sets / gcd(d, sets)` distinct sets, and the miss count rises for a
reason that a stagger cannot touch, because a stagger adds one constant per ring and leaves the step
inside a ring alone.

**Definition, chosen here and not tested against any other choice.** For each polar ring walk in the
trace, take the consecutive differences of the line indices the walk visits. The modal difference is
the ring's stride `d_r`. A single number per N is the modal stride over all rings, weighted by the
lines each ring holds. The measurement is a definition, so F1 checks that it is defined before any
ratio is read.

Scope: the scratch model only, 8 ways, LRU, line size 8, unpadded, 5 percent tolerance, the same disk
and stencil as `ring_offset.py`. No hardware, no witness, no claim about any real cache.

## Prior readings the falsifiers cite

| N | Arm | Cartesian floor (sets) | Polar floor (sets) | Ratio | Source |
|---|---|---|---|---|---|
| 256 | modulo | 12.4 | 33.3 | 2.69 | `fc256_base_20261011.txt`, label-shuffle paper |
| 384 | modulo | 19.2 | 49.7 | 2.59 | `fc384_640_nopad_20261011.txt`, label-shuffle paper |
| 640 | modulo | 28.8 | 83.0 | 2.88 | sawtooth paper `20261011.035855` |

Under the modulo index the ratio spreads 0.29 across N = 256, 384 and 640. The line-padded rings door
at 8 cells per line moved the N = 256 ratio from 2.69 to about 3.03 at 5 percent, which is a stride
change of the padding kind already tested. This door is therefore not the first to touch stride. It
is the first to read stride as a **measured quantity** and ask whether the sawtooth follows it.

## Falsifiers, written before the run

- **F1 (defined and baseline).** Each N's modal stride is printed, and the unpadded modulo arm
  reproduces the table above to the printed precision (ratio within 0.01, floors exact). Reason: if
  the stride definition or the baseline moves, no stride result can be read. The falsifier **fires**
  if either fails, and the run stops there.
- **F2 (stride tracks the sawtooth).** Let `g_N = gcd(d_N, sets)`, taken at the set count the modulo
  arm uses at that N. The cause is supported if the N values with the largest `g_N` are the N values
  where the modulo ratio is at its local maximum. Two of three N values must agree. The falsifier
  **fires** if they disagree at two or more of the three sizes.
- **F3 (stride is not the padding already tested).** Padding each ring to a line boundary removes the
  within-ring stride change at the ring start, but leaves the stride inside a ring alone. The
  falsifier **fires** if the padded ratio moves by 0.10 or more at any N while the unpadded modal
  stride holds at its baseline. A move of that size would mean the stride is not what padding touched,
  so the prediction and the measurement describe different things.

## Ordering

F1 runs first. If F1 fails, the run stops and the paper says so; no stride result is read. F2 and F3
are then read from the same run. The falsifiers are not edited after the run; a reading that
contradicts one is reported as a fire, not as a sign the falsifier was mis-set.

## Caveats, stated before the run

- One construction of stride, the modal difference per ring. A mean difference or a histogram
  would give a different number, and this paper does not compare them.
- F2 is weak by design. Three N values cannot separate a stride cause from a coincidence, so a
  pass on F2 is a reason to build a larger set-count sweep, not a conclusion.
- The Cartesian arm has no rings and no polar walk, so F2 reads only the polar arm. Any stride
  reading on the Cartesian side is out of scope here.

## Next door, not run

Run the modal-stride measurement at N = 256, 384 and 640 on the existing trace, print `g_N` beside
the modulo ratio, and read F1 and F2 in that order. The run is not made in this paper, and no ratio
in this document is a result.

---

**Reading (run in the same lap, after the falsifiers were committed).** Script:
`session-output/stride-door/stride.py`, untracked scratch, reusing `session-output/ring-offset/ring_offset.py`
for the disk, stencil and LRU model. Output: `stride_unpadded.txt` (PAD=0) and `stride_padded.txt` (PAD=1).

| N | Ratio (PAD=0) | Ratio (PAD=1) | Floor polar sets (PAD=0 / PAD=1) | Stride d_N | g_N = gcd(d_N, sets) |
|---|---|---|---|---|---|
| 256 | 2.69 | 2.70 | 33.3 / 33.3 | 0 | 33 |
| 384 | 2.59 | 2.60 | 49.7 / 49.7 | 0 | 50 |
| 640 | 2.88 | 2.88 | 83.0 / 83.1 | 0 | 83 |

- **F1: holds on the baseline, and the definition is defined.** The unpadded modulo arm reproduces 2.69,
  2.59 and 2.88 with floors 12.4/33.3, 19.2/49.7 and 28.8/83.0, all matching the table to printed precision.
  The stride is computed at every N. But it is **0 at every N**, so F1 says the definition runs and
  does not say it measures anything.
- **F2: not read as a stride test.** The stride is 0 everywhere, so `g_N = gcd(0, sets) = sets` and the
  ranking is the set count, 33 < 50 < 83. Under one reading of "two of three agree" (the top two by g
  against the local maxima 256 and 640) it agrees at 1 of 3, which would fire. That reading was chosen
  after the run, so it is reported as a choice and not as the falsifier. What the table shows is that
  F2 measured the set count, so it cannot separate a stride cause from the set count.
- **F3: holds.** The padded arm moves the ratio by 0.01, 0.01 and 0.00 at N = 256, 384 and 640, under the
  0.10 ceiling, with the stride at its unpadded value (0) at every N.
- **Why the stride is 0.** The modal consecutive difference inside a ring is the difference between two
  neighbouring cells that share a line, which is 0. Eight cells per line makes repeats the common case.
  The definition is the cause, not the layout. Recorded in
  [the distinct-line falsifiers](20261011-065207_the-alignment-door-distinct-line-stride-falsifier-first.md),
  which name a collapsed definition as the next door and state D1 to D4 before any run.

**Result, in one sentence:** the pre-registered stride measures 0 at every N, so the stride cause is not
tested by this definition, and the padding falsifier holds at the 0.01 level it was written for. This
paper does not claim the stride cause is supported or refuted.
