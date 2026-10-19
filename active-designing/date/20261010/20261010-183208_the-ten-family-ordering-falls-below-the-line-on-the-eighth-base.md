# The ten-family ordering falls below the line on the eighth seed base

**Status:** Living -- Diffuser research, fruit Meter
**Room:** checkable -- the fruit names one scratch script and one output file
**Lineage:** [`20261010-175347`](20261010-175347_the-eighth-base-reads-below-the-line-and-the-break-stays-a-tendency.md) named this run as its next door. The falsifier was stamped at clock `20261010.175658` in `session-output/diffuser-stencil-r3/run_r3_eighth_ten_det_colmajor_16.py`, before any output file for this base was opened.

## Plain statement

On the eighth seed base (seed `20261017`), the ten-family ordering reads at **+0.47**, under the line of 0.5. The ordering is the claim that the mean per-set reuse distance and the mean column-major miss rate rank the cluster families in the same order. The seventh paper reported this same reading above the line at +0.87 on its base, and the card's earlier runs reported it above the line on five bases. This paper records the eighth base as a falsifier hit for the ten-family ordering, and it does not fold that hit into the eleven-family tendency.

## Measurement

| Quantity | Value | Unit | Source |
|---|---|---|---|
| Kendall tau-b, ten families, mean reuse distance vs mean column-major miss rate, 16 sets by 1 way | **+0.47** | dimensionless | `session-output/diffuser-stencil-r3/run_256_eighth_ten_det_colmajor_16_seed20261017.txt`, line `ten_det_colmajor_tau_b` |
| Concordant / discordant pairs | 33 / 12 | pairs | same file |
| Seeds | 24 splitmix32 seeds from base 20261017 | seeds | same file, `jobs=288` |
| Ten-family reading, seventh base (seed 20261016) | +0.87 | dimensionless | `run_256_seventh_ten_det_colmajor_16_seed20261016.txt` |
| Eleven-family reading, eighth base (seed 20261017) | +0.24 | dimensionless | `run_256_eighth_eleven_det_colmajor_16_seed20261017.txt` |

The measured quantities are the same as the eleven-family runs. The only change is the removal of `xor_shift_line` from the cluster, and the corrected label, which now reads `line=BELOW_LINE` or `line=ABOVE_LINE` and no longer reads `falsifier=`.

## Falsifier check

- **Written before the run:** tau-b above 0.5 is recorded ABOVE_LINE, and tau-b at or below 0.5 is recorded BELOW_LINE. A BELOW_LINE reading on the ten-family ordering is a falsifier hit for that ordering.
- **Result:** +0.47, so BELOW_LINE. The falsifier fired for the ten-family ordering on this base.
- **What it does not do:** one below-line base does not withdraw the eleven-family tendency. The paper's withdrawal rule is five or more of eight bases above 0.5 for the eleven-family reading. The eleven-family reading on this base is +0.24, which is below the line, so it adds to the count on the non-withdrawal side.

## Projection, with horizon, assumptions, falsifier, and confidence

- **Horizon:** the scratch model only, with the same radius-three diamond stencil at 256 by 256 and 16 sets by 1 way.
- **Assumptions:** the 24 seeds from base 20261017 are representative of the seed-base distribution, and the column-major walk is the walk the paper names.
- **Falsifier, for the ten-family ordering as a claim:** the ordering is withdrawn for the scratch model if a majority of the ten-family seed bases read below 0.5. One base has read below. This paper does not claim the majority.
- **Confidence:** high that the ten-family reading on base 8 is +0.47 and reads BELOW_LINE on the written rule. Low that the ten-family ordering holds as a binary fact across seed bases, since the reading now spans the line. Moderate that the ten-family reading is a tendency near 0.5 rather than a stable effect size.

## What this paper does not claim

- It does not claim that the ten-family ordering is false on hardware, since nothing in the scratch model reaches hardware.
- It does not claim the eleven-family break at 16 sets, which stays a tendency with two of eight bases above the line.
- It does not reread the earlier ten-family runs. Their labels were written before this correction, and they stand as recorded.

## Next door

The ten-family claim now has a below-line base, so any further ten-family reading must state its falsifier before the run, as this one did. The next door is a ninth seed base with the ten-family falsifier written first, and a majority count across the bases read so far, printed beside each reading. This paper does not run it.
