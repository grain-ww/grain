# The sixteen-set break replicates on fresh seeds, and the ten-family ordering holds

**Status:** Design -- scratch-model reading; both pre-registered fresh-seed readings are in, and both sit on the side their falsifiers named.
**Room:** research for understanding -- the counts come from untracked scratch scripts (`session-output/diffuser-stencil-r3/`) and are reproducible by running them; no witness binds them yet.
**Lineage:** the ten-family row-major run [`20261010-142843`](20261010-142843_the-ten-family-ordering-holds-under-both-walks-and-the-sixteen-set-break-is-one-family.md) named this fresh-seed test as its next door, with its falsifier stated first.

## Question

The sixteen-set column-major break in the eleven-family run ([`20261010-122432`](20261010-122432_the-column-major-walk-breaks-the-ordering-at-sixteen-sets.md)) was read on one base of 24 seeds, `splitmix32(20261010)`. Does the same break reappear on 24 seeds drawn from a different base, and does the ten-family ordering hold there too?

## Falsifier, as written before the run

Stated in [`20261010-142843`](20261010-142843_the-ten-family-ordering-holds-under-both-walks-and-the-sixteen-set-break-is-one-family.md), before any fresh-seed run:

- On 24 fresh seeds from a base other than 20261010, the eleven-family column-major tau-b at 16 sets must fall at or below 0.5. If it exceeds 0.5, the 16-set break was a seed artefact and the family claim is withdrawn.
- The ten-family column-major tau-b at 16 sets must exceed 0.5. If it falls at or below 0.5, the ten-family ordering is seed-dependent.

## Method

- Two copies of the existing column-major scripts, changed in two lines only: the seed base (`20261011` in place of `20261010`) and the set counts (`[16]` in place of `[13, 14, 15, 16]`). Everything else is the same: the 256 by 256 radius-three diamond sweep, one way, column-major walk, the same family code, and the modulus and stride5 controls.
- Eleven families: the ten clustered families plus `xor_shift_line`. Ten families: the same list without `xor_shift_line`.
- Scripts: `run_r3_fresh_eleven_det_colmajor_16.py` and `run_r3_fresh_ten_det_colmajor_16.py`. Outputs: `run_256_fresh_eleven_det_colmajor_16_seed20261011.txt` and `run_256_fresh_ten_det_colmajor_16_seed20261011.txt`. Both are untracked scratch in the seat's own `session-output/`.
- Launched `20261010.143333`, run in parallel on 8 workers. Jobs: 312 for eleven families, 288 for ten. Null check (reuse distance above zero for every cluster family on every seed): 0 failures in both runs.

## Readings

| Walk | Families | Seeds | Sets | Kendall tau-b (mean reuse distance vs mean column-major miss) | Discordant of 55 or 45 pairs |
|---|---|---|---|---|---|
| column-major | eleven, with `xor_shift_line` | 24, base 20261011 | 16 | **+0.35** | 18 of 55 |
| column-major | ten, without `xor_shift_line` | 24, base 20261011 | 16 | **+0.60** | 9 of 45 |

For comparison, the same two families on the original base (20261010), from the earlier column-major runs: eleven families +0.49 at 16 sets, ten families +0.78 at 16 sets.

**A note on the script's wording.** The eleven-family script prints `falsifier=FIRES` at tau-b +0.35. That label marks the script's own test, tau-b at or below 0.5, which is the break the falsifier predicted. It is not a failure of the claim. The ten-family script prints `falsifier=HOLDS` at +0.60, meaning above 0.5, which is the ordering the falsifier predicted.

## Reading against the falsifier

- **The eleven-family break replicates.** On fresh seeds the 16-set reading falls to +0.35, under the 0.5 line. The family claim is not withdrawn. This is the outcome the falsifier said would keep it standing.
- **The ten-family ordering holds on fresh seeds.** On fresh seeds the 16-set reading is +0.60, above 0.5. The ten-family ordering is not seed-dependent in this test.

## What this does not settle

- **The family choice was made after the first break.** `xor_shift_line` was removed once the earlier column-major run showed it carried nine of its fourteen discordant pairs. The fresh-seed test is a fresh draw on the seeds. It does not re-test the choice of family, which was made on the original base. That caveat stands as the paper before it stated it.
- **The effect is smaller on fresh seeds.** The eleven-family reading moves from +0.49 to +0.35, and both sit on the same side of 0.5. Twenty-four seeds per base cannot say how wide the spread of tau-b is across seed bases. A third base would show that.
- **Scratch model only.** A 256 by 256 grid, a radius-three diamond sweep, and a direct-mapped cache of one way. No hardware, no timing, no real traffic, and no real caller's trace. The paper says nothing about Caravan, Aurora, Tally or Mantra. Those belong to BAKERY's lane.

## Projection, horizon and confidence

- **Observation:** on this scratch model, the 16-set column-major ordering breaks with `xor_shift_line` in the cluster and holds without it, on two seed bases.
- **Inference:** the break is a property of that one family under that one walk at that one set count, and it is not a seed artefact.
- **Projection:** none beyond the scratch model. Horizon: this stream and this model. Confidence: moderate for the scratch model, low for anything about real caches, since no real trace has been read.

## Next door

A third seed base at 16 sets, with its falsifier stated before the run, would test how wide the spread of tau-b is across bases. It is the cheapest next step and it changes no claim. Anything that would reach past the scratch model needs a real caller's live-set trace, which the tracked tree does not hold, so that door stays shut until someone supplies one.

## Falsifier for the next door, written before any run

On a third base of 24 seeds, the eleven-family column-major tau-b at 16 sets must fall at or below 0.5, and the ten-family must exceed 0.5. If either reading lands on the other side, the spread across seed bases is wider than the two readings here suggest, and the 16-set claim narrows to the bases tested so far.
