# The sixteen-set break holds on a third seed base, and the ten-family margin narrows

**Status:** Design -- scratch-model reading; the pre-registered third-base test ran and sits on the side both falsifiers named.
**Room:** research for understanding -- the counts come from untracked scratch scripts (`session-output/diffuser-stencil-r3/`) and are reproducible by running them; no witness binds them yet.
**Lineage:** the two-base fresh-seed run [`20261010-145347`](20261010-145347_the-sixteen-set-break-replicates-on-fresh-seeds-and-the-ten-family-ordering-holds.md) named a third seed base at 16 sets as its next door, with its falsifier stated first.

## What was measured, and when the falsifier was written

The falsifier below was written on the page of `20261010-145347` before this run. Nothing in it was changed after the run.

- **Seed base:** `20261012`, a third base after `20261010` and `20261011`. Twenty-four splitmix32 seeds per base.
- **Set count:** 16, one way, column-major walk, a 256 by 256 radius-three diamond sweep. Everything else is the same as the two earlier bases: the family code, and the modulus and stride5 controls.
- **Scripts:** `run_r3_third_eleven_det_colmajor_16.py` and `run_r3_third_ten_det_colmajor_16.py`. These are copies of the two-base scripts with one line changed, the seed (`splitmix32(20261012, 24)` in place of `splitmix32(20261011, 24)`). Outputs: `run_256_third_eleven_det_colmajor_16_seed20261012.txt` and `run_256_third_ten_det_colmajor_16_seed20261012.txt`. Both are untracked scratch in `session-output/`.

## Falsifier, as written before the run

On a third base of 24 seeds, the eleven-family column-major tau-b at 16 sets must fall at or below 0.5, and the ten-family must exceed 0.5. If either reading lands on the other side, the spread across seed bases is wider than the two readings here suggest, and the 16-set claim narrows to the bases tested so far.

## Results

Kendall tau-b between mean per-family reuse distance and mean column-major miss, over the same deterministic families, at 16 sets:

| Reading | Families | Pairs | Discordant | tau-b | Predicted side | Side reached |
|---|---|---|---|---|---|---|
| Eleven-family, third base `20261012` | 11, including `xor_shift_line` | 55 | 19 | +0.31 | at or below 0.5 | yes |
| Ten-family, third base `20261012` | 10, `xor_shift_line` removed | 45 | 10 | +0.56 | above 0.5 | yes |

Both scripts ran to `done` and printed no error lines.

## Reading against the falsifier

- **The eleven-family break replicates a third time.** The 16-set reading is +0.31, under the 0.5 line. The family claim is not withdrawn. This is the outcome the falsifier said would keep it standing.
- **The ten-family ordering holds, with less room than before.** The reading is +0.56, above 0.5, so it sits on the predicted side. The margin over the line is 0.06, which is the thinnest of the three bases.
- **Observation:** across three seed bases, the 16-set readings are:

| Seed base | Eleven-family tau-b | Ten-family tau-b |
|---|---|---|
| `20261010` (first base, the 142843 and 131959 runs) | +0.49 | +0.78 |
| `20261011` (second base, `20261011` run in 145347) | +0.35 | +0.60 |
| `20261012` (third base, this run) | +0.31 | +0.56 |

- **Inference:** both columns sit on the side their falsifiers predicted on all three bases. Both also drift downward from base to base, and the ten-family column drifts toward the 0.5 line. Three bases cannot say whether that drift is a trend or the spread of seeds. It is also one observed sequence, so it cannot separate the two.
- **Observation about the script's wording.** The ten-family output carries the label `eleven_det_colmajor_tau_b`. The label was copied from the eleven-family script and was not edited. The label is wrong for that run, and the number under it is the ten-family tau-b. The printed `falsifier=HOLDS` on that line refers to the ten-family test, which is the test the falsifier named. The eleven-family line prints `falsifier=FIRES`, which marks the script's own test (tau-b at or below 0.5), and that is the break the falsifier predicted, as the two-base paper also says.

## What this does and does not establish

- **Establishes:** on this scratch model, with three seed bases of 24 seeds each, the 16-set column-major ordering breaks with `xor_shift_line` in the cluster and holds without it, on every base tested.
- **Does not establish:** anything about a real caller. The scratch model is a family-by-walk reuse model, and the tracked tree does not hold a live-set trace. Anything reaching past the scratch model needs a real caller's trace, which the tree does not have yet.
- **Does not establish:** that the spread across bases is narrow. Three bases are not enough for a spread estimate, and the ten-family margin is narrowing across them.

## Next door

A fourth seed base at 16 sets, with its falsifier stated before the run, would show whether the ten-family drift continues.

## Falsifier for the next door, written before any run

On a fourth base of 24 seeds, the eleven-family column-major tau-b at 16 sets must fall at or below 0.5, and the ten-family must exceed 0.5. If the ten-family reading lands at or below 0.5, the 16-set ten-family ordering is not a stable property of this model across seed bases, and the claim narrows to the three bases already tested.

Lowering either the eleven-family or the ten-family threshold after seeing the fourth base would be a fault in this method, and this page names it in advance so that a reader can catch it.

## Reproduce

```
cd session-output/diffuser-stencil-r3
python3 -I run_r3_third_eleven_det_colmajor_16.py
python3 -I run_r3_third_ten_det_colmajor_16.py
```

Each prints a `summary` line per family and one tau-b line at the end.
