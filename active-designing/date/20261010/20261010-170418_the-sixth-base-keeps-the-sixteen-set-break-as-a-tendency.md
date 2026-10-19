# The sixth seed base keeps the sixteen-set break as a tendency, not a stable claim

**Status:** Design -- scratch-model reading, six seed bases, one way, column-major walk
**Room:** vision -- nothing here enters the checkable room until a witness binds it (`context/TWO_ROOMS.md`)
**Lineage:** [`20261010-162502`](20261010-162502_the-sixteen-set-break-is-a-spread-across-five-seed-bases.md) stated the sixth-base falsifier before any run. This paper runs that base and reports it against that falsifier.

## What the falsifier said, and when

The falsifier is in `20261010-162502`, section *Projection*, and was written at clock `20261010.162502`:

- Run a sixth base at 24 seeds, with the falsifier written first.
- If the eleven-family reading lands above 0.5 on a **majority** of the six bases, the 16-set eleven-family break is withdrawn in favour of the ten-family ordering alone.
- If it stays at or below 0.5 on a majority, the break stands as a tendency, with its spread stated beside it.

The sixth-base script was written at clock `20261010.162910`, after the falsifier and before any output file for the sixth base was opened. Its seed base is `splitmix32(20261015)`, chosen as the next date-stamped base; the falsifier named no seed, so that choice is stated here and was not tuned against a result.

## The run (observation)

Both scripts are the fifth base's scripts with the seed base and the file name changed, under `session-output/diffuser-stencil-r3/` (untracked scratch). Each runs 24 seeds at 16 sets by one way, column-major walk, with the modulus and stride5 controls reported beside the cluster.

| Seed base | Eleven families, tau-b | Ten families, tau-b | Falsifier read before the run? |
|---|---|---|---|
| 20261010 | +0.49 | +0.78 | yes |
| 20261011 | +0.35 | +0.60 | yes |
| 20261012 | +0.31 | +0.56 | yes |
| 20261013 | +0.53 | +0.82 | no -- post-hoc |
| 20261014 | +0.27 | +0.51 | no -- post-hoc |
| **20261015** | **+0.27** | **+0.51** | **yes, `20261010-162502`** |

Source for the sixth row: `session-output/diffuser-stencil-r3/run_256_sixth_eleven_det_colmajor_16_seed20261015.txt` and `..._sixth_ten_det_colmajor_16_seed20261015.txt`, each line `*_tau_b sets=16 tau=...`. The null check (reuse distance above zero for every cluster family and seed) read `cluster_seed_family_pairs_at_zero=0` on both.

Two observations, kept separate from the reading above:

- The sixth-base eleven-family value (+0.27) and the fifth-base value (+0.27) agree to two places. The per-family means differ between the two bases (for example the `mix` mean reuse distance reads 1.3478 on the sixth base and 1.3472 on the fifth), and the seeds differ, so the agreement is a coincidence in tau rather than a repeated run.
- The ten-family script prints its result line with the label `eleven_det_colmajor_tau_b`. That label is copied from the eleven-family script and names the wrong family count. The cluster list in the script holds ten families, and the falsifier threshold it applies is the ten-family one. Read the number as the ten-family reading; the label is a defect in the scratch script, not in the result.

## The reading (inference, with its count)

The eleven-family falsifier threshold is 0.5. Across six bases the eleven-family reading is above 0.5 on **one** base (20261013, +0.53, post-hoc) and at or below 0.5 on **five**, including the pre-registered sixth. The condition for withdrawal (above 0.5 on a majority) is not met.

The ten-family reading is above 0.5 on all six bases, which is the ordering the earlier papers already carried.

So the falsifier's second branch holds: the 16-set eleven-family break stands as a **tendency**, with its spread stated beside it. The spread is wide relative to the line. Across the six bases the eleven-family reading runs from +0.27 to +0.53, and two bases sit within 0.03 of the 0.5 line, one on each side (+0.49 below, +0.53 above). A single base can land either side of the line, as `20261012` and `20261013` already showed.

## What this does not establish

- **The 0.5 line is still a choice.** It was set before any base was seen. It does not make the eleven-family value a fact about the model. The two readings closest to the line are +0.49 and +0.53, and a different threshold would have given a different verdict.
- **Two of the six bases are post-hoc.** `20261013` and `20261014` were run without a falsifier written first, so they count as observations, not as tests. The pre-registered readings are `20261010`, `20261011`, `20261012` and `20261015`: +0.49, +0.35, +0.31 and +0.27 on the eleven families. Those four all sit at or below 0.5. The pre-registered count is therefore four of four, a cleaner statement than the six-base majority, and it is the one this paper leans on.
- **The sixth base is a scratch-model reading.** No hardware is claimed, and the scratch model is untracked, so nothing here can be re-run from the tracked tree. Anything reaching past the scratch model still needs a live-set trace from a real caller, which the tracked tree does not hold (`20261009.202114`).

## Projection, with its horizon, assumptions, falsifier and confidence

- **Horizon:** the scratch model, one way, 16 sets, 24 splitmix32 seeds per base. Nothing beyond that layout.
- **Assumption:** the seed bases are drawn the same way from `splitmix32`, so a new base is a fair draw from the same family of seeds.
- **Falsifier, stated now and before any further base is run:** a seventh base at 24 seeds, with its falsifier written first, will move the pre-registered count below four of four if the eleven-family reading lands above 0.5 on that base. Two such misses across the pre-registered bases would withdraw the claim as a stable one. (The count is over pre-registered bases only; post-hoc bases are reported, not counted.)
- **Confidence:** moderate that the ordering is real on this model (the ten-family reading is above 0.5 on all six bases). Low that the eleven-family break at 16 sets is a stable effect, since its spread crosses the line.

## Next door

the maintainer's word is the gate for a raw vendor event; nothing in this paper needs one. The next scratch-model step is a seventh base, with its falsifier written at a clock before its run and before its output file is opened. The paper also suggests fixing the ten-family script's label before any further run uses it as a template.
