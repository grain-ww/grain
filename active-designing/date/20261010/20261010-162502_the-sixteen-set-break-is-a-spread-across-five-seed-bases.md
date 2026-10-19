# The sixteen-set break is a spread across five seed bases, not a clean break

**Status:** Design -- scratch-model reading, five seed bases, one way, column-major walk
**Room:** vision -- nothing here enters the checkable room until a witness binds it (`context/TWO_ROOMS.md`)
**Clock:** `20261010.162502` (one clock, `America/New_York`)
**Lineage:** [`20261010-145347`](20261010-145347_the-sixteen-set-break-replicates-on-fresh-seeds-and-the-ten-family-ordering-holds.md) named a third seed base as its next door, with its falsifier stated before the run. That run is pre-registered. Two further bases were run afterwards, and this paper says which readings were stated first and which were not.

## Observation, in plain sentences

Each reading below is Kendall tau-b between the mean per-set reuse distance and the mean column-major miss rate, over the named family set, at 16 sets by one way, 24 splitmix32 seeds per base, in the scratch model (`session-output/diffuser-stencil-r3/`, untracked).

| Seed base | Eleven families, tau-b | Ten families, tau-b | Recorded before the run? |
|---|---|---|---|
| 20261010 | +0.49 | +0.78 | yes, the column-major papers (`20261010-122432`, `20261010-142843`) |
| 20261011 | +0.35 | +0.60 | yes, `20261010-145347` |
| 20261012 | +0.31 | +0.56 | yes, the pre-registered third base of `20261010-145347` |
| 20261013 | +0.53 | +0.82 | **no** -- run at 15:48, after the third-base paper, with no falsifier written |
| 20261014 | +0.27 | +0.51 | **no** -- run at 16:21, with no falsifier written |

Source for each row: `session-output/diffuser-stencil-r3/run_256_*_colmajor_16_seed2026101{0..4}.txt`, each line `*_tau_b sets=16 tau=...`. The seed base is `splitmix32(state)` in the script, checked by `grep` on each `run_r3_{fresh,third,fourth,fifth}_*.py`, and it matches the base in each file name.

Across the five bases, the eleven-family reading runs from +0.27 to +0.53 with a mean of +0.39. The ten-family reading runs from +0.51 to +0.82 with a mean of +0.65.

## Inference

1. **The eleven-family reading does not sit clearly on one side of 0.5.** It falls below the line on four bases and above it on one (20261013, +0.53). A claim of a "16-set break" depends on which side of 0.5 a base lands, so the claim as a binary is fragile on this model.
2. **The ten-family reading clears 0.5 on all five bases, but barely on one.** The 20261014 value of +0.51 sits one hundredth above the line. The ten-family ordering holds across the five, with its thinnest margin on the last base run.
3. **The gap between the two readings is the more stable finding.** The ten-family set runs above the eleven-family set on every base, by 0.09 to 0.29. That difference is what `xor_shift_line` contributes to the coefficient, and the earlier papers already name that family as the one carrying most of the discordant pairs.
4. **The 0.5 threshold is a choice.** It was set in the falsifier before any base was seen, and it is a reasonable line. It does not make the eleven-family value a fact about the model: the spread is a few tenths wide across bases, so a single base can land on either side.

## What the pre-registration does and does not support

The third-base test was stated before its run and passed its own condition: eleven-family tau at or below 0.5 (+0.31), and ten-family above 0.5 (+0.56). That supports the narrow claim that the earlier base-10 and base-11 readings were not a single lucky seed base.

The fourth and fifth bases carry no falsifier written before their runs. Their outcomes are reported above, but they are not a test in the pre-registered sense. The eleven-family reading on base 20261013 (+0.53) is the one that breaks the replication pattern, and it is recorded here as observed, not as a refutation under a stated test.

## Projection, with its horizon, assumptions, falsifier and confidence

- **Horizon:** the scratch model only. No hardware is claimed.
- **Assumptions:** 24 seeds per base; the cluster families and their coefficients are as the earlier papers wrote them; `xor_shift_line` stays in the eleven-family set and is removed only in the ten-family set, which was chosen after it was seen in the discordant pairs.
- **Falsifier, stated now and before any further base is run:** a sixth base, run with its falsifier written first, at 24 seeds, will narrow the claim further if the eleven-family reading lands above 0.5 on a majority of the six bases. Then the 16-set eleven-family break is not a stable claim and should be withdrawn in favour of the ten-family ordering alone. If the eleven-family reading stays at or below 0.5 on a majority, the break stands as a tendency, with the spread stated beside it.
- **Confidence:** moderate on the ten-family ordering across five bases; low on the eleven-family 16-set break as a binary claim; high that the spread across bases exceeds the 24-seed noise a single base would suggest.

## Next door

Write the sixth base's falsifier before its run, as stated above. Run it under the same scripts, changing only the seed base and the file name, and record the falsifier clock in the paper before the output file is opened. Anything reaching past the scratch model still needs a live-set trace from a real caller, which the tracked tree does not hold (`20261009.202114`).

## What this paper does not claim

It does not claim the sixteen-set ordering is a property of any real cache. It does not change the earlier papers' numbers, which stay as they were written. It adds two bases after the fact, labelled as such, and it withdraws no earlier claim on its own authority.
