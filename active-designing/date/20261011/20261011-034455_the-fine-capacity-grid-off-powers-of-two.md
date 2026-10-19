# The fine capacity grid, off powers of two -- does the coarse grid carry the set-associative reading

**Status:** Design -- a measurement on a scratch model, with its falsifiers written after the run (clock `20261011.034455`); not pre-registered
**Room:** research for understanding (scratch model; nothing here is checkable hardware)
**Kin:** [bit-sliced set index](20261011-033859_the-bit-sliced-set-index-falsifier-first.md) - [set-associative line size](20261011-033405_the-set-associative-line-size-falsifier-first.md) - [line-size two ends](20261011-032806_the-line-size-two-ends-and-the-padding-band.md)

## Plain sentence first

The bit-sliced paper ended on a request: run the same polar-against-Cartesian comparison on a
capacity grid that is not powers of two, so the reading is a measurement rather than a quantization.
Its coarse grid read exactly `4.00` at all thirty points, so it could not resolve the index at all.
This paper runs that request. It changes only the grid, and it indexes sets by `line mod sets`, which
is the one index valid for any integer set count.

## An error in the first attempt, stated before anything else

The first run of the fine grid reused the bit-sliced `misses()` from the scratch module, whose index
is `line & (sets - 1)`. That mask is correct only for a power of two. Stepping sets through
`1.03 x` produced non-monotone curves (60 to 74 upward steps per run) and a Cartesian floor that read
exactly `16.0` at N = 256, so the output was a mask applied to the wrong set counts. The run was
discarded. The reported numbers below come from a rerun with a local `misses()` using `line % sets`,
and the discarded output is not reported as a result.

## What was run

- **Scratch model:** the two-sided radial stencil of `padded_bitslice.py`, on the same disk: each cell
  reads two ring-mates, one neighbour on the ring outward and one inward, with the same polar and
  Cartesian store orders. Only the set index differs from that script.
- **Index:** `line % sets`, 8 ways, LRU within a set.
- **Grid:** set counts `1, 2, 3, ...` stepped by 3 percent (each step at least one set), up to
  `2^13 = 8192`. Every integer step is allowed, so the grid is not powers of two.
- **Floor:** the first crossing of the excess `misses / compulsory - 1` through the 5 percent tolerance,
  linearly interpolated between the two grid points either side.
- **Line size:** 8 cells per line. **Sizes:** N = 64, 128, 256. One padded run at N = 256.
- **Source:** the scratch files `session-output/polar-padded/fine_capacity.py` and
  `fine_capacity_nopad.txt`, `fine_capacity_pad.txt` (session output, gitignored, per seat).
  Run: `LINE=8 python3 fine_capacity.py nopad 64 128 256`. Wall time about 25 seconds.

## Measured, at 5 percent tolerance

| N | Cartesian floor (sets) | Polar floor (sets) | Ratio | Monotone violations (polar) |
|---|---|---|---|---|
| 64 | 3.6 | 8.6 | 2.39 | 0 |
| 128 | 6.4 | 16.7 | 2.60 | 0 |
| 256 | 12.4 | 33.3 | 2.69 | 0 |
| 256, padded | 12.4 | 33.3 | 2.70 | 0 |

Unit: sets (integer count of cache sets, 8 ways each). Date: `20261011`. Source: the table above, from the
scratch run named there. What holds it still: nothing. It is a free reading, and the command above
re-derives it. This paper does not claim the numbers for any hardware.

## Falsifiers, written after the run

These were not pre-registered. A falsifier written after a run cannot fail that run, so each line
below is a reading of the outcome and carries no test weight.

1. *Quantization.* If the fine grid had reproduced the coarse grid's `4.00`, the earlier index reading
   would have been a grid artifact. It did not: the fine grid reads 2.39 to 2.69 with distinct floors
   at every N. **Reading: the coarse grid was a quantization artifact, and the fine grid resolves it.**
2. *Earlier modulo reading.* The set-associative paper read `2.62` at LINE 8, N = 256 on an integer
   search. The fine grid reads `2.69`, a difference of 0.07. **Reading: consistent within the grid step.**
3. *Padding.* The padding paper predicted that a line boundary moves the ratio by under 0.07 at LINE 8.
   The padded run moves it 0.01. **Reading: consistent; padding does not carry the penalty here.**

## Observation, inference, projection

- **Observation (measured).** Under the modulo index the polar floor is 2.39 to 2.69 times the
  Cartesian floor across N = 64 to 256, with monotone curves and a padded run that matches the
  unpadded one to 0.01.
- **Inference (not measured).** The earlier bit-sliced reading of 3.31 at N = 256 is a property of the
  power-of-two index, not of the layout. A mask over a non-power-of-two count was the source of the
  first attempt's error, and it is also the reason the bit-sliced floor and the modulo floor differ.
- **Projection (not measured).** The ratio rises slowly with N, about 2.39, 2.60, 2.69 for doublings,
  so at N = 1024 it might sit near 2.8. Horizon: this scratch model only. Assumptions: the same stencil,
  8 ways, LRU, one line size. Falsifier: a measured N = 512 ratio below 2.6 or above 3.0 at LINE 8 on
  this model. Confidence: low-medium; a single point at N = 512 has not been run.

## What this does not show

It does not show that polar beats Cartesian, or that it loses. The layout penalty is a ratio against a
Cartesian floor on the same model, and a real grid workload with its own access pattern is not
measured. It does not test a second line size beyond 8 under the fine grid, and the padding band of the
earlier papers stays as it was read.

## Next door

Run N = 512 on the modulo fine grid under the same falsifier, written first this time. The band is
2.6 to 3.0 at LINE 8, and the stamp for the falsifier goes down before the run. If N = 512 lands inside
the band, the fine grid is settled as the reading for this model. If not, the rise with N is the thing
to study next.

Confidence in the claim that the coarse grid was a quantization artifact: high. The fine grid's distinct
floors leave little room for another reading. Confidence in the N = 512 projection: low until it is run.
