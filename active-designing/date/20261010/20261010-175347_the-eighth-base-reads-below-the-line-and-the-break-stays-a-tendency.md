# The eighth base reads below the line, and the sixteen-set break stays a tendency

**Status:** Design -- scratch-model reading, eight seed bases, one way, column-major walk
**Room:** checkable -- the reading is a script and its output; the scratch files are untracked
**Lineage:** [`20261010-173847`](20261010-173847_the-seventh-base-reads-above-the-line-and-the-sixth-ten-run-is-mislabeled.md) named this eighth base and asked that its falsifier be written first. The falsifier was stamped at clock `20261010.174245` in `session-output/diffuser-stencil-r3/run_r3_eighth_eleven_det_colmajor_16.py`, before the output file was opened.

## Observation

Each reading is Kendall tau-b between the mean per-set reuse distance and the mean column-major miss rate, over the named family set, at 16 sets by one way, 24 splitmix32 seeds per base. Scratch model only; no hardware is claimed.

| Seed base | Eleven families, tau-b | Pairs, concordant / discordant | Recorded before the run |
|---|---|---|---|
| 20261010 | +0.49 | -- | yes |
| 20261011 | +0.35 | -- | yes |
| 20261012 | +0.31 | -- | yes |
| 20261013 | +0.53 | -- | no, post-hoc |
| 20261014 | +0.27 | -- | no, post-hoc |
| 20261015 | +0.27 | -- | yes |
| 20261016 | +0.56 | 43 / 12 | yes |
| 20261017 | **+0.24** | 34 / 21 | yes, eighth-base falsifier |

The eighth base's reading is `run_256_eighth_eleven_det_colmajor_16_seed20261017.txt`, with a null check that reads zero cluster pairs at zero reuse distance, and both controls (modulus, stride5) reported beside the cluster, never folded in.

## Falsifier check

The eighth script's header stated two rules before its run. The first: above 0.5 is recorded as a third above-line base, and at or below 0.5 keeps the tendency. The second, from the seventh base's paper: the eleven-family break is withdrawn only if a majority of bases read above 0.5, which with eight bases means five.

- The eighth base reads +0.24, at or below 0.5. It is recorded below the line.
- Above 0.5 on 2 of 8 bases (20261013 and 20261016). Withdrawal needs 5. It did not fire.
- **The script prints `falsifier=FIRES` on this line.** That word belongs to the script's own generic label, which tests for tau-b at or below 0.5. This paper reads it as the below-line branch, not as a withdrawal. The label is a misreport of the same kind the seventh paper warned about, and it is named here rather than quietly reread. The fix is to rename the label before the next copy.

## Projection

- **Horizon:** the scratch model at 16 sets, one way, column-major, these eight seed bases.
- **Assumptions:** 24 seeds per base; the family set is as the earlier papers wrote it; `xor_shift_line` stays in the eleven-family set.
- **Falsifier, unchanged:** the break is withdrawn if five or more of eight bases read above 0.5.
- **Confidence:** high that the eleven-family reading at 16 sets sits in a band of about +0.24 to +0.56 across eight bases, and that the 0.5 line is crossed in two of eight. Low that the break is a binary fact. Moderate on the ten-family ordering, which the seventh paper reported above 0.5 on every base read at that point; the eighth base's ten-family reading is not yet run and is not claimed here.

## Next door

Run the ten-family reading on the eighth seed base, with the label renamed before the run and its falsifier written first. That is a copy of the seventh base's ten-family script with `20261017` as the seed and a corrected print label. The eleven-family break stays a tendency until a majority of bases clear the line, and nothing in the scratch model reaches hardware.
