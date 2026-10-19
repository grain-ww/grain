# The alignment door -- the padding arm was never padded, and the D4 reading it gave was an artifact

**Status:** Design -- correction to the repeat-share result stamped `20261011.073043`; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Kin:** [repeat-share result](20261011-073043_the-alignment-door-repeat-share-result.md) - [repeat-share falsifiers](20261011-071712_the-alignment-door-repeat-share-falsifier-first.md)

## What was wrong

The earlier result said D4 passed "but vacuously": padding moved 0 of 253,460 line indices at N = 256. That check compared `ring_offset.layout(256)` with `stride.layout_pad(256)` while the module flag `PAD` was unset, so `layout_pad` returned the unpadded layout. The zero was produced by the check, not by the layout.

The repeat-share harness had the same fault in a second place. It called `st.layout_pad(n)` for the padded arm, but `layout_pad` reads the module-level `PAD` flag from the environment, not its argument. The "padded" arm therefore ran unpadded, and its match with the unpadded rows to every printed digit was expected.

## Re-checks

- With `PAD` forced on, `layout_pad` moves 250,794 of 253,460 entries at N = 256, 570,414 of 573,080 at N = 384, and 1,595,834 of 1,598,500 at N = 640. Unforced, it moves 0 at each N. The padding is real once the flag is set.
- `repeat_share.py` now sets `st.PAD = bool(pad)` before the call. The pre-fix file is kept as `repeat_share_unfixed.py.txt` in the scratch room.

## Corrected readings (scratch model, 8 ways, modulo index)

| N | Arm | Ratio | Repeat share | Modal nonzero d |
|---|---|---|---|---|
| 256 | unpadded | 2.69 | 0.8727 | 1 |
| 256 | padded | 2.70 | 0.8746 | 1 |
| 384 | unpadded | 2.59 | 0.8734 | 1 |
| 384 | padded | 2.60 | 0.8747 | 1 |
| 640 | unpadded | 2.88 | 0.8741 | 1 |
| 640 | padded | 2.88 | 0.8748 | 1 |

Pairs per arm: 253,332 at N = 256, 572,888 at N = 384, 1,598,180 at N = 640. D1 and D2 pass at every row. D3 spread is 0.0014.

## Falsifier D4, read again

D4 said padding does not move the repeat share by more than 0.02. The largest padded-minus-unpadded share difference is 0.0019, and the largest ratio difference is 0.01. D4 passes on real padding.

## Inference, bounded

Padding that really moves ring starts leaves the repeat share and the ratio within 0.002 and 0.01 on this model. The line-index geometry is not the lever for the penalty at this layout. This is the scratch model at 8 ways. It is not evidence about any real cache, and it does not reopen the sawtooth question.

## Correction to the earlier paper

The earlier result paper's D4 line, and its statement that the padded column is "a non-test", are withdrawn. The padded column now measures a real padding arm. The earlier paper is kept as testimony and not edited.

## Next door, not run here

A padding layout that shifts ring starts by a fixed sub-line offset, falsifier written before the run. Until then the padding question is answered only for line-boundary padding.
