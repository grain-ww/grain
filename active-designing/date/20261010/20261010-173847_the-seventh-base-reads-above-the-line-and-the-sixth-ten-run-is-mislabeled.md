# The seventh base reads above the line, and the sixth ten-family run is mislabeled

**Status:** Design -- scratch-model reading, seven seed bases, one way, column-major walk
**Room:** vision -- nothing here enters the checkable room until a witness binds it (`context/TWO_ROOMS.md`)
**Clock:** `20261010.173847` (one clock, `America/New_York`)
**Lineage:** [`20261010-170418`](20261010-170418_the-sixth-base-keeps-the-sixteen-set-break-as-a-tendency.md) reported the sixth base. The seventh base's script was written at clock `20261010.170912`, before its output file was opened, and its outputs were on disk without a paper. This paper reports them against the falsifier that script states, and corrects one label in the sixth base's output.

## Observation, in plain sentences

Each reading is Kendall tau-b between the mean per-set reuse distance and the mean column-major miss rate, over the named family set, at 16 sets by one way, 24 splitmix32 seeds per base, in the scratch model (`session-output/diffuser-stencil-r3/`, untracked).

| Seed base | Eleven families, tau-b | Ten families, tau-b | Pairs (eleven / ten) | Recorded before the run? |
|---|---|---|---|---|
| 20261010 | +0.49 | +0.78 | 55 / 45 | yes, the column-major papers |
| 20261011 | +0.35 | +0.60 | 55 / 45 | yes, `20261010-145347` |
| 20261012 | +0.31 | +0.56 | 55 / 45 | yes, the third-base pre-registration |
| 20261013 | +0.53 | +0.82 | 55 / 45 | no, post-hoc (`20261010-162502`) |
| 20261014 | +0.27 | +0.51 | 55 / 45 | no, post-hoc (`20261010-162502`) |
| 20261015 (sixth) | +0.27 | +0.51 | 55 / 45 | yes, `20261010-162910` script header |
| 20261016 (seventh) | +0.56 | +0.87 | 55 / 45 | yes, `20261010-170912` script header |

The seventh base's eleven-family reading is +0.56 with 43 concordant and 12 discordant pairs (`run_256_seventh_eleven_det_colmajor_16_seed20261016.txt`). Its ten-family reading is +0.87 with 42 concordant and 3 discordant (`run_256_seventh_ten_det_colmajor_16_seed20261016.txt`).

**Correction to the sixth base.** The file `run_256_sixth_ten_det_colmajor_16_seed20261015.txt` prints its line with the label `eleven_det_colmajor_tau_b`. Its script, `run_r3_sixth_ten_det_colmajor_16.py`, has the ten-family cluster list (`xor_shift_line` removed), and its per-family summaries cover those ten families plus the two controls. So the +0.51 in that file is the ten-family reading, and the label is a copy error from the eleven-family template. The sixth base's eleven-family reading is the separate file `run_256_sixth_eleven_det_colmajor_16_seed20261015.txt`, +0.27. The label is not fixed in the output file, since the output is testimony; this paragraph is the erratum.

## Falsifier check, against the seventh base's own header

The seventh script's header states the reading rule before the run: a base above 0.5 is recorded as a second above-line base, and the withdrawal rule needs a majority of bases above 0.5. With seven bases that means four.

- Eleven families at 16 sets, all seven bases: above 0.5 on **2 of 7** (20261013 at +0.53, 20261016 at +0.56). Withdrawal needs 4. It did not fire.
- Ten families at 16 sets, all seven bases: above 0.5 on 7 of 7. The ten-family ordering holds on every base read so far.

The sixth base's own falsifier, from `20261010-162502`, fired on its eleven-family reading. That falsifier asked for the eleven-family reading to land above 0.5 on a majority of six bases. The sixth base read +0.27, so the majority did not form at that base, and the 16-set eleven-family break stays a tendency.

## Projection, with its horizon, assumptions, falsifier and confidence

- **Horizon:** the scratch model only. No hardware is claimed, and no live caller trace is in the tree (`20261009.202114`).
- **Assumptions:** 24 seeds per base; the family sets are as the earlier papers wrote them; `xor_shift_line` stays in the eleven-family set and is removed in the ten-family set. That removal was chosen after the family appeared in the discordant pairs, so the ten-family reading carries that choice.
- **Falsifier, for the eleven-family break at 16 sets:** the break is withdrawn if a majority of bases read above 0.5. With seven bases that is four; the count stands at two. An eighth base would need to read above 0.5 and be joined by two more such bases before a majority of eight (five) forms, so no single new base can withdraw the claim.
- **Confidence:** high that the eleven-family 16-set reading sits inside a band of about +0.27 to +0.56 across seven bases. Low that the eleven-family break is a binary fact, since it crosses 0.5 in two of seven bases. Moderate on the ten-family ordering, which stayed above 0.5 on every base.

## What this does not claim

The spread across seed bases is wider than the 24-seed noise a single base suggests, and that is the finding. It does not establish a cause for the spread. The seed bases 20261013 and 20261014 were run without a falsifier written first, so their readings are reported as observed.

## Next door

Write the eighth base's falsifier before its run, as the earlier bases did, and name its clock in the paper before the output opens. Before any new script copies the ten-family template, fix its `print` label, since the sixth base shows how a copied label can misreport a family set.
