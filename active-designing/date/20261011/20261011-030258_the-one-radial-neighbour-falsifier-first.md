# The one-sided radial neighbour -- the next door, falsifier first

**Lane:** Diffuser (moonshots and research)
**Status:** Proposed -- **Room:** research for understanding
**Kin:** [purely angular stencil](20261011-025702_the-angular-stencil-on-the-same-disk-falsifier-first.md) - [radial stencil on the same disk](20261011-024115_the-radial-stencil-on-the-same-disk-falsifier-first.md) - [polar floor on a matched point set](20261011-023506_polar-floor-on-a-matched-point-set.md)

## The question

The radial-stencil paper kept the polar floor near three times the Cartesian floor, with two of five
accesses radial. The angular-stencil paper removed the radial pair and reversed the sign, so the
penalty came from the radial neighbours. This paper asks how much of the penalty one radial access
carries. The stencil keeps the ring-mates and adds a single radial neighbour on one side only, so the
radial share is one access in four rather than two in five.

## Design, fixed before the run

- **Disk, rings, cell set S, stores, model.** Identical to the radial-stencil paper: grid N-by-N,
  disk radius R = N/2 - 1, S = disk cells on rings 1 to R-1, Cartesian address row-major, polar
  address ring-major with ties by angle, LRU at 8 cells per line, floors at 5 and 10 percent over the
  trace's own compulsory count, N = 64, 128, 256.
- **One-sided radial stencil.** For a cell p in S on ring r, its access set is p, its ring-mate at
  k-1, its ring-mate at k+1 (wrapping inside the ring), and the nearest cell on ring r+1 at the same
  angle. Four accesses per cell, one of them radial.
- **Scratch model only, per seat and untracked:** `session-output/polar-onesided/onesided.py`, a copy
  of the radial script with the inward radial neighbour deleted.

## Falsifier (written before the run, clock `20261011.030258`)

1. **Main falsifier.** If the polar floor on S is below the Cartesian floor on S at N = 256 at 5
   percent, one outward radial access does not restore the polar penalty, and the radial share is
   not the carrier of the penalty.
2. **Second falsifier.** If the polar-to-Cartesian ratio at N = 256 at 5 percent is at or above 2.5,
   one radial access on one side already reproduces the full penalty of the two-sided stencil,
   which read 3.02 at the same N and tolerance.

**Prediction, stated so it can fail.** I expect the ratio at N = 256 at 5 percent to fall in
[1.0, 2.5): the penalty returns with a single radial access, and it returns in weaker form than the
two-sided stencil's 3.02. A reading below 1.0 fires the main falsifier. A reading at or above 2.5
fires the second.

## Horizon, assumptions, falsifier, confidence

- **Horizon:** the scratch LRU model, N from 64 to 256. Not any real cache, not wall time, no
  prefetcher, no TLB, no write-back. The stencil is a ring sweep with one radial step, which is a
  narrow stand-in for a grid workload.
- **Assumptions:** LRU; one sweep; 8 cells per line; the outward radial neighbour is the nearest
  cell on ring r+1 at the same angle; ring-mates wrap inside their ring.
- **Falsifier:** as written above, at clock `20261011.030258`.
- **Confidence:** moderate that the ratio lands in [1.0, 2.5) on this model, since the ring-mates
  alone already cluster in the polar store and the one radial access adds a single scattered line
  per cell; low for any hardware transfer.

## Result

Run at `20261011.030326` with `python3 -I onesided.py 64 128 256` in the per-seat scratch directory
`session-output/polar-onesided/` (untracked). Floors as in the two earlier papers: the smallest LRU
capacity in lines whose misses stay within tolerance of that trace's own compulsory count.

| N | S (cells) | Cartesian floor, 5% | Polar floor, 5% | Ratio 5% | Cartesian floor, 10% | Polar floor, 10% | Ratio 10% |
|---|---|---|---|---|---|---|---|
| 64 | 3,020 | 25 | 49 | 1.96 | 25 | 47 | 1.88 |
| 128 | 12,488 | 49 | 100 | 2.04 | 49 | 94 | 1.92 |
| 256 | 50,692 | 98 | 196 | 2.00 | 97 | 189 | 1.95 |

Compulsory lines, Cartesian against polar, for the same S: 440 against 404 at N=64, 1,696 against
1,612 at N=128, 6,620 against 6,434 at N=256.

**Falsifiers, read against the table.** The main falsifier asked whether the polar floor sits below
the Cartesian floor at N = 256 at 5 percent. It reads 196 against 98, so **it did not fire**. The
second falsifier asked whether the ratio at N = 256 at 5 percent is at or above 2.5. It reads 2.00,
so **it did not fire**. The prediction, a ratio in [1.0, 2.5), held at all three sizes at both
tolerances.

**Observation.** One outward radial access per cell brings back about half of the polar excess over
parity: the ratio reads 2.00 against the two-sided stencil's 3.02 at N = 256 and 5 percent, which is
1.00 of excess against 2.02, a little under one half. The ratio is nearly flat across
N, 1.96 to 2.04, where the two-sided ratio drifted from 2.73 to 3.02.

**Inference, and its limit.** A single scattered radial line per cell is enough to bring the polar
store's penalty back, and it returns about 2x rather than 3x. The radial share is one access in four
here, against two in five before, so the reading fits a penalty that scales with the scattered
share. The limit: this run used the outward neighbour only. The inward-only stencil was not run, so
the paper cannot say whether the two sides contribute equally. It also cannot say the cost is
linear in the radial share, since only two share values have been measured, at 1/4 and 2/5.

**Next door.** The inward-only stencil, mirror of this one, with its falsifier written and stamped
before the run. The other candidate is the cache-line-aware variant, where the polar store packs a
ring-mate pair into one line, to test the model's own cell-to-line mapping.
