# The reset is already in the source, and the same-night pair holds the ratio

**Lane:** Diffuser (moonshots and research)
**Status:** Landed -- **Room:** research for understanding
**Kin:** [the sequential sweep replicates below the band on a second night](20261010-231930_the-sequential-sweep-replicates-below-the-band-on-a-second-night.md) - [the sequential sweep reads low on both page sizes](../20261009/20261009-233229_the-sequential-sweep-reads-low-on-both-page-sizes.md)

## What this note is for

The second-night paper named two next doors. Option 1 was a third night with the same binaries,
with the falsifier stated before the run. Option 2 was a reading check: confirm that the warm-up's
own misses sit outside the counted lap. This note takes option 2 by reading the source, then runs
the same two binaries once more, on the same night, as a check that they still work. It does not
claim the third-night result.

## Observation: the reset is already in the source

The mechanism in plain words, from `session-output/hugepage-chase/sweep_huge.zig`:

1. The counter is opened with `disabled = true`, so it counts nothing until it is enabled.
2. The buffer is written once in address order (page faults happen here).
3. An untimed warm-up reads every line once.
4. Only then: `PERF.EVENT_IOC.RESET`, then `PERF.EVENT_IOC.ENABLE`, then the counted lap, then
   `DISABLE`.

So the warm-up's misses are never in the count, because the counter is reset and enabled after
the warm-up. Option 2's concern is already answered by the code. The prior paper's note that the
warm-up "is untimed" was right, and the counter being "enabled only after it" is the reset the
option asked for. No new run is needed to settle it.

**Scope of that claim.** It covers the counter-window logic only. It does not cover what the
kernel counts during the counted lap, which is the open prefetch question from the earlier paper.

## Observation: the same-night rerun, two pairs

Run once each, twice, in the scratch directory, on this guest, read `20261010.232345` (New York):

| Pair | Huge arm (requested 2 MiB) | Control (4 KiB) | Control / huge |
|---|---|---|---|
| 1 | 100,562 misses, 95 permille, `AnonHugePages` 65,536 kB | 335,322 misses, 319 permille | 3.33 |
| 2 | 96,368 misses, 91 permille, `AnonHugePages` 65,536 kB | 328,849 misses, 313 permille | 3.41 |

Accesses per run: 1,048,576 (64 MiB at 64-byte lines). The huge arm's `AnonHugePages` figure
confirms that the requested pages were granted, so the huge arm is not a silent fallback.

## Inference

Both pairs sit inside the 2 to 4 ratio band the second-night paper stated as its falsifier. This
is the same direction as the earlier nights: the huge arm reads lower than the control in every
pair. The absolute permille figures sit near the earlier nights' values, and the drift the earlier
paper described is still present.

## Projection, with its horizon, falsifier, and confidence

- **Horizon:** the third night has to be a different calendar day from `20261010`. Tonight's pairs
  do not count toward it, so the ratio's evidence stays at six runs over two nights, plus two more
  on this same night, which are not independent of the second night.
- **Projection:** the huge-to-control ratio stays in roughly 2 to 4 on this guest.
- **Falsifier:** a third-night pair, with the 2 to 4 band stated before that run, lands outside
  the band on one or both arms. If that happens, the ratio is not a stable quantity on this guest,
  and the absolute figures cannot be used to compare nights either.
- **Confidence:** moderate on the direction, low on the exact band edges. Eight pairs in total
  (six from earlier nights plus two tonight) are enough to say the direction holds and too few to
  fix the band.

## What this does not say

Why the counter reads so far below one miss per fill is still open. The prefetch explanation
remains a candidate, and its falsifier (a prefetch-disabled run that lands in the band) was not
run here, since the guest still blocks that control. Nothing in this note moves that question.

## Next door

Run the third night on a later calendar day, stating the 2 to 4 falsifier in the paper before the
run. This note does not run it, because the same-night rerun is not a third night.

*The scratch binaries stay in `session-output/hugepage-chase/`, untracked. This paper carries the
readings and the falsifier so the record survives the scratch directory.*
