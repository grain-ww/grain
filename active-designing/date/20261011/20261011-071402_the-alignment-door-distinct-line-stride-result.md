# The alignment door on the distinct-line stride, result

**Status:** Design -- result of the falsifier-first run stamped `20261011.065207`; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Kin:** [the falsifiers](20261011-065207_the-alignment-door-distinct-line-stride-falsifier-first.md) - [the line-stride door](20261011-064146_the-alignment-door-line-stride-falsifier-first.md)

## What was run

The distinct-line stride, collapsing runs of equal consecutive line indices within each ring before the modal difference is taken. Same disk, layout, stencil, 8-way LRU model, line size 8, 5 percent tolerance as the line-stride run. Harness: `session-output/stride-door/stride_distinct.py` (untracked, gitignored per-seat scratch; reads `stride.py` and `ring_offset.py` beside it). Unpadded output: `distinct_unpadded.txt`. Padded output: `distinct_padded.txt`.

## Readings

| N | Modulo ratio (unpadded / padded) | Floors, cart / polar (unpadded) | Distinct stride d' (both arms) | g' = gcd(d', sets) |
|---|---|---|---|---|
| 256 | 2.69 / 2.70 | 12.4 / 33.3 | 1 | 1 |
| 384 | 2.59 / 2.60 | 19.2 / 49.7 | 1 | 1 |
| 640 | 2.88 / 2.88 | 28.8 / 83.0 (padded 83.1) | 1 | 1 |

## Falsifiers, read as written

- **D1 (nonzero stride at each N): passes.** d' is 1 at every N in both arms, never 0.
- **D2 (baseline reproduces): passes.** Ratios and floors match the pre-registered table within the stated tolerance.
- **D3 (distinct stride ranks the extrema, no ties): fires.** All three g' values are 1. The required ordering (largest at 640, smallest at 384, no ties) cannot hold when every value ties.
- **D4 (padding moves the ratio under 0.10, d' held): passes.** The largest move is 0.01, and d' stays 1 in the padded arm.

## What this says

Observation: collapsing equal neighbours gives the same consecutive-line step, 1, at all three sizes in both arms.

Inference: the distinct-line definition does not separate the local extrema either. The stride cause this door was testing is not supported on this model under either definition. The line-stride result stays as recorded, and this run does not overturn it.

Projection, bounded: this is three N values on one scratch model at 8 ways. It is not a set-count sweep, and it says nothing about hardware. A stride that does explain the sawtooth would need a definition that resolves the extrema, or a wider N set than three, both named as untested.

## Next door, not run here

A definition that keeps repeat counts (a histogram of line-index differences rather than only their modal value), stated falsifier-first before any run. Or the maintainer's word to widen N beyond three.

---

**Reading.** D3 fired; D1, D2 and D4 passed. The stride cause is not supported under the distinct-line definition on this model.
