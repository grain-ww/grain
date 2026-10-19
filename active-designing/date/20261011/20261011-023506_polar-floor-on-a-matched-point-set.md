# Polar storage on a matched point set -- the next door, falsifier first

**Lane:** Diffuser (moonshots and research)
**Status:** Proposed -- **Room:** research for understanding
**Kin:** [polar storage raises the working-set floor](20261011-021458_polar-storage-raises-the-working-set-floor.md) - [the fourth-night band](20261011-001954_the-fourth-night-band-stated-before-the-run.md) - [the radius-two stencil](../20261010/20261010-013049_the-radius-two-stencil-moves-the-boundary-to-five-bands.md)

## The question

The paper before this one read a polar floor about three times the Cartesian floor. Its own caveat
named the comparison as unfair: the Cartesian trace walks the full N-squared square, while the polar
trace walks a disk of about 78 percent of those cells. A ratio between two shapes is not a ratio
between two storage orders. This door removes the shape difference. Both layouts walk the same
cells, under the same Cartesian 5-point stencil, and only the address order of the store changes.

## Design, fixed before the run

- **Cell set S.** Interior cells of the N-by-N grid whose four neighbours all lie inside the disk
  of radius N/2 - 1 about the centre. S is identical for both layouts.
- **Cartesian store.** Address = row-major index in the N-by-N grid. Walk = S in row-major order.
- **Polar store.** Address = ring-major order over every disk cell, rings by integer distance from
  the centre, ties by angle. Walk = S in that same address order.
- **Stencil.** Each visited cell touches itself and its four grid neighbours, in both layouts.
  Neighbours are geometric, so the two layouts make the same logical accesses.
- **Model.** LRU, 8 cells per cache line, cache capacity in lines. Floor = smallest capacity whose
  misses are within 5 percent of that trace's compulsory line count. Grids N = 64, 128, 256.

## Falsifier (written before the run, clock `20261011.023506`)

1. **Main falsifier.** If the polar floor on S is at or below the Cartesian floor on S at every N,
   the three-times claim fails on a matched set, and the polar penalty was a shape artefact.
2. **Second falsifier.** If the polar-to-Cartesian ratio on S falls below 1.5 at N = 256 when the
   tolerance moves from 5 to 10 percent, the ratio is not stable enough to state.

**Scope:** the scratch model only, per-seat and untracked. No hardware, no wall time, no prefetcher,
no TLB. A result here changes the claim about storage order on this model and nothing else.

## Result

Run at `20261011.023506` onward, with `python3 -I matched.py 64 128 256` in the per-seat scratch
directory `session-output/polar-matched/` (untracked). Floors are the smallest LRU capacity in lines
whose misses stay within the stated tolerance of that trace's own compulsory count.

| N | S (cells) | Cartesian floor, 5% | Polar floor, 5% | Ratio 5% | Cartesian floor, 10% | Polar floor, 10% | Ratio 10% |
|---|---|---|---|---|---|---|---|
| 64 | 2,852 | 23 | 68 | 2.96 | 23 | 67 | 2.91 |
| 128 | 12,136 | 47 | 143 | 3.04 | 47 | 139 | 2.96 |
| 256 | 49,980 | 95 | 290 | 3.05 | 95 | 286 | 3.01 |

Compulsory lines, Cartesian against polar, for the same S: 424 against 378 at N=64, 1,656 against
1,562 at N=128, 6,540 against 6,337 at N=256. The polar store packs the disk into fewer lines, and
the difference is small beside the floor gap.

**Falsifiers, read against the table.** The main falsifier asked whether the polar floor falls to or
below the Cartesian floor on S. It does not: polar sits above Cartesian at every N and both
tolerances. The second asked whether the ratio falls under 1.5 at N=256 at 10 percent. It reads
3.01, so it did not fire. Neither branch fired.

**Observation.** On the matched set, the polar floor is about three times the Cartesian floor, at
every N tested, at both tolerances. The earlier paper's ratio of 3.0 to 3.1 was therefore not a
product of the disk-versus-square shape difference. The caveat that paper named is removed by this
run.

**Inference.** On this stencil and this LRU model, the three-times cost comes from the storage order
alone. A cell's four grid neighbours sit in adjacent rows in the Cartesian store and in adjacent
rings, a whole ring of cells away, in the polar store. Each polar sweep row therefore has to hold
several rings of radial reach, and those rings grow with radius.

**Projection.** A polar store driven by a Cartesian stencil needs about three times the cache lines
to reach its floor, on this model at these sizes. This is a claim about the model. It says nothing
about a radially symmetric workload, where the neighbour is the ring-mate and the order is the
better one.

## Horizon, assumptions, falsifier, confidence

- **Horizon:** the scratch model above, N from 64 to 256. Not any real cache, not wall time, not a
  radially symmetric workload.
- **Assumptions:** LRU; one sweep; 8 cells per line; the 5-point Cartesian stencil on both layouts;
  ring-major order with ties by angle for the polar store.
- **Falsifier, restated:** a radially symmetric stencil, whose neighbours are ring-mates, would show
  the polar floor at or below the Cartesian floor. That is the next door, and it needs its own
  falsifier written before the run.
- **Confidence:** high for the matched-set ratio on this model; low for any transfer to hardware,
  where prefetch and set associativity both move the floor.

## What this does not reach

The model excludes write-back, the TLB, the prefetcher, and the cost of the polar index arithmetic.
Those stay open. The next door is the radially symmetric stencil on the same disk, whose falsifier
is written before its run, or the maintainer's word for a hardware route.

Scratch model: `session-output/polar-matched/matched.py` (untracked, per-seat), run with
`python3 -I matched.py <N> ...`.
