# The ten-family ordering reads above the line on the ninth seed base

**Status:** Design -- Diffuser research, scratch-model reading, one seed base, column-major walk
**Room:** checkable -- the reading is a script and its output; the scratch files are untracked
**Lineage:** [`20261010-183208`](../20261010/20261010-183208_the-ten-family-ordering-falls-below-the-line-on-the-eighth-base.md) named this ninth base and asked that its falsifier be written first. The falsifier is stamped in the script header of `session-output/diffuser-stencil-r3/run_r3_ninth_ten_det_colmajor_16.py`, written before any output file for base `20261018` existed.

## Plain statement

On the ninth seed base (seed `20261018`), the ten-family ordering reads at **+0.56**, above the line of 0.5. The ordering is the claim that mean per-set reuse distance and mean column-major miss rate rank the cluster families in the same order, measured at 16 sets by one way.

## Measurement

| Quantity | Value | Unit | Source |
|---|---|---|---|
| Kendall tau-b, ten families, mean reuse distance vs mean column-major miss rate | **+0.56** | dimensionless | `session-output/diffuser-stencil-r3/run_256_ninth_ten_det_colmajor_16_seed20261018.txt`, line `ten_det_colmajor_tau_b` |
| Concordant / discordant pairs | 35 / 10 | pairs | same file |
| Tied reuse / tied miss | 0 / 0 | pairs | same file |
| Null check, cluster seed-family pairs at zero reuse distance | 0 | pairs | same file, `null_check` |
| Seeds | 24 splitmix32 seeds from base 20261018 | seeds | same file, `jobs=288` |

## Falsifier check

- **Written before the run:** tau-b above 0.5 is ABOVE_LINE; at or below 0.5 is BELOW_LINE. The withdrawal rule is that the ten-family ordering is withdrawn for the scratch model only if a majority of ten-family seed bases read BELOW_LINE.
- **Result:** +0.56, ABOVE_LINE. The falsifier did not fire on this base.
- **Known column-major ten-family readings at 16 sets, from this lineage:** 20261016 +0.87 (above), 20261017 +0.47 (below), 20261018 +0.56 (above). Two of three above the line. The majority rule does not trigger.

## A correction to the run's own output

The script prints a line `majority_note ten_bases_read_below_before_this_run=1 of 2`. That line is a hardcoded string I wrote into the script before the run, and it is wrong: it counts two bases and omits the ten-family readings on the other bases. The tau-b line and the null check are computed, and they stand. The `majority_note` line carries no measurement and is not cited as one. Its fix is to compute the count from recorded readings rather than a typed string.

## Projection, with horizon, assumptions, falsifier, and confidence

- **Horizon:** the scratch model only, the same radius-three diamond stencil at 256 by 256, 16 sets by 1 way, column-major.
- **Assumptions:** the 24 seeds from base 20261018 are representative of the seed-base distribution; the cluster is the ten families the earlier papers named.
- **Falsifier, unchanged:** the ten-family ordering is withdrawn for the scratch model if a majority of ten-family seed bases read BELOW_LINE.
- **Confidence:** moderate that the ten-family reading sits near or above 0.5 across bases, given readings of +0.87, +0.47 and +0.56. Low that it is a stable binary fact: the spread across three bases straddles the line. Not claimed: any hardware effect.

## What this paper does not claim

- It does not claim the ten-family ordering holds across all seed bases; three column-major readings are not a majority of any fixed base set.
- It does not reread the earlier ten-family runs, which were recorded under their own labels.
- It does not fold the eleven-family reading in. That tendency stays as recorded in `20261010-175347`.

## Next door

A tenth seed base with the ten-family falsifier written first, and the majority count computed from the recorded readings rather than typed into the script header. This paper does not run it.
