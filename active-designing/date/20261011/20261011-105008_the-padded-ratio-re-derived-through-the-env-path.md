# The padded ratio re-derives at 2.70, 2.60 and 2.88 through the corrected path

**Status:** Design -- result of a scratch re-run that closes the "next door" of the padded repeat-share paper; no falsifier was written before this run, so the check below is a reproduction, not a pre-registered test; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Kin:** [the padded repeat share](20261011-104135_the-padded-share-reproduced-after-a-wiring-fix.md) - [the erratum](20261011-103528_the-repeat-share-result-erratum.md) - [the stride door](20261011-064146_the-alignment-door-line-stride-falsifier-first.md)

## What was open

The padded repeat-share paper left one number unverified: the padded polar-over-Cartesian floor ratio of 2.70 at N = 256. It came from an earlier path and had not been re-derived with the corrected wiring. Its named next door was to re-derive the ratio at N = 256, 384 and 640 through a driver that sets `PAD` the same way the repair did.

## What was run

`session-output/stride-door/stride.py` reads `PAD` from the environment at import, and it calls `layout_pad(n)` only when `PAD` is set. Running it with `PAD=1` therefore takes the padded layout by construction. The defect the earlier paper found was in `repeat_share.py`, which never set `PAD`; `stride.py` itself is not the defect.

```
PAD=1 python3 -I stride.py 256 384 640
```

Scratch model, untracked. The run took about three minutes on this guest.

## Readings

| N | Rings | Cartesian floor (sets) | Polar floor (sets) | Ratio | Stored value (`stride_padded.txt`) |
|---|---|---|---|---|---|
| 256 | 128 | 12.4 | 33.3 | 2.70 | 2.70 |
| 384 | 192 | 19.2 | 49.7 | 2.60 | 2.60 |
| 640 | 320 | 28.8 | 83.1 | 2.88 | 2.88 |

Compulsory lines: 6620 Cartesian and 6479 polar at N = 256; 14760 and 14545 at 384; 40704 and 40325 at 640. Monotone violations on the polar trace read 0 at every N. Cartesian violations read 0, 1 and 6 at the three N, which the stride model already records and does not gate.

## Inference, bounded

The 2.70 at N = 256 is reproduced through the environment path, to the printed precision. The stored 2.70, 2.60 and 2.88 are reproduced exactly. So the padded ratio is no longer unverified on this model.

## What this does not settle

- **The ratio is not monotone in N.** It reads 2.70, 2.60, 2.88. The earlier unpadded reading peaked near N = 256 and then rose, and this run does not change that. Three sizes give no trend, and this paper does not read one.
- **The falsifier.** No falsifier was set before the run, so this result cannot confirm or refute a claim in the way a pre-registered test would. It shows only that the stored numbers are reproducible.
- **Hardware.** None. The model is an LRU over lines with a fixed set count, and it makes no claim about any real cache.

## Next door

A pre-registered test of the padded ratio at a fourth N, with the band and the falsifier written before the run, if the captain wants the ratio's shape rather than its reproduction.
