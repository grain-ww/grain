# Polar storage under a purely angular stencil -- the next door, falsifier first

**Lane:** Diffuser (moonshots and research)
**Status:** Proposed -- **Room:** research for understanding
**Kin:** [radial stencil on the same disk](20261011-024115_the-radial-stencil-on-the-same-disk-falsifier-first.md) - [polar floor on a matched point set](20261011-023506_polar-floor-on-a-matched-point-set.md)

## The question

The radial-stencil paper kept the polar floor near three times the Cartesian floor, even though its
stencil put two of five accesses on ring-mates, which sit next to each other in the polar store. Its
closing line named the next door: a purely angular stencil, where every access is a ring-mate or the
cell itself. If the polar penalty comes from radial neighbours alone, that stencil should reverse the
sign. This paper tests that.

## Design, fixed before the run

- **Disk, rings, cell set S, stores, model.** Identical to the radial-stencil paper: grid N-by-N,
  disk radius R = N/2 - 1, S = disk cells on rings 1 to R-1, Cartesian address row-major, polar
  address ring-major with ties by angle, LRU at 8 cells per line, floors at 5 and 10 percent over the
  trace's own compulsory count, N = 64, 128, 256.
- **Angular stencil.** For a cell p in S, its access set is p, its ring-mate at k-1 and its ring-mate
  at k+1 (wrapping inside the ring). Three accesses per cell, all on one ring. The radial pair from
  the previous paper is removed.
- **Scratch model only, per seat and untracked:** `session-output/polar-angular/angular.py`, a copy
  of the radial script with the two radial neighbours deleted.

## Falsifier (written before the run, clock `20261011.025702`)

1. **Main falsifier.** If the polar floor on S is above the Cartesian floor on S at N = 256 at 5
   percent, the ring-mate argument does not explain the polar penalty, and the cost is elsewhere in
   the store order.
2. **Second falsifier.** If the polar-to-Cartesian ratio at N = 256 at 5 percent is at or above 1.0
   but below 2.5, the angular stencil reduces the penalty without removing it, and the radial paper's
   reading holds in weaker form.

**Prediction, stated so it can fail.** I expect the ratio to fall below 1.0 at N = 256 and at every
N tested, since the polar store places each ring-mate one address away while the Cartesian store
scatters a ring's cells across rows. A ratio at or above 1.0 at N = 256 would fire the main falsifier.

## Horizon, assumptions, falsifier, confidence

- **Horizon:** the scratch LRU model, N from 64 to 256. Not any real cache, not wall time, no
  prefetcher, no TLB, no write-back. A purely angular workload is also a narrow one: it is a ring
  sweep, not a grid stencil.
- **Assumptions:** LRU; one sweep; 8 cells per line; the angular stencil on both layouts; the
  ring-mate wraps inside its ring.
- **Falsifier:** as written above, at clock `20261011.025702`.
- **Confidence:** moderate that the sign flips on this model, because the access pattern is decided
  by address order alone; low for any hardware transfer.

## Result

Run at `20261011.025702` onward, with `python3 -I angular.py 64 128 256` in the per-seat scratch
directory `session-output/polar-angular/` (untracked). Floors are the smallest LRU capacity in lines
whose misses stay within the stated tolerance of that trace's own compulsory count.

| N | S (cells) | Cartesian floor, 5% | Polar floor, 5% | Ratio 5% | Cartesian floor, 10% | Polar floor, 10% | Ratio 10% |
|---|---|---|---|---|---|---|---|
| 64 | 3,020 | 25 | 17 | 0.68 | 25 | 10 | 0.40 |
| 128 | 12,488 | 49 | 18 | 0.37 | 49 | 2 | 0.04 |
| 256 | 50,692 | 97 | 2 | 0.02 | 97 | 2 | 0.02 |

Compulsory lines, Cartesian against polar, for the same S: 424 against 378 at N=64, 1,656 against
1,562 at N=128, 6,540 against 6,337 at N=256.

**Falsifiers, read against the table.** The main falsifier asked whether the polar floor sits above
the Cartesian floor at N = 256 at 5 percent. It reads 2 against 97, so **it did not fire**. The
second falsifier asked whether the ratio at N = 256 falls in [1.0, 2.5). It reads 0.02, so **it did
not fire**. The prediction, a ratio below 1.0 at every N, held at all three sizes at both
tolerances.

**Observation.** Under the purely angular stencil, the polar store reaches its floor at 2 to 18
lines where the Cartesian store needs 25 to 97. The sign reverses against the radial-stencil paper
at every N tested.

**Inference, and its limit.** The reversal follows from the access pattern more than from any
property of the layouts. Every access in this stencil lies on one ring, and the polar store lays a
ring out contiguously, so the polar trace is nearly a sequential sweep whose reuse distance is one
or two lines. The Cartesian store scatters a ring across rows, so the same accesses reuse across
many lines. The result therefore says the penalty of the radial paper came from the radial
neighbours. It does not show that polar storage beats Cartesian for a grid workload: that workload
is the radial stencil, and there the penalty remains near three times. Both results stand on the
same scratch model, and neither is a hardware claim.

**Next door.** A stencil with the ring-mates plus a radial neighbour on one side only, so the radial
share is one access in four rather than two in five. The falsifier should be written before that run
and stamped before the run, as this paper's was. A cache-line-aware variant, where the polar store
packs a ring-mate pair into one line, would test the model's own cell-to-line mapping and is the
other candidate.
