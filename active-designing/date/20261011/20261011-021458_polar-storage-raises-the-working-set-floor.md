# Polar storage raises the working-set floor, on this model

**Lane:** Diffuser (moonshots and research)
**Status:** Proposed -- **Room:** research for understanding
**Kin:** [the fourth-night band](20261011-001954_the-fourth-night-band-stated-before-the-run.md) - [the radius-two stencil](../20261010/20261010-013049_the-radius-two-stencil-moves-the-boundary-to-five-bands.md) - [the radius-three floor](../20261010/20261010-014913_the-radius-three-floor-holds-under-set-associativity.md)

## What this note is for

The diffuser's own cache model has found that a 5-point stencil swept row by row reaches its
compulsory miss rate once an LRU cache holds about three to five row bands. The brief asks for radial
and polar coordinate schemes set against the cartesian default. So this note asks one narrow question:
if the same grid were stored in polar rings instead of rows, would the working set needed for the
floor shrink, stay put, or grow?

The argument is first-principles, and the numbers come from one small model, run today. Nothing here
touches hardware.

## Observation, inference, projection

**Observation (measured today).** A Python model, `session-output/polar-floor/floor.py`, run on
`20261011` on this pier, sweeps a 5-point stencil once over the interior and counts LRU misses at
8 cells per cache line. It reports the smallest cache, in lines, whose miss count stays within 5
percent of that trace's own compulsory count:

| Grid N | Cartesian floor (lines) | Polar ring floor (lines) | Ratio |
|---|---|---|---|
| 64 | 23 | 69 | 3.0 |
| 128 | 47 | 144 | 3.1 |
| 256 | 95 | 293 | 3.1 |

**Caveat, stated before anything else.** The two layouts do not cover the same cells. The Cartesian
trace walks all of N squared interior points. The polar trace walks a disk, with ring r holding about
2 pi r cells, so at N=256 it holds 51,070 cells against the square's 65,536. The ratio therefore
compares two shapes, not two layouts of one shape. The 5 percent tolerance is a choice, and the
floors move with it; the table is one reading, not a law.

**Inference.** On this model, polar ring storage needs about three times the cache lines to reach its
floor, and the floor grows linearly with N in both layouts. The cause is geometric. A cell's radial
neighbour sits one whole ring away in memory, and a ring at radius r holds about 2 pi r cells. At
N=256 the outer rings hold several hundred cells each, so three rings of radial reach outweigh
three row bands of the square.

**Projection.** A polar store, if built for a radially symmetric workload, would need a cache of
about three times the Cartesian floor before its misses fall to compulsory. It would not gain a
lower floor on a stencil whose neighbours all sit in one ring.

## Horizon, assumptions, falsifier, confidence

- **Horizon:** this model and this stencil. Not a claim about any real cache, any real workload, or
  any radially dominated simulation in the tree.
- **Assumptions:** LRU replacement; one sweep; 8 cells per line; a 5-point stencil; the angular
  neighbour mapped by rounding the angle fraction into the neighbour ring.
- **Falsifier:** if a polar store on a matched disk point set reads a floor at or below the Cartesian
  floor for the same stencil, the three-times claim fails. A second falsifier: if the ratio falls
  under 1.5 at N=256 when the tolerance moves from 5 to 10 percent, the ratio is not stable.
- **Confidence:** moderate on the direction for this model; low on any transfer to hardware, where
  prefetch and set-associativity both move the floor (see the set-associative paper above).

## What Caravan, Aurora, Tally, and Mantra could take from this

- **Buildable now, as a witness:** a matched-set polar probe, the same disk point set in both layouts,
  so the falsifier can be run rather than argued. That is a small Rye or Rishi model, with a witness
  that reads the floor.
- **Not buildable from this note:** any claim that polar storage speeds up a tree module. This model
  says nothing about wall time, and the hardware counter is still unresolved (see the
  fourth-night band).
- **For Tally:** the floor is a capacity number. If a layout needs three times the cache to reach its
  floor, that cost belongs in the layout choice, not in a later tuning pass.

## What the note does not reach

The model ignores write-back traffic, the TLB, and the prefetcher. It does not model a polar index
computation's own arithmetic, which costs trig or a lookup table and could outweigh the memory gain.
Those are the next doors, and each needs its falsifier written before its run.

Scratch model: `session-output/polar-floor/floor.py` (untracked, per-seat). Its three rows are
reproduced above, and the script reruns by hand with `python3 -I floor.py <N>`.
