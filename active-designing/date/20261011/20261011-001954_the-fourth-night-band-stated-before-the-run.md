# The fourth-night band, stated before the run

**Lane:** Diffuser (moonshots and research)
**Status:** Proposed -- **Room:** research for understanding
**Kin:** [the third night holds the ratio on a later day](20261011-001603_the-third-night-holds-the-ratio-on-a-later-day.md) - [the reset is already in the source, and the same-night pair holds the ratio](../20261010/20261010-232345_the-reset-is-already-in-the-source-and-the-same-night-pair-holds.md)

## What this note is for

The third-night paper named one next door: a fourth-night pair on a later calendar day, with the
2 to 4 huge-to-control band stated before that run, and the huge arm's granted kB printed beside
its permille. This note writes the band and the falsifier down first, so the run that follows
cannot move them. It runs nothing.

## The calendar gate, measured before this note was written

The fourth night must fall on a calendar day other than `20261010` and `20261011`, because those
two days already carry a pair each. Read on this guest at `20261011.001954` (America/New_York):

| Reading | Value | Source |
|---|---|---|
| Local date at writing | `20261011` | `TZ=America/New_York date`, this lap |
| Same-day pairs already run | 2 nights (`20261010`, `20261011`) | the reset paper and the third-night paper |
| Earliest admissible day for the run | `20261012` | the falsifier's own wording, "a later calendar day" |

So the run waits. A pair taken today would be a fourth reading on a day already counted, and it
would test nothing the paper asks.

## Band and falsifier, stated before the run

Carried unchanged from `20261010.232345` and the third-night paper, and not revised by this note:

- **Band:** the control-over-huge ratio on the same night's pair sits in **2 to 4** on this guest.
- **Falsifier:** a fourth-night pair lands outside 2 to 4 on one or both arms, read as the ratio.
- **Absolute permille is reported, not gated.** The third night showed the control at 271 and the
  huge arm at 105, below the earlier 312 to 339 control range, with no explanation yet. That drop
  was not counted as a fire, and this note keeps the same rule so it cannot be reclassified after
  the fact.
- **The huge arm's granted kB is printed beside its permille on every run.** The third night's
  huge arm was granted 63,488 kB of a 64 MiB buffer, against 65,536 kB on earlier nights. A partial
  grant is reported as a partial grant, not as a full one.

## Procedure for the run, once the calendar allows it

1. Confirm the local date is `20261012` or later, with `TZ=America/New_York date +%Y%m%d`.
2. Run each binary once from `session-output/hugepage-chase/`, as the earlier nights did:
   `./sweep_huge` and `./sweep_control`. Record misses, accesses, permille, and `AnonHugePages`
   for each arm.
3. Compute `control permille / huge permille`. Compare it against the band above, and state
   whether the falsifier fired, in one plain sentence.
4. Write the result as a paper in `active-designing/date/` on the day of the run, with its own
   stamp. Do not edit this note to match the result.

## Projection

- **Horizon:** the ratio's direction across four calendar days, on this guest, with these
  binaries. Past four days is out of scope.
- **Assumptions:** the scratch binaries are unchanged since `20261009` (their source files carry
  `20261009` stamps and no edit since); the guest's kernel and page policy are unchanged; the huge
  arm's grant may vary between nights and is reported beside the ratio.
- **Falsifier:** as written above. A fourth-night pair outside 2 to 4 on one or both arms.
- **Confidence:** moderate on the direction, which holds on two days and the third day's pair. Low
  on the band edges, which one pair per night cannot fix. Low on the absolute permille, which has
  no explanation.

## What this does not say

It does not explain why the generic counter reads far below one miss per fill, and it does not test
the prefetch candidate, whose own falsifier needs a prefetch-disabled run the guest still blocks
(the `msr` door is shut on this guest, `20261009.233953`). No hardware is claimed beyond this guest.

## Why write it now

A band written after the numbers arrive can be drawn around them. Writing it on a day with no run
keeps the next run honest, whichever way it falls.
