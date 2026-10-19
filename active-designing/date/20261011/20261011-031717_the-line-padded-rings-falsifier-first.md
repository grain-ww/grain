# The line-padded rings -- does aligning each ring to a cache line move the penalty, falsifier first

**Status:** Design -- falsifier written before the run (clock `20261011.031717`); result to be read after the run
**Room:** research for understanding (scratch model; nothing here is checkable hardware)
**Kin:** [two-sided radial stencil](20261011-031438_the-two-sided-radial-additivity-falsifier-first.md) - [inward radial neighbour](20261011-030835_the-inward-radial-neighbour-falsifier-first.md) - [one-sided radial neighbour](20261011-030258_the-one-radial-neighbour-falsifier-first.md)

## Plain sentence first

The two-sided paper named a cache-line-aware variant as its next door: test whether the model's
cell-to-line mapping drives the polar penalty. That variant had no file on disk when this lap opened,
so this paper defines one precise version, writes its falsifier, and only then runs it.

## What changes, and what does not

- **Unchanged:** the disk, the ring structure, the stencil (self, two ring-mates, nearest cell on the
  ring outward and on the ring inward, the two-sided stencil), the LRU model with 8 cells per line, the
  working-set floor search, and the Cartesian layout.
- **Changed, polar only:** each ring starts on a line boundary. Ring `r` begins at the first multiple of
  8 at or after the end of ring `r-1`. Padding cells hold no data and are never accessed.
- **Why this variant:** unpadded, a line can straddle two rings, so one line in the polar store can hold
  cells from two rings whose reuse differs. Padding removes every such straddle and keeps every ring's
  cells in whole lines. It is the simplest way to test whether the line mapping, as opposed to the
  stencil's access count, carries the penalty.

## Falsifier (written before the run, clock `20261011.031717`)

1. **Baseline reproduction.** The unpadded run at N = 256 and 5 percent must read a two-sided ratio of
   3.02 within 0.02. If it does not, the script has drifted and no padded result counts.
2. **Main falsifier (line mapping moves the penalty).** If the padded two-sided ratio at N = 256 and
   5 percent differs from the unpadded 3.02 by more than 0.10, the line mapping carries part of the
   penalty and the access count does not explain all of it. This fires the main falsifier.
3. **Direction falsifier.** If the padded ratio falls below 2.50, padding removes most of the penalty.
   That would contradict the claim that the stencil's access count sets the penalty. This fires it.

**What "did not fire" will mean:** a padded ratio within 0.10 of 3.02 and at or above 2.50. Then the
line mapping is not the driver at this line size, and the penalty belongs to the access pattern.

## Horizon, assumptions, falsifier, confidence

- **Horizon:** the scratch model only. No hardware is claimed.
- **Assumptions:** fully associative LRU, 8 cells per line, the same 5 and 10 percent tolerances, the
  same disk. Set associativity and prefetch are not modeled.
- **Falsifier:** as written above, at clock `20261011.031717`.
- **Confidence:** low to moderate. Padding touches one boundary per ring, about 127 at N = 256, out of
  roughly 51,000 disk cells, so I expect a small move, and the expectation is itself a claim the run can
  break.

## Result

Run between `20261011.031727` and `20261011.031732` with `python3 -I padded.py nopad 64 128 256` and
`python3 -I padded.py pad 64 128 256` in the untracked scratch directory `session-output/polar-padded/`.
Floors are the smallest LRU capacity, in lines, whose misses stay within the tolerance of the compulsory
count.

| N | Variant | Polar over Cartesian, 5 percent | 10 percent |
|---|---|---|---|
| 64 | unpadded | 2.73 | 2.76 |
| 64 | padded | 2.77 | 2.84 |
| 128 | unpadded | 2.98 | 2.94 |
| 128 | padded | 3.00 | 2.98 |
| 256 | unpadded | **3.02** | 2.94 |
| 256 | padded | **3.03** | 2.95 |

**Falsifiers, read against the N = 256, 5 percent row.** The baseline reproduction falsifier did not fire:
the unpadded script reads 3.02, exactly the earlier figure. The main falsifier did not fire: the padded
ratio sits 0.01 from 3.02, far inside the 0.10 band. The direction falsifier did not fire: 3.03 is well
above 2.50.

**Observation.** Padding moved the distinct-line count on the polar side (6,434 unpadded against 6,479
padded at N = 256), since each ring now occupies whole lines. The ratio moved by 0.01, which is smaller
than the spread the three sizes already show.

**Inference.** On this model, the cell-to-line mapping at 8 cells per line does not drive the polar
penalty. The access count and the stencil's reuse distances carry it. This is one padding variant at one
line size, so it narrows the claim rather than settling the mechanism.

**Next door.** The line-size sweep: run the same padding at 4 and 16 cells per line. Its falsifier is
written before that run. Set associativity is a separate door, already named by the set-associative paper.
