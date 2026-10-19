# The padded ratio holds at N = 448

**Status:** Design -- result of the pre-registered run at a fourth padded size; both falsifiers held; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Kin:** [the falsifier, written first](20261011-112410_the-padded-ratio-at-four-hundred-forty-eight-falsifier-first.md) - [the re-derivation](20261011-105008_the-padded-ratio-re-derived-through-the-env-path.md)

## What was run

```
PAD=1 python3 -I stride.py 448
PAD=0 python3 -I stride.py 448
```

Scratch model, untracked, at `session-output/stride-door/`. The run took about 110 seconds on this guest.

## Readings

| Arm | N | Rings | Cartesian floor (sets) | Polar floor (sets) | Ratio | Compulsory lines (Cart / polar) |
|---|---|---|---|---|---|---|
| Padded (PAD=1) | 448 | 224 | 22.1 | 57.8 | 2.62 | 20056 / 19785 |
| Unpadded (PAD=0) | 448 | 224 | 22.1 | 57.8 | 2.62 | 20056 / 19706 |

Monotone violations read 0 on the polar trace and 0 on the Cartesian trace in both arms.

## Against the falsifiers

- **Band (2.5 to 3.0).** Held. The padded ratio reads 2.62, inside the band.
- **F1 (band falsifier).** Did not fire.
- **F2 (padding falsifier, gap above 0.05).** Did not fire. The gap is 0.00 at two decimals.

## Inference, bounded

At N = 448, the padded polar-over-Cartesian floor ratio is 2.62 and matches the unpadded ratio. The padded series now reads 2.70, 2.60, 2.62 and 2.88 at N = 256, 384, 448 and 640. All four sit inside the 2.5 to 3.0 band.

## What this does not settle

- **Trend.** Four sizes still show no monotone trend in N. The ratio wanders inside the band, and this paper does not read a slope.
- **Line padding does not move the ratio here.** The padded and unpadded arms match at this size, so the padding arm changes the compulsory line count (19785 against 19706) without changing the ratio, which matches the repeat-share result.
- **Hardware.** None. The model is an LRU over lines with a fixed set count, and it makes no claim about any real cache.

## Next door

A pre-registered run at a size below 256, such as N = 192, with the band and falsifiers written before the run, if the captain wants the lower end of the curve. Otherwise, the hardware door waits on the maintainer's word to name a raw TLB-miss event.
