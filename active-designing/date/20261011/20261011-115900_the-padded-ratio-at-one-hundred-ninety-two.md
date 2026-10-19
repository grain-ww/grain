# The padded ratio at N = 192

**Status:** Design -- result of the pre-registered run at N = 192; F1 and F2 held; F3 read its lower branch; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Kin:** [the falsifier, written first](20261011-115820_the-padded-ratio-at-one-hundred-ninety-two-falsifier-first.md) - [the N=448 result](20261011-112608_the-padded-ratio-holds-at-four-hundred-forty-eight.md)

## What was run

```
PAD=1 python3 -I stride.py 192
PAD=0 python3 -I stride.py 192
```

Scratch model, untracked, at `session-output/stride-door/`. Both runs finished in under 30 seconds on
this guest. Falsifiers were stamped `20261011.115820`; the runs began at `20261011.115846`.

## Readings

| Arm | N | Rings | Cartesian floor (sets) | Polar floor (sets) | Ratio | Compulsory lines (Cart / polar) |
|---|---|---|---|---|---|---|
| Padded (PAD=1) | 192 | 96 | 9.5 | 24.9 | 2.63 | 3764 / 3655 |
| Unpadded (PAD=0) | 192 | 96 | 9.5 | 24.8 | 2.62 | 3764 / 3621 |

Monotone violations read 0 on both traces in both arms. The modal line stride reads 0 (`stride_d=0`),
as it did at every size the line-stride paper measured.

## Against the falsifiers

- **F1 (band, 2.5 to 3.0).** Did not fire. The padded ratio reads 2.63.
- **F2 (padding gap above 0.05).** Did not fire. The gap is 0.01.
- **F3 (sawtooth reading).** The padded ratio sits below 2.69, so the lower branch applies. The
  falsifier was written as a classification rather than a refutation, and this paper reports the
  branch it landed on: the N = 64 to 128 rise is the only trend in the series that stands, and the
  band reading narrows to N >= 256 as stated in the falsifier. This is a reading of the series, not a
  refuted claim.

## Inference, bounded

On the scratch model, the padded and unpadded ratios at N = 192 agree to within 0.01. The padded
series now reads 2.63, 2.70, 2.60, 2.62 and 2.88 at N = 192, 256, 384, 448 and 640. All five sit inside
the 2.5 to 3.0 band.

## What this does not settle

- **Trend.** Five sizes still show no monotone trend. The band holds and no slope is claimed.
- **Hardware.** None. The model is an LRU over lines with a fixed set count and no claim about any real
  cache. The raw TLB-miss event still waits on the maintainer's word.
- **Self-generation.** This run was taken on the lane's mandate to self-generate after six held laps.
  The captain did not rule on it; the run is named here as self-generated so no reader mistakes it for a
  ruled fruit.

## Next door

A pre-registered run with a sawtooth falsifier that can fail: a size pair chosen so that
gcd(N, sets) differs at equal N, with the falsifier written before the run. Otherwise, the hardware door
waits on the maintainer's word.
