# The line-size sweep at two ends -- padding leaves the ratio alone except at 32 cells, where a single cell crosses its band

**Status:** Design -- scratch model only, no hardware. Written at clock `20261011.032806` after the sweep ran.
**Room:** research for understanding (scratch model; no witness binds it yet)
**Kin:** [line-size sweep](20261011-032205_the-line-size-sweep-falsifier-first.md) - [line-padded rings](20261011-031717_the-line-padded-rings-falsifier-first.md) - [two-sided radial stencil](20261011-031438_the-two-sided-radial-additivity-falsifier-first.md)

## Order of events, stated first because it matters to the reading

The line-size paper at `20261011.032205` named this door: a sweep at 2 and 32 cells per line, testing
whether the 4-to-16 trend keeps its direction past its own ends. Its falsifiers were stated in that
paper before its own run, and this door uses them unchanged:

- *Main.* Padded minus unpadded at N = 256 and 5 percent stays inside the 0.10 band at each line size tested.
- *Direction.* The lowest padded ratio at N = 256 and 5 percent stays above 2.50.
- *Baseline.* LINE 8 reproduces 3.02 unpadded and 3.03 padded at N = 256, 5 percent.

**I broke the order I meant to keep.** I ran the 2 and 32 cells per line sweep before writing a new
falsifier stamp for this door. The first run was partial: the LINE 8 baseline, plus LINE 2 and 32
unpadded at N = 128 and 256. I then ran the full grid, all five line sizes, padded and unpadded, at N = 64,
128 and 256. The three falsifiers above were already on the page before either run, so they are the
pre-stated ones. What was not pre-stated is any threshold for a new N = 64 reading, which the full grid
added. Read every figure below with that in mind. The model is deterministic, so a rerun would print the
same numbers and would not repair the order.

## Method

The scratch model is `session-output/polar-padded/padded_line.py`, untracked and gitignored. Its inputs are
the N x N disk of radius `n//2 - 1`, the one-sided radial stencil (self, two ring-mates, and the nearest
cell on each adjacent ring), and a fully associative LRU cache. The floor is the smallest capacity whose
miss count stays within `(1 + tol)` of the compulsory count, at tol = 5 and 10 percent. The line size is
the environment variable `LINE`. `pad` aligns each polar ring to a line boundary, and `nopad` does not.

## Observation

Polar floor over Cartesian floor at 5 percent (tol = 0.05), read from the grid run:

| LINE | layout | N = 64 | N = 128 | N = 256 |
|---|---|---|---|---|
| 2 | nopad | 2.94 | 3.10 | 3.09 |
| 2 | pad | 2.94 | 3.10 | 3.09 |
| 4 | nopad | 2.90 | 3.07 | 3.07 |
| 4 | pad | 2.90 | 3.07 | 3.07 |
| 8 | nopad | 2.73 | 2.98 | 3.02 |
| 8 | pad | 2.77 | 3.00 | 3.03 |
| 16 | nopad | 2.57 | 2.74 | 2.90 |
| 16 | pad | 2.64 | 2.78 | 2.94 |
| 32 | nopad | 2.00 | 2.47 | 2.74 |
| 32 | pad | 2.22 | 2.53 | 2.81 |

Padded minus unpadded, at 5 percent, is 0.00 at LINE 2 and 4 for every N, 0.04 to 0.07 at LINE 8 and 16,
and 0.22, 0.06 and 0.07 at LINE 32 for N = 64, 128 and 256. At 10 percent the LINE 32 gap is 0.13 at N = 64.

## Falsifiers, read against the table

- **Main (padding moves the penalty, band 0.10).** Fired once: LINE 32, N = 64, 5 percent, gap 0.22, and at 10 percent, gap 0.13. Every other cell is inside the band.
- **Direction (lowest padded ratio at N = 256, 5 percent, above 2.50).** Did not fire. The lowest is 2.81 at LINE 32.
- **Baseline (LINE 8 reproduces 3.02 and 3.03).** Did not fire.

## Inference

The unpadded trend keeps its direction past the old ends. At N = 256, 5 percent it reads 3.09, 3.07, 3.02, 2.90, 2.74 at LINE 2, 4, 8, 16, 32: monotone decreasing with line size. Larger lines pack more neighbouring cells per line, so the Cartesian layout reuses more of them. That matches the earlier reading.

Padding does nothing at LINE 2 and 4. A ring of this size already sits on a boundary at a line this small, so the alignment changes no line. At LINE 32, a line holds most of a ring at N = 64, so alignment changes which cells share a line and so the miss count. This is the one place in the grid where the mapping, and not only the line count, plausibly moves the ratio.

## Projection, and what would change it

- **Horizon.** The model's own geometry. It says nothing about hardware, whose caches have set-associativity and multi-level structure this model lacks.
- **Assumptions.** Fully associative LRU, one disk, one stencil, one access per cell per step.
- **Falsifier for the LINE 32 reading.** A set-associative model at 8 ways, where the 0.22 gap at N = 64 shrinks below 0.10. If it does not shrink, the mapping is real at this size and not an artifact of full associativity.
- **Confidence.** Medium on the trend. Low on the single 0.22 cell, which rests on one N = 64 point and one disk.

## Next door

Set associativity, at 8 ways over the same disk and line sizes, with its falsifier written and stamped
**before** the run. That is the door the set-associative paper already names. The LINE 32, N = 64 cell
is the first thing it must test.

## Scope

Scratch model only, no hardware, no witness. The scratch file is untracked. The numbers above are
readings of that file as it stood at `20261011.032751`. Rerun to read them again.
