# The inward radial neighbour -- the mirror door, falsifier first

**Status:** Design -- falsifier written before the run; result pending
**Room:** research for understanding -- a scratch model, no hardware claim
**Kin:** [one-sided radial neighbour](20261011-030258_the-one-radial-neighbour-falsifier-first.md) - [radial stencil on the same disk](20261011-024115_the-radial-stencil-on-the-same-disk-falsifier-first.md) - [purely angular stencil](20261011-025702_the-angular-stencil-on-the-same-disk-falsifier-first.md)

**The question.** The outward-only stencil restored about half the polar penalty, at a ratio of 2.00
at N = 256 and 5 percent. Two things remain open: whether the inward radial neighbour contributes
the same amount as the outward one, and whether the two sides add. This paper runs the inward half
alone, so the outward-only and inward-only readings can be set side by side.

## Method

- **Stencil.** For a cell p in S on ring r, its access set is p, its ring-mate at k-1, its
  ring-mate at k+1 (wrapping inside the ring), and the nearest cell on ring r-1 at the same angle.
  Four accesses per cell, one of them radial, on the inward side.
- **Scratch model only, per seat and untracked:** `session-output/polar-inward/inward.py`, a copy
  of the outward script with the radial neighbour moved from ring r+1 to ring r-1. A two-line diff
  against `session-output/polar-onesided/onesided.py` is the whole change. The diff was read at
  clock `20261011.030835`.
- **Same disk, same S, same logical accesses.** Only the store order differs, as in the earlier
  papers.

## Falsifier (written before the run, clock `20261011.030835`)

1. **Main falsifier.** If the polar floor on S is below the Cartesian floor on S at N = 256 at 5
   percent, one inward radial access does not restore the polar penalty, and the radial share is
   not the carrier of the penalty on this side.
2. **Second falsifier.** If the polar-to-Cartesian ratio at N = 256 at 5 percent is at or above 2.5,
   one inward radial access on its own reproduces the full penalty of the two-sided stencil, which
   read 3.02 at the same N and tolerance.
3. **Symmetry falsifier.** If the inward-only ratio at N = 256 at 5 percent differs from the
   outward-only ratio of 2.00 by more than 0.25, the two sides do not contribute alike on this model,
   and the outward reading cannot stand for both.

**Prediction, stated so it can fail.** I expect the inward-only ratio at N = 256 at 5 percent to
fall in [1.0, 2.5), and within 0.25 of 2.00. A reading below 1.0 fires the main falsifier. A reading
at or above 2.5 fires the second. A reading outside 2.00 plus or minus 0.25 fires the third.

## Horizon, assumptions, falsifier, confidence

- **Horizon:** the scratch LRU model, N from 64 to 256. Not any real cache, not wall time, no
  prefetcher, no TLB, no write-back. A narrow stand-in for a grid workload with one radial step.
- **Assumptions:** LRU; one sweep; 8 cells per line; the inward radial neighbour is the nearest cell
  on ring r-1 at the same angle; ring-mates wrap inside their ring; S excludes ring 0 and the
  outermost ring, so every S cell has a ring r-1.
- **Falsifier:** as written above, at clock `20261011.030835`.
- **Confidence:** moderate that the inward ratio lands in [1.0, 2.5) and near 2.00, since the inward
  ring is smaller and its nearest cells cluster in the polar store the same way; low for any hardware
  transfer. The symmetry reading is the weakest claim here, because the ring sizes differ by one step.

## Result

Run at `20261011.030906` with `python3 -I inward.py 64 128 256` in the per-seat scratch directory
`session-output/polar-inward/` (untracked). Floors are the smallest LRU capacity in lines whose misses
stay within tolerance of that trace's own compulsory count.

| N | S (cells) | Cartesian floor, 5% | Polar floor, 5% | Ratio 5% | Cartesian floor, 10% | Polar floor, 10% | Ratio 10% |
|---|---|---|---|---|---|---|---|
| 64 | 3,020 | 25 | 46 | 1.84 | 25 | 45 | 1.80 |
| 128 | 12,488 | 49 | 96 | 1.96 | 49 | 93 | 1.90 |
| 256 | 50,692 | 97 | 193 | 1.99 | 97 | 188 | 1.94 |

**Falsifiers, read against the table.** The main falsifier asked whether the polar floor sits below
the Cartesian floor at N = 256 at 5 percent. It reads 193 against 97, so it did not fire. The second
falsifier asked whether the ratio is at or above 2.5. It reads 1.99, so it did not fire. The symmetry
falsifier asked whether the inward ratio sits more than 0.25 from the outward 2.00. The difference is
0.01, so it did not fire.

**What this shows, and what it does not.** Observation: one inward radial access restores the polar
penalty to about two times, the same as the outward access did. Inference: on this model the two
sides of the radial neighbour contribute about equally, so the outward-only reading stood for both.
Each side carries about half the penalty, and the two sides neither add nor cancel. The inference
rests on one symmetric disk and one tolerance pair. It does not show the two sides add linearly
when both are present, since the two-sided stencil read 3.02 and two halves of about 2.0 would not
sum to that. That gap is the next question, and this paper does not close it.

**Next door.** Two candidates, each to have its falsifier written and stamped before its run. The
first is the two-sided additivity check, a stencil with both radial neighbours set against the
single-sided halves, to see why 3.02 is not simply two times 2.00. The second is the cache-line-aware
variant named by the outward paper, where the polar store packs a ring-mate pair into one line, to
test the model's own cell-to-line mapping.
