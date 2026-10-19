# The alignment door on the repeat share -- result

**Status:** Design -- result of the falsifier-first run whose falsifiers were stamped `20261011.071712`; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Kin:** [falsifiers](20261011-071712_the-alignment-door-repeat-share-falsifier-first.md) - [distinct-line result](20261011-071402_the-alignment-door-distinct-line-stride-result.md)

## What was run

Harness `session-output/stride-door/repeat_share.py` (untracked scratch, same layout, trace and 8-way LRU model as `stride_distinct.py`). Arms: unpadded and PAD=1, at N = 256, 384, 640. Repeat share is the fraction of consecutive per-ring pairs with line-index difference 0.

## Readings

| N | Arm | Ratio | Floors cart / polar | Repeat share | Modal nonzero d | d1 mismatched rings |
|---|---|---|---|---|---|---|
| 256 | unpadded | 2.69 | 12.4 / 33.3 | 0.8727 | 1 | 0 |
| 384 | unpadded | 2.59 | 19.2 / 49.7 | 0.8734 | 1 | 0 |
| 640 | unpadded | 2.88 | 28.8 / 83.0 | 0.8741 | 1 | 0 |

The PAD=1 rows match the unpadded rows to every printed digit.

## Falsifiers

- **D2 (baseline): pass.** Ratios and floors reproduce the distinct-line table.
- **D1 (identity): pass.** Nonzero raw differences equal the collapsed differences as a multiset in every ring, and the modal nonzero difference is 1 at each N.
- **D3 (share flat across N): pass.** Spread 0.0014, under the 0.02 bound.
- **D4 (padding does not move the share): pass, but vacuous.** Padding moved 0 of 253,460 line indices at N = 256 (checked by comparing `ring_offset.layout(256)` with `stride.layout_pad(256)`). A zero padding move is what the code produces, not a measured effect of padding. D4 does not test padding and should not be cited as a result.

## Inference, bounded

On this scratch model the repeat share is near 0.87 and flat across three N values. That is consistent with the prediction that repeats come from the eight-cells-per-line geometry. It says nothing about the sawtooth in the ratio, which the share does not track. It is three N values at 8 ways on one model, so it is not evidence about a real cache.

## Next door, not run here

A real padding arm: a layout whose ring starts actually change the line indices, with a falsifier written before the run. Until then the padding question stays open, and the padded column above should be read as a non-test.
