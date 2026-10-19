# The ten-family ordering reads just above the line on the tenth seed base

**Status:** Design -- Diffuser research, scratch-model reading, one seed base, column-major walk
**Room:** checkable -- the reading is a script and its output; the scratch files are untracked
**Lineage:** [`20261010-193807`](20261010-193807_the-ten-family-ordering-reads-above-the-line-on-the-ninth-base.md) named this tenth base and asked that its falsifier be written first. The falsifier is stamped at clock `20261010.194029` in the script header of `session-output/diffuser-stencil-r3/run_r3_tenth_ten_det_colmajor_16.py`, before any output file for base `20261019` was opened.

## Plain statement

On the tenth seed base (seed `20261019`), the ten-family ordering reads at **+0.51**. That is above the line of 0.5, but only by 0.01. The ordering is the claim that mean per-set reuse distance and mean column-major miss rate rank the cluster families in the same order, measured at 16 sets by one way.

The reading clears the line. It does not clear it by enough to call the line a stable fact.

## Measurement

| Quantity | Value | Unit | Source |
|---|---|---|---|
| Kendall tau-b, ten families, mean reuse distance vs mean column-major miss rate | **+0.51** | dimensionless | `session-output/diffuser-stencil-r3/run_256_tenth_ten_det_colmajor_16_seed20261019.txt`, line `ten_det_colmajor_tau_b` |
| Concordant / discordant pairs | 34 / 11 | pairs | same file |
| Tied reuse / tied miss | 0 / 0 | pairs | same file |
| Null check, cluster seed-family pairs at zero reuse distance | 0 | pairs | same file, `null_check` |
| Seeds | 24 splitmix32 seeds from base 20261019 | seeds | same file, `jobs=288` |
| Wall time, one run on 8 workers | about 9 min 48 s | minutes | the first run, same script |

The first run of this script printed the parser's own count wrong. It read only the three files whose labels said `ten_det`, and it missed the five earlier files whose labels said `eleven_det` while carrying ten-family values. That first run's output file was overwritten by a rerun with the parser fixed, so the reported counts below come from the rerun. Its tau-b line matched the rerun exactly.

## Falsifier check

- **Written before the run:** tau-b above 0.5 is above_line; at or below 0.5 is below_line. The ten-family ordering is withdrawn for the scratch model only if a majority of ten-family seed bases read below_line.
- **Result:** +0.51, above_line. The falsifier did not fire on this base.
- **Majority count, computed by the script from the recorded files:** eight seed bases were recorded before this run, `20261011` through `20261018`. One of them read at or below 0.5 (`20261017`, +0.47). The withdrawal threshold is five of eight. The majority rule did not trigger.

| Seed base | Ten-family tau-b, 16 sets, column-major | Side of 0.5 | File label as printed |
|---|---|---|---|
| 20261011 | +0.60 | above | `eleven_det` |
| 20261012 | +0.56 | above | `eleven_det` |
| 20261013 | +0.82 | above | `eleven_det` |
| 20261014 | +0.51 | above | `eleven_det` |
| 20261015 | +0.51 | above | `eleven_det` |
| 20261016 | +0.87 | above | `ten_det` |
| 20261017 | +0.47 | below | `ten_det` |
| 20261018 | +0.56 | above | `ten_det` |
| 20261019 | +0.51 | above | `ten_det` |

**The label column is the correction.** Five of these files print `eleven_det_colmajor_tau_b` on their line, while the eleven-family readings the earlier papers recorded for the same seeds (for example +0.35 on `20261011`) live in different files. Where an earlier paper states the ten-family number for one of these seeds, the file agrees with it: `20261011` at +0.60 is the figure `20261010-145347` gives. The other four are read from their files and not checked against a paper, so this paragraph claims only the one seed it can cite. The fault is the same kind the seventh-base paper named: a printed label that does not match the computation beside it. It is a finding about labels, and it changes no reading.

## Projection, with horizon, assumptions, falsifier, and confidence

- **Horizon:** the scratch model only, the same radius-three diamond stencil at 256 by 256, 16 sets by 1 way, column-major walk.
- **Assumptions:** the 24 seeds from base 20261019 are representative of the seed-base distribution; the cluster is the ten families the earlier papers named; the nine ten-family bases are not an independent random sample of seed bases.
- **Falsifier, unchanged:** the ten-family ordering is withdrawn for the scratch model if a majority of ten-family seed bases read below_line. The count is now one of nine.
- **Confidence:** high that the ten-family ordering sits at or above the line across most recorded bases (eight of nine above). Low that the line is a binary fact. Nine readings range from +0.47 to +0.87, and the median sits near +0.56. The tenth reading's margin of 0.01 is inside what 24 seeds can separate, and no bootstrap over the seeds has been run to say so.

## What this paper does not claim

- It does not claim the ten-family ordering holds on every seed base. One base in nine reads below the line.
- It does not claim a size for the ordering. tau-b is a rank coefficient, and the spread the cluster orders is a few parts in a hundred.
- It does not refold the eleven-family reading into this result. That tendency stays as recorded in `20261010-175347`.
- It does not claim any hardware effect.

## Next door

The reading at +0.51 sits too close to the line to read alone. The next door is a per-seed bootstrap over the 24 seeds of base `20261019`, with its falsifier written before the run. Its falsifier: if the 95 percent interval of tau-b across resampled seeds contains 0.5, this base cannot decide the line, and the ten-family claim stays a majority tendency rather than a per-base threshold. If the interval lies wholly above 0.5, the base is an above-line reading that the seed noise does not reach. This paper does not run it.

A ruling is also owed on the eleven-family break and the ten-family ordering. the maintainer's word decides whether a sixth-base-style fresh base is worth the next ten minutes of compute, or whether the question closes on the nine bases read.
