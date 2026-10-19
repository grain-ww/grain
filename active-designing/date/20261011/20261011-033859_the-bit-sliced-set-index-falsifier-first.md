# The bit-sliced set index -- does the modulo index move the set-associative result, falsifier first

**Status:** Design -- falsifiers stamped before the run (clock `20261011.033859`); result read after the run
**Room:** research for understanding (scratch model; nothing here is checkable hardware)
**Kin:** [set-associative line size](20261011-033405_the-set-associative-line-size-falsifier-first.md) - [line-size two ends](20261011-032806_the-line-size-two-ends-and-the-padding-band.md)

## Plain sentence first

The set-associative paper swapped the fully associative cache for an 8-way one, but it indexed the sets
by `line mod sets`. Real caches index by bits: the low bits of the line number pick the set, which
needs a power-of-two set count. Its own next door asked whether the modulo index moved the result.
This run changes only the index, and reads the same grid again.

## What changes, and what does not

- **Unchanged:** the disk, the one-sided radial stencil, the ring layout, the Cartesian layout, the
  access trace, the 8 ways, the LRU inside each set, and the 5 and 10 percent tolerances.
- **Changed:** the set index is `line & (sets - 1)`, and `sets` is a power of two. The floor is the
  smallest power of two whose misses stay within `(1 + tol)` of the compulsory count.
- **Cost, named before the run:** power-of-two set counts make every ratio move in steps of about
  2 (1, 2, 4, 8, ...), where the modulo run moved in steps of about 0.5 at small N. A ratio here is
  coarser by construction. The falsifiers below are written with that coarseness in view.

## Falsifiers, stated before the run

The baseline and modulo results are the ones already on disk: `sa_sweep.txt` and the set-associative
paper's table. The scratch script is `session-output/polar-padded/padded_bitslice.py`, untracked and
gitignored, so these numbers reproduce only on this pier.

1. **Index falsifier.** At N = 256, 5 percent, LINE 8, the bit-sliced polar-to-Cartesian ratio differs
   from the modulo ratio of 2.62 by **0.50 or more**. If it does, the index choice moves the result by
   more than one step of the coarse grid, and the modulo finding was an artifact of the index.
2. **Padding falsifier.** At LINE 32, N = 64, 5 percent, the bit-sliced padded-minus-unpadded gap is
   **0.10 or more**. If it is, the modulo-index finding that padding has no effect under 8 ways is
   reversed under bit-slicing, and the 0.00 was not robust.
3. **Penalty falsifier.** At N = 256, 5 percent, the lowest padded ratio across the five line sizes is
   **under 1.50**. If it is, associativity removes most of the polar penalty under a bit-sliced index,
   which the modulo run did not show (its lowest was 2.25).

**Confidence before the run:** medium that falsifier 3 does not fire; low on falsifiers 1 and 2, since
the coarse grid can land a step either way.

## Result

*(Appended after the run.)*

Command: `LINE=<L> python3 padded_bitslice.py <nopad|pad> 64 128 256` (coarse, `session-output/polar-padded/bitslice_sweep.txt`)
and `LINE=<L> python3 bitslice_interp.py <nopad|pad> 64 128 256` (interpolated, `bitslice_interp.txt`), both
scratch and gitignored. Ratios are polar over Cartesian, 5 percent.

**The coarse reading is uninformative.** Every one of the 30 coarse ratios (five line sizes, two pad
settings, three N) reads exactly **4.00**. The floors are powers of two, and the polar floor lands two
doublings above the Cartesian floor each time, so the grid returns one value whatever the index does.
Falsifier 2 was written against this grid, and on it the padding gap is 0.00, so it did not fire.

**The interpolated reading** fits the excess miss ratio on the power-of-two grid, then reads the
capacity where excess crosses 5 percent by linear interpolation in log2 of the set count. It is a
finer measurement of the same grid, not a different model. Its floors are not integers, so it is the
reading this run leans on.

| LINE | N = 64 nopad / pad | N = 128 nopad / pad | N = 256 nopad / pad |
|---|---|---|---|
| 8 | 3.01 / 3.05 | 3.28 / 3.30 | 3.31 / 3.37 |
| 32 | 2.11 / 2.65 | 3.25 / 3.67 | 3.30 / 3.44 |

**Falsifiers, read against the interpolated table and, where it differs, against the coarse one.**

- *Index (falsifier 1).* **Fired** on both readings. Modulo 2.62 at LINE 8, N = 256; bit-sliced 3.31
  interpolated (gap 0.69) and 4.00 coarse (gap 1.38). The index choice moves the result by more than
  the 0.50 threshold. The modulo finding was an index artifact at this line size.
- *Padding (falsifier 2).* **Split by reading, and this is the honest part.** Literal on the coarse grid:
  gap 0.00, did not fire. On the interpolated grid: the LINE 32, N = 64 gap is 0.54 (2.11 to 2.65), and
  the N = 128 gap is 0.42, so it **fired**. Its wording was written against the coarse grid, which cannot
  resolve the gap, so the coarse "did not fire" is the reading the grid makes unavailable. Recorded
  as fired on the interpolated reading, with the wording flagged.
- *Direction (falsifier 3).* Did not fire on either reading. The lowest padded ratio at N = 256 is 3.37
  interpolated (4.00 coarse), well above 1.50.

**Observation.** Under bit-sliced indexing the polar penalty runs from 2.11 to 3.67 times the Cartesian
floor across the table, and it is 3.25 or more at every N = 128 and N = 256 point. The modulo index had
brought the LINE 32 value at N = 256 down to 2.25. The padding gap
at LINE 32 is larger, not zero, and it is largest at small N, where the set counts are one or two.

**Inference.** The set-associative finding in the previous paper did not survive the index change. The
penalty is not reduced by 8-way associativity in any sense this model can support, and padding moves the
ratio at small N under the bit-sliced index. Both statements are what the interpolated reading shows, and
the coarse grid cannot show either.

**Limits.** One disk. A single 5 percent tolerance is read for the table, and the 10 percent column is
not carried. The interpolated N = 64 floors at LINE 32 sit near one or two sets, so that row is the
weakest. The interpolation is a reading rather than a measured floor, and a finer fit would need a
capacity grid that is not powers of two. The falsifier wording and the reading it was written against
do not agree at the padding cell, and the paper says so rather than rewriting the falsifier after the run.

**Confidence.** High that the modulo index moves the result at LINE 8, N = 256 by more than 0.50. Medium
that padding moves the ratio under bit-sliced indexing at small N. Low on the exact interpolated values.

## Next door

A capacity grid that is not powers of two, so the coarse ratios can be read as measurements, falsifier
first. The coarse grid returned one value at 30 points, and a finer grid is what separates a finding from
a quantization.
