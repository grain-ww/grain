# The repeat-share result -- erratum on the padded arm and D4

**Status:** Design -- correction to `20261011-073043_the-alignment-door-repeat-share-result.md`; the elder paper stays as written
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Kin:** [the result it corrects](20261011-073043_the-alignment-door-repeat-share-result.md) - [the falsifiers](20261011-071712_the-alignment-door-repeat-share-falsifier-first.md)

## What the correction is

The result paper says two things about the padded arm that this lap could not reproduce or that the
code does not support. Both are corrected here, and the elder paper keeps every word it wrote.

1. **"The PAD=1 rows match the unpadded rows to every printed digit."** That is wrong for the ratio.
   Measured this lap, unpadded and padded, `session-output/stride-door/stride_distinct.py` with
   `PAD=1` at N = 256 reads `ratio=2.70`, against 2.69 unpadded. The floors print the same to one
   decimal (12.4 and 33.3), so the 0.01 difference sits in the unrounded floor ratio. Padding does
   move the modulo floor ratio, slightly.
2. **D4 "passes, but vacuous" is right about the repeat share and wrong about padding in general.**
   Padding is a relabeling of line indices. This lap checked the mapping directly at N = 256 and 384
   against `ring_offset.layout` and `stride.layout_pad`: the line map is injective, and the
   consecutive-equality pattern is identical across the whole trace. A repeat share counts equal
   neighbours, so any injective relabeling leaves it unchanged by construction. D4 therefore could
   not have fired under any padding, which makes it a non-test of the repeat share. It says nothing
   against padding changing the floors, which it does (see item 1).

## The unresolved part: a saved output that disagrees

`session-output/stride-door/repeat_share_fixed.txt` (07:39, after the 07:30 paper) prints a padded
repeat share of **0.8746, 0.8747 and 0.8748** at N = 256, 384 and 640, against **0.8727, 0.8734 and
0.8741** unpadded. By the injectivity argument above those padded values should equal the unpadded
ones, so either that run used a different padded layout or a different counting rule, or the file
is wrong.

**The cause cannot be settled from this lap.** While running this lap's check, the lap overwrote
`session-output/stride-door/repeat_share.py`, the harness that produced `repeat_share_fixed.txt`,
with a new script written from the paper's definitions. The old script is not in git (session-output
is gitignored) and no copy survives beside the fixed output. So the padded share in
`repeat_share_fixed.txt` is **unverified** from here, and the 073043 paper's padded-arm claim is
withdrawn until it is re-derived.

The new script's output (`repeat_share_20261011.txt`, 10:31) reads unpadded and padded identical at
every N, to four decimals. That agrees with the injectivity check. It does not agree with the
07:39 file, which is why the file is kept and not deleted.

## What holds, and at what strength

| Claim | Status after this correction |
|---|---|
| D2 baseline: ratio 2.69, 2.59, 2.88; floors 12.4/33.3, 19.2/49.7, 28.8/83.0 | **Pass**, re-run this lap, all three N |
| D1 identity: modal nonzero difference is 1 at each N | **Pass**, re-run this lap |
| D3 repeat share flat across N: spread 0.0014 against the 0.02 bound | **Pass**, 0.8727 to 0.8741 unpadded |
| D4 padding does not move the share | **Passes, and cannot fire.** Any injective relabeling leaves the share unchanged, so D4 says nothing about padding |
| Padding does not move the ratio | **Refused.** The padded ratio reads 2.70 against 2.69 at N = 256 |
| Padded repeat share equal to unpadded | **Unverified** while the 07:39 harness is lost |

## Inference, bounded

The repeat share stays near 0.87 and flat over three N on this model. It reads the eight-cells-per-line
geometry and not the set index, so it cannot carry the sawtooth. The padding effect that matters for
the ratio comes through the set index, which is the part the share does not see.

## Next door

Two things, in order. **First**, restore a padded repeat-share harness with the falsifier written
before it runs, and reconcile against `repeat_share_fixed.txt`: if the 0.8746 reproduces from a
different layout, the padding effect on the share is real and the injectivity argument is wrong about
which trace it sees; if it does not, the 07:39 file is retired by a dated note. **Second**, the
padding question the result paper already named as open: a layout whose ring starts actually change
the line indices in a way that is not a pure relabeling, with a falsifier written first.

## Why this correction is worth writing down

The result paper called D4 a non-test, which was right, and then reported a padded table it did not
verify against a harness it could still run. The loss of that harness is this lap's own doing: a
heredoc wrote a file over a scratch script whose name matched the one the paper cited. Writing the
correction beside the paper, rather than editing the paper, keeps the record of what was first said
and what was later found.
