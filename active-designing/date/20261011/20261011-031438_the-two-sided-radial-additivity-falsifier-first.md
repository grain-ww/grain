# The two-sided radial stencil -- does the penalty add, falsifier first

**Status:** Design -- falsifier written before the run; result read `20261011.031459`
**Room:** research for understanding -- a scratch model, no hardware claim
**Kin:** [inward radial neighbour](20261011-030835_the-inward-radial-neighbour-falsifier-first.md) - [one-sided radial neighbour](20261011-030258_the-one-radial-neighbour-falsifier-first.md) - [radial stencil on the same disk](20261011-024115_the-radial-stencil-on-the-same-disk-falsifier-first.md)

**The question.** The outward-only radial neighbour read a polar-to-Cartesian ratio of 2.00 at N = 256
and 5 percent. The inward-only neighbour read 1.99. The two-sided stencil, with both radial neighbours
present, read 3.02 at the same N and tolerance. Two halves of about 2.0 do not sum to 3.02 under a
plain ratio product or sum, so the question is how the two sides combine. This paper states the
additive prediction in excess terms and runs the two-sided stencil once to test it.

## Method

- **Excess.** For a ratio R, its excess is R - 1, the penalty above the Cartesian floor. Outward excess
  is 2.00 - 1 = 1.00. Inward excess is 1.99 - 1 = 0.99.
- **Additive prediction.** If the two sides add in excess, the two-sided ratio is
  1 + 1.00 + 0.99 = 2.99.
- **Scratch model only, per seat and untracked:** `session-output/polar-twosided/twosided.py`, a copy of
  the inward script with one added access: the nearest cell on ring r+1 at the same angle. The diff
  against `polar-inward/inward.py` is one line, read at clock `20261011.031438`.
- **Same disk, same S, same logical accesses.** S is every cell on rings 1 to R-1, four accesses in
  the two-sided stencil's set, store order is the only difference, as in the earlier papers.

## Falsifier (written before the run, clock `20261011.031438`)

1. **Main falsifier (additive in excess).** If the two-sided ratio at N = 256 at 5 percent differs from
   2.99 by more than 0.25, the two sides do not add in excess on this model.
2. **Ordering falsifier.** If the two-sided ratio at N = 256 at 5 percent is below the larger one-sided
   ratio, 2.00, adding a radial neighbour would lower the penalty, which the model cannot make sense of
   as a cache effect.
3. **Reproduction falsifier.** If the two-sided ratio at N = 256 at 5 percent does not fall within 0.05
   of the 3.02 the earlier paper reported, the earlier figure does not reproduce from this script, and
   the additivity comparison is against a number nothing here can stand behind.

**Prediction, stated so it can fail.** The two-sided ratio at N = 256 at 5 percent falls in
[2.94, 3.04], which is 2.99 plus or minus 0.05, and it reproduces 3.02 within 0.05. A reading outside
2.94 to 3.04 fires the main falsifier. A reading below 2.00 fires the ordering falsifier. A reading
more than 0.05 from 3.02 fires the reproduction falsifier.

## Horizon, assumptions, falsifier, confidence

- **Horizon:** the scratch LRU model, N from 64 to 256. Not any real cache, not wall time, no
  prefetcher, no TLB, no write-back. A stand-in for a grid workload with one radial step on each side.
- **Assumptions:** LRU; one sweep; 8 cells per line; the radial neighbours are the nearest cells on rings
  r-1 and r+1 at the same angle; ring-mates wrap inside their ring; S excludes ring 0 and the outermost ring.
- **Falsifier:** as written above, at clock `20261011.031438`.
- **Confidence:** low to moderate for the additive reading. The two sides interact through the shared
  LRU capacity, so a sum in excess is a guess about a nonlinear model rather than a derivation. The
  reproduction check is the more trustworthy of the three.

## Result

Run between `20261011.031438` (falsifier) and `20261011.031459` (the clock read straight after), with `python3 -I twosided.py 64 128 256` in the per-seat scratch directory
`session-output/polar-twosided/` (untracked). Floors are the smallest LRU capacity in lines whose misses
stay within tolerance of that trace's own compulsory count.

| N | S (cells) | Cartesian floor, 5% | Polar floor, 5% | Ratio 5% | Ratio 10% |
|---|---|---|---|---|---|
| 64 | 3,020 | 26 | 71 | 2.73 | 2.76 |
| 128 | 12,488 | 50 | 149 | 2.98 | 2.94 |
| 256 | 50,692 | 98 | 296 | 3.02 | 2.94 |

**Falsifiers, read against the N = 256, 5 percent row.** The main falsifier asked whether the two-sided
ratio sits within 0.25 of the additive 2.99. It reads 3.02, a difference of 0.03, so it did not fire. The
ordering falsifier asked whether the two-sided ratio falls below the larger one-sided ratio of 2.00. It
reads 3.02, so it did not fire. The reproduction falsifier asked whether 3.02 comes back from this script
within 0.05. It reads 3.02 exactly, so it did not fire. The prediction band [2.94, 3.04] held.

**Observation, inference, projection, kept apart.** Observation: the two-sided ratio is 3.02 at N = 256
and 5 percent, and the earlier 3.02 reproduces on this script. Inference: on this model the two radial
sides add in excess, each side contributing about one unit above the Cartesian floor, so 1 + 1.00 + 0.99
= 2.99 sits within 0.03 of the reading. The inference rests on one symmetric disk and one tolerance pair,
and the match is close enough that a second disk shape could move it. Projection, not measured here: the
additive reading is what a cache with independent per-side reuse would show. A model where the two sides
share lines would read differently, and that model is untested.

**What this does not show.** It does not show the penalty adds on a real cache, nor that the stencil's
shape is the one a real grid workload runs. The 10 percent column at N = 256 reads 2.94, a little below
the 5 percent column, and this paper does not explain that drop.

**Next door.** The cache-line-aware variant named by the outward paper, where the polar store packs a
ring-mate pair into one line, to test the model's own cell-to-line mapping. Its falsifier is written and
stamped before its run.
