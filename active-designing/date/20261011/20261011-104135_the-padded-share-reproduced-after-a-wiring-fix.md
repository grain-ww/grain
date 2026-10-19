# The padded repeat share reproduces once the padding arm is wired -- result

**Status:** Design -- result of a scratch re-run that repairs the padded arm of the repeat-share door; the falsifiers below were written AFTER the run and are a post-hoc reading, not a pre-registered test; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Kin:** [the repeat-share result](20261011-073043_the-alignment-door-repeat-share-result.md) - [the erratum](20261011-103528_the-repeat-share-result-erratum.md) - [the falsifiers](20261011-071712_the-alignment-door-repeat-share-falsifier-first.md)

## What was wrong

The 10:31 run reported unpadded and padded arms identical at every N, and the erratum read that as
the injectivity argument at work. That reading was wrong about the cause. `session-output/stride-door/stride.py`
reads `PAD` from the environment once, at import. `repeat_share.py` calls `st.layout_pad(n)` for both arms
and never sets `PAD`, so its padded rows were unpadded. The identical rows were the wiring, not evidence
about relabeling.

The fix is a separate driver, `session-output/stride-door/repeat_share_padded.py` (untracked scratch).
It sets `st.PAD` explicitly for each arm, then compares the two line maps entry by entry. The original
`repeat_share.py` is left as it was, so the defect stays on record.

## Falsifiers, stated after the run

These were written once the first run had already printed, so they cannot count as a pre-registered test.
They are recorded as the reading this paper makes, with their thresholds fixed here.

- **F1, the wiring defect is real.** The padded and unpadded line maps must differ on at least one entry at each N.
- **F2, padding moves the share.** A repeat-share change above 0.002 at any N would contradict the reading that the share is nearly insensitive to padding.
- **F3, the 07:39 padded values reproduce.** The padded share must match `repeat_share_fixed.txt` (0.8746, 0.8747, 0.8748 at N = 256, 384, 640).

## Readings

| N | Line-map entries differing | Unpadded share | Padded share | Delta | Pairs |
|---|---|---|---|---|---|
| 256 | 2,842 | 0.8727 | 0.8746 | +0.0019 | 253,332 |
| 384 | 6,435 | 0.8734 | 0.8747 | +0.0013 | 572,888 |
| 640 | 17,966 | 0.8741 | 0.8748 | +0.0008 | 1,598,180 |

Modal nonzero difference is 1 in both arms at every N, so the D1 identity check still passes.

- **F1 held.** The line maps differ at every N: 2,842, 6,435 and 17,966 entries.
- **F2 did not fire, narrowly.** The largest delta is +0.0019 at N = 256, 0.0001 under the 0.002 threshold. The threshold was set by eye, so the margin is thin and this paper does not claim it as a bound.
- **F3 held exactly.** The corrected padded values match the 07:39 file to four decimals at all three N.

## Inference, bounded

The 07:39 padded share was real, and the 10:31 "identical" reading came from the wiring. Padding does change
which cells share a line, so the injectivity argument, which treated the padded arm as a pure relabeling,
is not what the data show. The share still barely moves, about one part in a thousand, so the repeat share
does not carry the padding effect on the ratio. That effect runs through the set index, which the share does
not see.

## What this does not settle

- **The padded ratio of 2.70.** It came from the 073043 path, and this paper does not re-derive it. It stays
  unverified until a ratio run uses the corrected wiring.
- **A stronger test.** A layout whose ring starts change the line indices in a non-relabeling way is still
  the padding question the result paper named as open. This run gives no evidence on it beyond the line-map
  difference itself.

## Next door

Re-derive the padded ratio at N = 256, 384 and 640 through a driver that sets `PAD` the same way, with
falsifiers written before that run. Scope: scratch model, 8 ways, modulo index, no hardware.
