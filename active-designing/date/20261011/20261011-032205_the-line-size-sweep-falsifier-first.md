# The line-size sweep -- does the cache-line size move the padded penalty, falsifier first

**Status:** Design -- falsifier stamped before the run (clock `20261011.032205`); result read after the run
**Room:** research for understanding (scratch model; nothing here is checkable hardware)
**Kin:** [line-padded rings](20261011-031717_the-line-padded-rings-falsifier-first.md) - [two-sided radial stencil](20261011-031438_the-two-sided-radial-additivity-falsifier-first.md)

## Ordering, said plainly

The falsifier below was stated at clock `20261011.032205`, and the sweep ran between `20261011.032205`
and `20261011.032221`. This file is written after the run, so its wording is the record of the
falsifier and not a copy of text written beforehand. The sweep is the next door the line-padded paper
named.

## Plain sentence first

The line-padded paper aligned each ring to a line boundary at 8 cells per line and found the ratio moved
by 0.01. That single line size leaves open whether the result holds at other line sizes. This sweep runs
the same padding at 4 and 16 cells per line.

## What changes, and what does not

- **Unchanged:** the disk, the ring structure, the stencil, the fully associative LRU model, the
  working-set floor search, and the Cartesian layout. The script's logic is the same file as the
  line-padded run, with one change: the `LINE` constant reads from the environment instead of being
  fixed at 8. The copy is `session-output/polar-padded/padded_line.py`, untracked scratch.
- **Varied:** `LINE` in {4, 8, 16}. Each size runs unpadded and padded at N in {64, 128, 256}.

## Falsifier (stated at `20261011.032205`, before the sweep)

1. **Baseline reproduction.** At `LINE = 8` and N = 256, 5 percent, the unpadded ratio must read 3.02
   and the padded ratio 3.03, each within 0.02. If not, the script has drifted and no other row counts.
2. **Main falsifier (padding moves the penalty at this line size).** At any `LINE` in {4, 16}, if the
   padded ratio at N = 256 and 5 percent differs from the unpadded ratio at the same `LINE` by more than
   0.10, the line alignment carries part of the penalty at that size. This fires the main falsifier.
3. **Direction falsifier.** At any `LINE` in {4, 8, 16}, if the padded ratio at N = 256 and 5 percent
   falls below 2.50, padding removes most of the penalty, which contradicts the access-count account.
   This fires it.

**What "did not fire" means:** the baseline holds, and at LINE 4 and 16 the padded ratio sits within 0.10
of the unpadded one and at or above 2.50.

## Horizon, assumptions, falsifier, confidence

- **Horizon:** the scratch model only. No hardware is claimed, and no associativity or prefetch.
- **Assumptions:** fully associative LRU; the same disk and the same 5 and 10 percent tolerances; line
  size in cells is the only varied parameter.
- **Falsifier:** as above, stated at `20261011.032205`.
- **Confidence:** moderate. Padding moves only one boundary per ring, so a small effect is expected. The
  line size itself could move the unpadded ratio, which the padding falsifier does not test.

## Result

Command: `LINE=<L> python3 -I padded_line.py <nopad|pad> 64 128 256`, output in
`session-output/polar-padded/run_sweep.txt`. Ratios are the polar floor over the Cartesian floor.

| LINE (cells per line) | N | Unpadded 5 percent | Padded 5 percent | Unpadded 10 percent | Padded 10 percent |
|---|---|---|---|---|---|
| 4 | 64 | 2.90 | 2.90 | 2.90 | 2.90 |
| 4 | 128 | 3.07 | 3.07 | 2.98 | 2.98 |
| 4 | 256 | **3.07** | **3.07** | 3.00 | 3.00 |
| 8 | 64 | 2.73 | 2.77 | 2.76 | 2.84 |
| 8 | 128 | 2.98 | 3.00 | 2.94 | 2.98 |
| 8 | 256 | **3.02** | **3.03** | 2.94 | 2.95 |
| 16 | 64 | 2.57 | 2.64 | 2.50 | 2.64 |
| 16 | 128 | 2.74 | 2.78 | 2.77 | 2.81 |
| 16 | 256 | **2.90** | **2.94** | 2.88 | 2.92 |

**Falsifiers, read against the N = 256, 5 percent column.**

- *Baseline.* At LINE 8 the unpadded ratio reads 3.02 and the padded 3.03, exactly the earlier figures.
  The baseline falsifier did not fire.
- *Main.* Padded minus unpadded is 0.00 at LINE 4 and 0.04 at LINE 16, both inside the 0.10 band. The
  main falsifier did not fire.
- *Direction.* The lowest padded ratio at N = 256, 5 percent is 2.94 at LINE 16, above 2.50. The
  direction falsifier did not fire.

**Observation.** Padding leaves the ratio within 0.04 at every line size tested. Separately, the unpadded
ratio at N = 256 and 5 percent moves with line size: 3.07 at 4 cells per line, 3.02 at 8, and 2.90 at 16.
That is a 0.17 spread, which is above the 0.10 band the padding falsifier used, so the line size matters
even though the alignment does not.

**Inference.** Alignment does not drive the penalty at any size tested. The line size does shift the ratio
mildly and in one direction: larger lines lower it, because each line packs more neighbouring cells that
the Cartesian layout reuses. That shift is a line-count effect of the layout, and the model does not yet
say which share of it is the padded-versus-unpadded mapping and which is the line size itself.

**Limits.** Three line sizes, one disk, and one associativity model. The 0.17 spread comes from one
N = 256 point per line size, and the 5 and 10 percent columns differ by up to 0.07 at LINE 4 and 16 at
N = 64, so the spread is a single-point reading.

## Next door

Set associativity is the door the set-associative paper already names. A second door inside this model
is a line-size sweep at 2 and 32 cells per line, which would test whether the 4-to-16 trend keeps its
direction past its own ends. Its falsifier is to be written, stamped, and only then run.
