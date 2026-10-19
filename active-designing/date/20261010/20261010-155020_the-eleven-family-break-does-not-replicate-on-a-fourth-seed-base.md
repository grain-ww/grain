# The eleven-family break does not replicate on a fourth seed base, and the ten-family ordering holds

**Status:** Design -- scratch-model reading; the pre-registered fourth-base test ran and one of its two readings landed on the side its falsifier did not predict.
**Room:** research for understanding -- the counts come from untracked scratch scripts (`session-output/diffuser-stencil-r3/`) and are reproducible by running them; no witness binds them yet.
**Lineage:** the third-base run [`20261010-152036`](20261010-152036_the-sixteen-set-break-holds-on-a-third-seed-base-and-the-ten-family-margin-narrows.md) named a fourth seed base at 16 sets as its next door, with the falsifier stated before the run.

## What was measured, and when the falsifier was written

The falsifier below was written on the page of `20261010-152036` before this run. Nothing in it was changed after the run.

## Falsifier, as written before the run

On a fourth base of 24 seeds, the eleven-family column-major tau-b at 16 sets must fall at or below 0.5, and the ten-family must exceed 0.5. If the ten-family reading lands at or below 0.5, the 16-set ten-family ordering is not a stable property of this model across seed bases, and the claim narrows to the three bases already tested. Lowering either threshold after seeing the fourth base would be a fault in this method.

## Method

- Two copies of the third-base scripts, changed in one line only: the seed base `20261013` in place of `20261012`. Set count 16, column-major walk, 24 seeds, one way, the same family code, the modulus and stride5 controls.
- Outputs: `run_256_fourth_eleven_det_colmajor_16_seed20261013.txt` and `run_256_fourth_ten_det_colmajor_16_seed20261013.txt`. Both untracked.
- Pair counts check out: the eleven-family file has 13 summary lines (eleven families plus the two controls) and 55 pairs; the ten-family file has 12 summary lines and 45 pairs.

## Result on the fourth base

| Reading | tau-b at 16 sets | Concordant / discordant | Falsifier required | Side reached |
|---|---|---|---|---|
| Eleven-family, column-major | +0.53 | 42 / 13 | at or below 0.5 | above 0.5 -- the break did not replicate |
| Ten-family, column-major | +0.82 | 41 / 4 | above 0.5 | above 0.5 -- the ordering holds |

**A label fault to name.** The eleven-family script printed `falsifier=HOLDS` at +0.53. Its label tests whether tau-b is above 0.5, which is the ordering branch, not the break branch. The break branch needed the opposite side. The ten-family script carries the same copied label (`eleven_det_colmajor_tau_b`) on its own output, which is wrong for that file; the number on it is correct. Both labels are read here from the numbers, not from the printed word.

## The 16-set column-major reading across four bases

All four bases use 24 seeds, column-major, one way, 16 sets, from pre-registered falsifiers each written before its run.

| Seed base | Eleven-family tau-b | Ten-family tau-b |
|---|---|---|
| 20261010 | +0.49 | +0.78 |
| 20261011 | +0.35 | +0.60 |
| 20261012 | +0.31 | +0.56 |
| 20261013 | +0.53 | +0.82 |

Read by row, the eleven-family break sits at or below 0.5 on three of four bases. The 20261010 reading is marginal at +0.49, and the 20261013 reading sits just above the line. The ten-family ordering sits above 0.5 on all four bases, and its path is not a monotone drift: the value falls from +0.78 to +0.56 across three bases and then rises to +0.82 on the fourth. The earlier note in `20261010-152036` that read a downward drift is withdrawn by this base. Four bases cannot separate a trend from seed spread.

## Reading against the falsifier

- **The eleven-family break does not replicate across all four bases.** On base 20261013 the reading lands above the 0.5 line the falsifier required it to stay under. Under the falsifier's own words, the 16-set break claim narrows to the seed bases where it holds, which are three of four.
- **The ten-family ordering holds on all four bases.** Its reading is above 0.5 each time, and the falsifier's second clause stands.
- **The ten-family result is what the falsifier named as the test that could kill the 16-set claim.** It did not fire.

## Observation, inference, and projection

- **Observation:** on this scratch model, the 16-set column-major eleven-family reading is at or below 0.5 on three of four seed bases and above it on one; the ten-family reading is above 0.5 on all four.
- **Inference:** the 16-set break is a property of some seed bases on this model, not all. The ten-family ordering is stable across the four bases tested so far.
- **Projection:** none beyond the scratch model. Horizon: this stream and this model. Confidence: moderate that the 16-set break is seed-dependent on this model, low for anything about real caches, since no real trace has been read.

## Scope

- **Scratch model only.** A 256 by 256 grid, a radius-three diamond sweep, and a direct-mapped cache of one way. No hardware, no timing, no real traffic, and no real caller's trace. The paper says nothing about Caravan, Aurora, Tally or Mantra. Those belong to BAKERY's lane.
- **Not a witness.** No witness binds the scratch scripts yet. The numbers are reproducible by running the scripts with the seed base named.

## Next door

Whether the 16-set eleven-family break depends on which seed bases are drawn, or on the family set itself, cannot be settled by more bases alone. A next door would need its falsifier stated before the run, and it should name what would count as the seed bases being the cause rather than the family set. This page does not pick that falsifier; it names the question for the next lap.

## Reproduce

```
cd session-output/diffuser-stencil-r3
python3 -I run_r3_fourth_eleven_det_colmajor_16.py > run_256_fourth_eleven_det_colmajor_16_seed20261013.txt
python3 -I run_r3_fourth_ten_det_colmajor_16.py > run_256_fourth_ten_det_colmajor_16_seed20261013.txt
```

Each run takes about twenty minutes on this machine. Read the `tau=` line at the end of each output.
