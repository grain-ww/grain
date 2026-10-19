# The set-associative line size -- does the LINE 32 padding gap survive 8 ways, falsifier first

**Status:** Design -- falsifier stamped before the run (clock `20261011.033405`); result read after the run
**Room:** research for understanding (scratch model; nothing here is checkable hardware)
**Kin:** [line-size two ends and the padding band](20261011-032806_the-line-size-two-ends-and-the-padding-band.md) - [line-size sweep](20261011-032205_the-line-size-sweep-falsifier-first.md)

## Plain sentence first

The line-size paper found one cell where aligning each polar ring to a line boundary moved the
penalty: LINE 32, N = 64, 5 percent, a gap of 0.22. Its own next door was to ask whether that gap is a
mapping effect or an artifact of the fully associative cache the whole model assumes. Real caches are
set-associative, so this run swaps the cache for an 8-way set-associative one and reads the same cell
again.

## What changes, and what does not

- **Unchanged:** the disk, the one-sided radial stencil, the ring layout, the Cartesian layout, the
  access trace, and the 5 and 10 percent tolerances.
- **Changed:** the cache. Capacity is counted in **sets** of 8 ways, so a set count `s` holds `8 s`
  lines. The set index of a line is `line mod s`, and each set is an independent LRU of 8 lines. The
  floor is the smallest `s` whose misses stay within `(1 + tol)` of the compulsory count, so the polar
  and Cartesian floors are both counted in sets and their ratio is read the same way as before.
- **Varied:** `LINE` in {2, 4, 8, 16, 32}, layout padded or not, N in {64, 128, 256}.
- **Scratch file:** `session-output/polar-padded/padded_setassoc.py`, untracked and gitignored.

## Falsifiers (stated at `20261011.033405`, before the run)

1. **Baseline reproduction.** The set-associative script is not run as a new baseline; instead the
   existing fully associative script `padded_line.py` is run again at LINE 32, N = 64 and must reproduce
   the table's 2.00 unpadded and 2.22 padded readings within 0.01. If it does not, the script has drifted
   and no other row counts.
2. **Main falsifier (the mapping is an artifact of full associativity at this size).** At LINE 32,
   N = 64, 5 percent, the set-associative gap between padded and unpadded ratios falls **below 0.10**.
   If it falls below 0.10, the 0.22 reading was a fully associative effect and does not carry to 8 ways.
   This is the falsifier the line-size paper named. If it stays at or above 0.10, the mapping is real at
   this size under 8 ways.
3. **Band falsifier (the other cells stay quiet).** At LINE 2 and 4, the padded and unpadded
   set-associative ratios differ by no more than 0.02 at every N. At LINE 8 and 16, every gap stays
   within 0.10. If either band breaks, a set-associative mapping effect is present where the fully
   associative model showed none.
4. **Direction falsifier.** At N = 256, 5 percent, the lowest set-associative padded ratio across all
   five line sizes stays at or above 2.50. Falling below 2.50 would mean associativity removes most of
   the penalty, which contradicts the access-count account.

**What "did not fire" means:** the baseline holds, the LINE 32, N = 64 gap is at or above 0.10, the
band holds at every other cell, and the direction floor stays at or above 2.50.

## Horizon, assumptions, falsifier, confidence

- **Horizon:** the scratch model only. No hardware is claimed, and no prefetch, no multi-level cache,
  no real replacement policy beyond LRU within a set.
- **Assumptions:** 8 ways, LRU within each set, set index is the low-order line number modulo the set
  count (a modulo hash, not the bit-slice real caches use), the same disk and stencil.
- **Falsifier:** as above, stated at `20261011.033405`.
- **Confidence:** moderate on the direction of the answer, low on the exact gap. A modulo set index can
  differ from a bit-sliced one by a few percent, and one N = 64 point carries the main falsifier.

## Result (run `20261011.033526`, read after the run)

Command: `LINE=<L> python3 -I padded_setassoc.py <nopad|pad> 64 128 256`, output in
`session-output/polar-padded/sa_sweep.txt`. Ratios are polar sets over Cartesian sets, at 5 percent.
The fully associative baseline was rerun first: `LINE=32 python3 -I padded_line.py` reads 2.00 unpadded
and 2.22 padded at N = 64, so falsifier 1 did not fire.

| LINE | N = 64 nopad / pad | N = 128 nopad / pad | N = 256 nopad / pad |
|---|---|---|---|
| 2 | 3.00 / 3.00 | 3.09 / 3.09 | 3.12 / 3.12 |
| 4 | 2.83 / 2.83 | 2.83 / 2.83 | 2.91 / 2.91 |
| 8 | 2.25 / 2.25 | 2.43 / 2.43 | 2.62 / 2.62 |
| 16 | 2.50 / 2.50 | 2.25 / 2.25 | 2.43 / 2.43 |
| 32 | 1.50 / 1.50 | 2.50 / 2.50 | 2.25 / 2.25 |

**Falsifiers, read against the table.**

- *Baseline (falsifier 1).* Did not fire: the fully associative rerun matches the table's 2.00 and 2.22.
- *Main (falsifier 2).* **Fired.** At LINE 32, N = 64, 5 percent, the padded-minus-unpadded gap is 0.00,
  below 0.10. The 0.22 reading does not carry to 8 ways. Caveat: at N = 64 the set counts are 2 and 3,
  so the ratio moves only in steps of about 0.5. The 0.00 is one set of granularity, and it is weak evidence.
- *Band (falsifier 3).* Did not fire: every padded-minus-unpadded gap is 0.00 at every line size and N.
- *Direction (falsifier 4).* **Fired by its letter.** The lowest padded ratio at N = 256, 5 percent is
  2.25 at LINE 32, under 2.50. The falsifier was written to catch associativity removing *most* of the
  penalty. It did not: 2.25 still reads a polar floor more than twice the Cartesian one. The wording was
  looser than the claim it meant to test, and that is recorded here rather than rewritten.

**Observation.** Set associativity lowers the N = 256 ratio at every line size from 4 cells up (at 2 cells it reads slightly higher, 3.12 against 3.09),
and at LINE 32 it lowers the N = 256 ratio from 2.74 (fully associative) to 2.25. Padding changes no
set count anywhere in this grid.

**Inference.** The padding effect at LINE 32, N = 64 was an artifact of full associativity at that one
point. The mapping does not drive the penalty under 8 ways at any tested size. The line size still moves
the ratio, and the associativity model moves it further.

**Limits.** Modulo set index, not the bit-sliced index real caches use. LRU within sets only. One disk.
Set counts are integers, so small-N ratios are coarse. Scratch file untracked and gitignored, so the
numbers are reproducible only on this pier.

**Confidence.** Medium on "padding has no effect under 8 ways." Low on the LINE 32, N = 64 value itself.

## Next door

Not written. The next door is a bit-sliced set index, falsifier first, which would test whether the
modulo index moved the results. It stays unbooked until this round closes.
