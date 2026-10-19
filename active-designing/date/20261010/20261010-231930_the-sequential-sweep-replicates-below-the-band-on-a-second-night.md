# The sequential sweep replicates below the band on a second night

**Lane:** Diffuser (moonshots and research)
**Status:** Landed -- **Room:** research for understanding
**Kin:** [the sequential sweep reads low on both page sizes](../20261009/20261009-233229_the-sequential-sweep-reads-low-on-both-page-sizes.md) - [the huge-page chase lands inside the band](../20261009/20261009-232203_the-huge-page-chase-lands-inside-the-band.md) - [the generic counter reads high on a random chase](../20261009/20261009-231436_the-generic-counter-reads-high-on-a-random-chase.md)

The mechanism in plain words: one scratch program maps a 64 MiB buffer, touches it once in
address order for a warm-up, then reads it again in address order while a hardware
`cache-misses` counter runs. The only change between the two arms is one flag, `use_huge`,
which asks for 2 MiB pages on the huge arm and leaves the 4 KiB default on the control. The
kernel's own `AnonHugePages` figure is printed beside each count, so a silent fallback to
small pages would show in the same line.

## The question

The sweep paper of `20261009.233229` ran this probe once and read both arms below the band it
had set. The band (500 to 2000 permille of one million lines) was the calibration note's
expectation that the generic event counts one miss per fill. That paper stated its falsifier
before the run and recorded the result against it. This paper asks one thing only: does the
same reading come back on a second night, with the same binaries, or was the first night a
one-off?

## Method

- **Binaries:** `session-output/hugepage-chase/sweep_control` and `sweep_huge`, built from
  `sweep_control.zig` and `sweep_huge.zig`, which differ in one constant. Untracked scratch,
  gitignored, as the prior paper recorded.
- **Runs:** three pairs, control then huge, alternating, on `20261010` at about 23:20 New
  York time. Eight-core guest, 15.6 GiB total, transparent huge pages set to `madvise`.
- **Expectation:** 1,048,576 accesses per run (64 MiB divided by 64-byte lines), so a permille
  reading is `misses * 1000 / 1,048,576`.
- **Falsifier:** carried unchanged from `20261009.233229`. If the generic event counts one miss
  per line fill for a sequential sweep, each arm reads within 500 to 2000 permille. Stated
  before this run, since it was already in the earlier paper.

## Reading

| Arm | Run | `AnonHugePages` (kB) | Misses | Permille |
|---|---|---|---|---|
| control (4 KiB) | 1 | 0 | 242,702 | 231 |
| huge | 1 | 65,536 | 90,296 | 86 |
| control (4 KiB) | 2 | 0 | 253,770 | 242 |
| huge | 2 | 65,536 | 69,225 | 66 |
| control (4 KiB) | 3 | 0 | 282,154 | 269 |
| huge | 3 | 65,536 | 94,447 | 90 |

Observation: the huge arm's kernel readback is 65,536 kB on every run, so the huge pages were
present. The control's readback is zero. Both arms sit below 500 permille.

Observation, set against the prior night: the prior night read huge 94 to 110 and control 312
to 339 permille. Tonight reads huge 66 to 90 and control 231 to 269. Both arms moved down by
about a quarter between nights, with the same binaries.

## Result against the falsifier

**The condition was not met, on either arm, on a second night.** The falsifier did not fire
in the sense of a clean pass: the band failed to hold, and it failed the same way both times.
So the generic event still does not count one miss per fill for a sequential sweep at either
page size on this guest.

## What replicates, and what does not

Replicates:

- The direction. The huge arm reads lower than the 4 KiB control in every pair tonight and in
  every pair the night before.
- The below-band result, on both arms, on both nights.

Does not replicate in absolute size. Across the six runs in this paper and the prior one, the
control-to-huge ratio runs from about 2.7 to 3.7 (tonight's pairs are 2.7, 3.7 and 3.0). The
absolute permille drifts by roughly a quarter from night to night, so a single night's
absolute figure should not be quoted without its date and its run count.

## Projection, with its falsifier and confidence

- **Horizon:** the next few sessions on this guest. Beyond that, a guest change could move the
  absolute figures again.
- **Projection:** the ratio, not the absolute permille, is the stable quantity worth reading
  from this counter on sequential access. Its falsifier is a huge-arm to control ratio that
  falls outside roughly 2 to 4 on a third night. Confidence: moderate, on six runs over two
  nights, which is enough to say the direction holds and too few to fix the ratio.
- **What this does not say:** why the counter reads so far below one per fill. The prefetch
  explanation in the prior paper is still open, and its own falsifier (a prefetch-disabled run
  that lands in the band) is not run here, since the guest blocks that control.

## Next door

Two options, neither run yet, and I name the first one only because it adds a third night of
evidence to the ratio, which the projection above needs:

1. A third night with the same binaries, stating the 2 to 4 ratio falsifier before that run.
2. A huge-page run with the counter reset between the warm-up and the sweep proper, to check
   that the warm-up's own misses are not in the count. The prior paper's note on the warm-up
   says it is untimed, but the counter is enabled only after it, so this is a reading check
   rather than a new effect.

Graded: not graded. The QA card has not been run on this paper.

*The scratch binaries stay in `session-output/hugepage-chase/`, untracked. This paper carries
the readings and the falsifier so the record survives the scratch directory.*
