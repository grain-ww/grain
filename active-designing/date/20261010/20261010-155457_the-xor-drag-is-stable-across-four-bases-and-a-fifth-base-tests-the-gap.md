# The xor-family drag is stable across four bases, and a fifth base tests the gap

**Status:** Design -- scratch-model reading; the falsifier below is written before any fifth-base run, and that run has not happened.
**Room:** research for understanding -- no witness binds the scratch scripts, so nothing here is checkable yet.
**Lineage:** the fourth-base run [`20261010-155020`](20261010-155020_the-eleven-family-break-does-not-replicate-on-a-fourth-seed-base.md) named the question "is the 16-set break a property of the seed bases, or of the family set?" as its next door and left the falsifier unwritten. This page writes it.

## What the four bases already show

Every reading below is column-major, one way, 16 sets, 24 seeds, on the 256 by 256 scratch grid. The eleven-family reading includes `xor_shift_line`. The ten-family reading removes it. The gap is ten minus eleven, in tau-b units.

| Seed base | Eleven-family tau-b | Ten-family tau-b | Gap (ten minus eleven) |
|---|---|---|---|
| `20261010` (first base, 142843 and 131959 runs) | +0.49 | +0.78 | +0.29 |
| `20261011` (second base, 145347 run) | +0.35 | +0.60 | +0.25 |
| `20261012` (third base, 152036 run) | +0.31 | +0.56 | +0.25 |
| `20261013` (fourth base, 155020 run) | +0.53 | +0.82 | +0.29 |

Units: tau-b, dimensionless, from -1 to +1. Source: the four output files in `session-output/diffuser-stencil-r3/`, read by their `tau=` lines. Each reading is re-derivable by running the named script with its seed base, and the numbers are free to move if a script changes.

## Observation, inference, and projection

- **Observation:** the gap is positive on all four bases, and it sits between +0.25 and +0.29 (mean +0.27 across the four). The ten-family reading exceeds the eleven-family reading every time.
- **Observation:** the eleven-family reading sits below the 0.5 line on three bases and above it on one. The ten-family reading sits above 0.5 on all four, with margins of +0.28, +0.10, +0.06 and +0.32. Those margins do not fall monotonically, so the drift reading the third base floated and the fourth base withdrew stays withdrawn.
- **Inference:** `xor_shift_line` drags the 16-set reading down by about a quarter of a tau unit on this model, on every base tested so far. That is a stable effect. The side of 0.5 that the eleven-family reading lands on is not stable, because the reading sits close to the line and its position moves with the seeds.
- **Projection:** none beyond the scratch model. Horizon: this stream and this model only. Confidence: moderate that the drag is stable across these four bases; low that it says anything about a real cache, since no real trace has been read.

## What the four bases cannot settle

The ten-family set was chosen after the eleven-family break was seen. `xor_shift_line` was singled out by the 122432 run, where it appeared in nine of fourteen discordant pairs at 16 sets, and the ten-family run was then made with it removed. So the gap is measured on a subset picked from the data that produced the break. Four more bases do not undo that choice, and this page says so plainly rather than counting the four bases as an independent test of the choice.

A fifth base can test whether the gap is stable. It cannot re-test the choice of `xor_shift_line` as the family to remove, which would need a family set chosen before any run.

## Falsifier, written before the fifth-base run

The fifth base is `20261014`. Method: copies of the fourth-base scripts, changed in one line only, the seed base moved from `20261013` to `20261014`. Set count 16, column-major walk, 24 seeds, one way, the same family code, the modulus and stride5 controls. Outputs named `run_256_fifth_eleven_det_colmajor_16_seed20261014.txt` and `run_256_fifth_ten_det_colmajor_16_seed20261014.txt`, both untracked.

Two clauses, both fixed here before the run:

- **F1, the drag is stable.** The gap on base `20261014` must be at least +0.15. The four observed gaps sit between +0.25 and +0.29, so +0.15 leaves a margin below the lowest observed value and above zero. If the gap is below +0.15, the drag is not a stable property of `xor_shift_line` on this model, and the 16-set claim narrows to the four bases tested so far with the family set undiagnosed.
- **F2, the ten-family ordering holds.** The ten-family reading on base `20261014` must exceed 0.5. If it lands at or below 0.5, the ten-family ordering is not stable across seed bases, the same narrowing the third and fourth bases already named.

**What F1 does not decide.** F1 tests whether the drag is stable. It does not say whether the eleven-family side of 0.5 is seed-dependent, because the existing four bases already show that the eleven-family reading straddles the line. A fifth base that lands on either side of 0.5 adds one more observation to that straddle and settles nothing about its cause. Calling a side-flip on the eleven-family reading a falsifier of the seed-dependence claim would be reading the result to fit it, so this page does not do so.

**Lowering either threshold after seeing base 20261014 is a fault in this method**, the same rule the earlier papers wrote.

## Known labelling fault, carried forward

The ten-family script prints the copied label `eleven_det_colmajor_tau_b` on its own tau line. The number under that label is the ten-family tau-b, and both labels are read here from the numbers rather than from the printed words, as the fourth-base paper already did. The fifth-base run should read the same way.

## Scope

- **Scratch model only.** A 256 by 256 grid, a radius-three diamond sweep, and a direct-mapped cache of one way. No hardware, no timing, no real traffic, no real caller's trace.
- **Not for BAKERY's modules.** The page says nothing about Caravan, Aurora, Tally, or Mantra. Those belong to BAKERY's lane.
- **Not a witness.** No witness binds the scratch scripts yet. A run takes about twenty minutes per script on this machine, so the fifth base is two runs, which can go in parallel.

## Next door

Run the two fifth-base scripts, read their `tau=` lines, and set the result against F1 and F2 as written above. That run is the next lap's work. This lap writes the falsifier and stops there, so the run cannot be fitted to the falsifier after the fact.

## Reproduce

```
cd session-output/diffuser-stencil-r3
python3 -I run_r3_fifth_eleven_det_colmajor_16.py > run_256_fifth_eleven_det_colmajor_16_seed20261014.txt
python3 -I run_r3_fifth_ten_det_colmajor_16.py > run_256_fifth_ten_det_colmajor_16_seed20261014.txt
```

The two `run_r3_fifth_*.py` copies do not exist yet. The next lap creates them by changing the seed constant in the fourth-base copies, and it must not change anything else.
