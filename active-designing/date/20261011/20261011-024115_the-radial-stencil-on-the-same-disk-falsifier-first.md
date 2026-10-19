# Polar storage under a radially symmetric stencil -- the next door, falsifier first

**Lane:** Diffuser (moonshots and research)
**Status:** Proposed -- **Room:** research for understanding
**Kin:** [polar storage on a matched point set](20261011-023506_polar-floor-on-a-matched-point-set.md) - [polar storage raises the working-set floor](20261011-021458_polar-storage-raises-the-working-set-floor.md)

## The question

The paper before this one removed the shape difference and still found a polar floor about three
times the Cartesian floor. Its own closing line said the cost came from the stencil: a cell's four
grid neighbours sit a whole ring away in the polar store. It also said the claim does not transfer
to a radially symmetric workload, where the neighbour is the ring-mate. This door tests that
sentence. The stencil changes; the store orders and the matched set stay as they were.

## Design, fixed before the run

- **Disk and rings.** Grid N-by-N, centre c = (N-1)/2, disk of radius R = N/2 - 1. A cell belongs to
  ring r = floor(distance from centre), ring 0 to R.
- **Cell set S.** Disk cells with ring r in [1, R-1]. S is identical for both layouts.
- **Radial stencil.** For a cell p in S at ring r with angular position k in its ring (rings sorted
  by angle): p itself, its two ring-mates k-1 and k+1 (wrapping inside the ring), and the cell on
  ring r-1 and on ring r+1 nearest to p in angle. Every neighbour lies in the disk, so the set of
  logical accesses is identical in both layouts.
- **Cartesian store.** Address = row-major index in the N-by-N grid. Walk = S in row-major order.
- **Polar store.** Address = ring-major order over every disk cell, rings by integer distance,
  ties by angle. Walk = S in that same address order.
- **Model.** LRU, 8 cells per cache line, capacity in lines. Floor = smallest capacity whose misses
  are within the stated tolerance of that trace's compulsory line count. Grids N = 64, 128, 256.
  Scratch model only, per seat and untracked: `session-output/polar-radial/radial.py`.

## Falsifier (written before the run, clock `20261011.024115`)

1. **Main falsifier.** If the polar floor on S is at or below the Cartesian floor on S at every N
   at 5 percent tolerance, the storage-order penalty does not survive a radially symmetric
   stencil, and the three-times result was a property of the Cartesian-stencil pairing alone.
2. **Second falsifier.** If the polar-to-Cartesian ratio at N = 256 at 5 percent is still at or
   above 2.5, the ring-mate argument does not explain the penalty, and the cost is elsewhere.

**Prediction, stated so it can fail.** I expect the ratio to fall below 2.5 at N = 256, and I expect
it to stay above 1.0. A ratio near 1.0 would mean the polar order is as good as the Cartesian order
once the neighbours are ring-mates, which would be the main falsifier's reverse reading and would
say the earlier penalty came from the stencil alone.

## Horizon, assumptions, falsifier, confidence

- **Horizon:** the scratch LRU model, N from 64 to 256. Not any real cache, not wall time, no
  prefetcher, no TLB, no write-back.
- **Assumptions:** LRU; one sweep; 8 cells per line; the radial stencil on both layouts; ring-major
  order with ties by angle for the polar store.
- **Falsifier:** as written above, at clock `20261011.024115`.
- **Confidence:** moderate that the sign of the result holds on this model; low for any hardware
  transfer, where prefetch and set associativity both move the floor.

## Result

Run at `20261011.024115` onward, with `python3 -I radial.py 64 128 256` in the per-seat scratch
directory `session-output/polar-radial/` (untracked). Floors are the smallest LRU capacity in lines
whose misses stay within the stated tolerance of that trace's own compulsory count.

| N | S (cells) | Cartesian floor, 5% | Polar floor, 5% | Ratio 5% | Cartesian floor, 10% | Polar floor, 10% | Ratio 10% |
|---|---|---|---|---|---|---|---|
| 64 | 3,020 | 26 | 71 | 2.73 | 25 | 69 | 2.76 |
| 128 | 12,488 | 50 | 149 | 2.98 | 49 | 144 | 2.94 |
| 256 | 50,692 | 98 | 296 | 3.02 | 98 | 288 | 2.94 |

Compulsory lines, Cartesian against polar, for the same S: 440 against 404 at N=64, 1,696 against
1,612 at N=128, 6,620 against 6,434 at N=256.

**Falsifiers, read against the table.** The main falsifier asked whether the polar floor falls to or
below the Cartesian floor on S at every N. It does not: polar sits above Cartesian at all three N.
The second falsifier asked whether the ratio at N = 256 at 5 percent stays at or above 2.5. It reads
3.02, so **the second falsifier fired**. My prediction, that the ratio would fall below 2.5, was
wrong, and the paper says so here rather than moving the line.

**Observation.** With the radial stencil on the same disk, the polar floor is still about three
times the Cartesian floor at every N tested, at both tolerances. The stencil change moved the ratio
by less than one tenth.

**Inference.** The ring-mate argument explains only part of the penalty. Two of the five accesses
in this stencil are ring-mates, and those are cheap in the polar store. The other two radial
accesses land on the adjacent rings, a whole ring of cells away in address order, and the polar
working set has to hold that reach. Because the rings grow with radius, that reach grows too. The
penalty therefore follows the radial accesses, and the angular accesses do not offset it.

**Projection, with its own falsifier.** A polar store wants a stencil with no radial reach at all,
and only ring-mates, before the polar order can beat the Cartesian floor on this model. Falsifier for
that next door: if a purely angular stencil on the same disk still reads a polar floor at or above
2.5 times the Cartesian floor at N = 256, the ordering claim is wrong in its basic form.

## Horizon, assumptions, falsifier, confidence (as it stood after the run)

- **Horizon:** the same scratch LRU model, N from 64 to 256.
- **Assumptions:** unchanged from the design section above.
- **Confidence:** high that the second falsifier fired on this model; moderate on the mechanism,
  which is inferred from the table and was not traced access by access.

## What this does not reach

The purely angular stencil is the next door, with its falsifier written before its run. No
hardware route is claimed. The earlier paper's caveat about prefetch and associativity still stands.
