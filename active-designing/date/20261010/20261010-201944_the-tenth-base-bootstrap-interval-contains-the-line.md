# The tenth base's bootstrap interval contains the line, so the base cannot decide it

**Status:** Design -- Diffuser research, scratch-model reading, one seed base, column-major walk, resampling over seeds
**Room:** checkable -- the reading is a script and its output; the scratch files are untracked
**Lineage:** [`20261010-200511`](20261010-200511_the-ten-family-ordering-reads-just-above-the-line-on-the-tenth-base.md) read the tenth base at +0.51 and named a per-seed bootstrap as its next door. The falsifier is stamped at clock `20261010.201119` in the header of `session-output/diffuser-stencil-r3/run_r3_tenth_bootstrap.py`, before that script ran. The claim for the instrument opened at `20261010.201041` and landed on xy as `99b2953f50`.

## Plain statement

On the tenth seed base (seed `20261019`), resampling the 24 seeds with replacement puts the 95 percent interval of the ten-family tau-b at **+0.38 to +0.82**. The interval contains 0.5. So this one base cannot decide whether the ordering sits above or below the line. The earlier reading of +0.51 is a point inside a wide band, and the band straddles the line.

The rerun also reproduces the earlier point value exactly, so the new script measures the same thing the tenth-base paper measured.

## Measurement

| Quantity | Value | Unit | Source |
|---|---|---|---|
| Point tau-b, ten families, mean reuse distance vs mean column-major miss rate | **+0.51**, 34 concordant / 11 discordant | dimensionless, pairs | `session-output/diffuser-stencil-r3/run_256_tenth_bootstrap_seed20261019.txt`, line `point_tau_b` |
| Bootstrap 2.5th percentile of tau-b | **+0.38** | dimensionless | same file, `bootstrap_tau_b` |
| Bootstrap median of tau-b | **+0.56** | dimensionless | same file |
| Bootstrap 97.5th percentile of tau-b | **+0.82** | dimensionless | same file |
| Share of 2,000 resamples at or below 0.5 | **0.206** | fraction | same file |
| Resamples | 2,000, drawn with `random.Random(20261010)` over 24 seeds | count | the script's constants |
| Jobs | 240 = 10 families x 24 seeds, 16 sets by 1 way | count | same file, `jobs=240` |

The falsifier needed the interval only, so the 0.206 share is reported for the reader and gates nothing.

## Falsifier check

- **Written before the run:** if the 95 percent percentile interval of resampled tau-b contains 0.5, this base cannot decide the line, and the ten-family claim stays a majority tendency rather than a per-base threshold. An interval wholly above 0.5 would read above the line with support, and one wholly at or below would read below it.
- **Result:** the interval is +0.38 to +0.82, which contains 0.5. **The falsifier fired, in the sense written**: this base cannot decide the line.
- **What it does not undo:** the earlier majority count still stands. Eight of nine recorded ten-family bases read above 0.5 as point values. The bootstrap says the point values carry real spread, so the count of above-line points says less about a per-base threshold than it appeared to.

## Projection, with horizon, assumptions, falsifier, and confidence

- **Horizon:** the scratch model only, the same radius-three diamond stencil at 256 by 256, 16 sets by 1 way, column-major walk, seed base `20261019`.
- **Assumptions:** the 24 seeds are a fair sample of how a seed behaves under these families; resampling seeds with replacement approximates the spread a new seed base would show; the ten families are the cluster the earlier papers named.
- **Falsifier, for the next base:** a fresh seed base with its own 24 seeds, whose bootstrap interval lies wholly on one side of 0.5, would decide that base. A base whose interval again straddles the line would add to the tendency and decide nothing.
- **Confidence:** high that the ten-family point value sits near +0.5 to +0.6 on these bases (median of nine recorded points near +0.56). Low that the line is a fact about the scratch model at this resolution. A point at +0.51 with a band from +0.38 to +0.82 is not a threshold reading.

## What this paper does not claim

- It does not claim the ten-family ordering fails on the tenth base. The point estimate is above the line.
- It does not claim a per-base threshold exists. The bootstrap says this base cannot tell.
- It does not refold the eleven-family reading. That tendency stays as recorded in the earlier papers.
- It does not claim any hardware effect.

## Next door

the maintainer's word decides whether the question closes as a tendency on the bases already read, or whether one more fresh base is run with its own falsifier written before the run. The tenth-base paper already asked that ruling, and this measurement is the evidence it asked for. Until the word comes, no new base is run.
