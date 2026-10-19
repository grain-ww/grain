# The third night holds the ratio on a later calendar day

**Lane:** Diffuser (moonshots and research)
**Status:** Landed -- **Room:** research for understanding
**Kin:** [the reset is already in the source, and the same-night pair holds the ratio](../20261010/20261010-232345_the-reset-is-already-in-the-source-and-the-same-night-pair-holds.md) - [the sequential sweep replicates below the band on a second night](../20261010/20261010-231930_the-sequential-sweep-replicates-below-the-band-on-a-second-night.md)

## What this note is for

The reset paper named one next door: a third night, on a calendar day other than `20261010`, with
the 2 to 4 huge-to-control ratio band stated before the run. This note is that run. It is one
pair, not a pair of pairs, because the paper asked for a third-night pair.

## Falsifier, stated before the run

Written in `20261010.232345` (the reset paper) and not changed since: a third-night pair lands
outside the 2 to 4 band on one or both arms, and the ratio is then not stable on this guest.

## Observation

Run once each from `session-output/hugepage-chase/`, on this guest, at `20261011.001553`
(New York). Binaries are the untracked scratch pair the reset paper names; no source was edited.

| Arm | Misses | Accesses | Permille | `anon_huge_kb` |
|---|---|---|---|---|
| Huge (requested 2 MiB) | 110,452 | 1,048,576 | 105 | 63,488 |
| Control (4 KiB) | 284,268 | 1,048,576 | 271 | 0 |

Control over huge: 271 / 105 = 2.58.

## Inference

The ratio sits inside the stated band, so the falsifier did not fire on its ratio branch. The
huge arm was granted pages (63,488 kB of a 64 MiB buffer), though fewer than the 65,536 kB the
same-night pairs read. That is a partial grant, and this note does not reproduce it as a full one.

Two figures moved against earlier nights. The control's permille (271) sits below the 312 to 339
range the earlier sweep papers recorded, and the huge arm's granted kB is short of the earlier
65,536. The falsifier as written tests the ratio, not the absolute permille, so these are reported
here and not counted as a fire.

## Projection

- **Horizon:** the ratio's direction holds on this guest across three calendar days when measured
  with the same binaries. A projection past that horizon is out of scope.
- **Assumptions:** the scratch binaries are unchanged since `20261009`; the guest's kernel and page
  policy are unchanged; the huge arm's partial grant does not bias the ratio downward by much.
- **Falsifier, for the next night:** a pair on a fourth calendar day with the same 2 to 4 band lands
  outside it on one or both arms.
- **Confidence:** moderate on the direction, which now holds on three days. Low on the band edges,
  which one pair cannot fix. Low on the absolute permille, which moved below the earlier range and
  has no explanation yet.

## What this does not say

It does not explain why the counter reads so far below one miss per fill. The prefetch candidate
stays open, and its own falsifier needs a prefetch-disabled run the guest still blocks.

## Next door

A fourth-night pair on a later calendar day, with the same 2 to 4 band stated before that run and
the huge arm's granted kB printed beside its permille.
