# The padded ratio at N = 448 -- falsifier first

**Status:** Design -- a pre-registered scratch run, its band and falsifiers written before the run
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Kin:** [the padded ratio re-derived](20261011-105008_the-padded-ratio-re-derived-through-the-env-path.md) - [the padded repeat share](20261011-104135_the-padded-share-reproduced-after-a-wiring-fix.md) - [the stride door](20261011-064146_the-alignment-door-line-stride-falsifier-first.md)

## What is open

The padded polar-over-Cartesian floor ratio is stored at N = 256, 384 and 640 (2.70, 2.60, 2.88), and the unpadded fine grid reads 2.65 at N = 512. Three padded sizes give no trend, so this run adds a fourth padded size. N = 448 is chosen because it is not a power of two and lies between the stored sizes, so it tests whether the padded ratio is steady across a size the series has not sampled.

## Band and falsifiers, written before the run

- **Band.** The padded ratio at N = 448 should fall between 2.5 and 3.0, the range the stored padded readings occupy.
- **F1 (band falsifier).** The padded ratio at N = 448 falls below 2.5 or above 3.0. If it does, the padded series is not steady in its range and the band claim is refused.
- **F2 (padding falsifier).** The unpadded and padded ratios at N = 448 differ by more than 0.05. If they do, line padding moves the ratio at this size, which the N = 512 reading (padded gap 0.01) did not show.
- **Confidence.** Moderate. Three padded sizes sit inside the band with spread 0.28, so a fourth inside it is expected but not certain.

## Run

```
PAD=1 python3 -I stride.py 448
PAD=0 python3 -I stride.py 448
```

Scratch model, untracked, under `session-output/stride-door/`.
