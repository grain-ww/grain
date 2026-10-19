# The alignment door on a hashed index, falsifiers written before the run

**Status:** Design -- falsifiers stamped `20261011.041450` and committed before any hashed run; result appended below after the run
**Room:** research for understanding (scratch model; no witness binds it yet)
**Kin:** [the grid-step control](20261011-040649_the-grid-step-control-falsifier-first.md) - [the N = 384 and 640 sawtooth](20261011-035855_the-disk-size-series-at-384-and-640-falsifier-first.md) - [the fine capacity grid](20261011-034455_the-fine-capacity-grid-off-powers-of-two.md)

## What this door tests

The grid-step control cleared the search spacing. The sawtooth in the polar-to-Cartesian ratio survives at 1 percent steps: 2.69, 2.59 and 2.88 at N = 256, 384 and 640 on the fine grid, with 2.65 at N = 512 and 2.39 at N = 64. The one cause still open is the one the disk-size paper named first: that the zig-zag tracks the ring-to-set alignment, meaning how each polar ring's lines fall across the modulo set index.

This door tests that cause directly. It swaps the set index and changes nothing else. If the zig-zag is an alignment artifact of `line % sets`, a hashed index that breaks the alignment should flatten the ratio across N.

Unit: the floor is a count of sets, 8 lines each, at 5 percent excess over compulsory misses. The ratio is polar floor over Cartesian floor, dimensionless.

## The change, and only the change

The copy `session-output/polar-padded/fine_capacity_hash.py` is `fine_capacity.py` with one function replaced. The modulo `misses()` becomes a hashed index: a line goes to set `((line * 2654435761) & 0xFFFFFFFF) % sets`, a 32-bit Knuth multiplicative hash taken before the modulo. Everything else is unchanged: 8 ways, LRU, LINE 8, unpadded, the same deterministic disk and trace, the same 3 percent grid to `smax = 1 << 13`. The original file is left alone.

## Falsifiers, written before the run

- **A1 (flattening).** At the hashed index, the unpadded ratio at N = 256, 384, 512 and 640 has a spread, maximum minus minimum, of at most 0.10. Fires if the spread exceeds 0.10. Reason: the modulo readings span 2.59 to 2.88 over those four sizes, a spread of 0.29. If alignment drives the sawtooth, removing it should collapse the spread well inside 0.10, which is about 4 percent of the ratio.
- **A2 (baseline control).** At the hashed index, the Cartesian floor at each of N = 256, 384, 512 and 640 is within 10 percent of the modulo Cartesian floor: 12.4, 19.2, 25.0 and 28.8 sets. Fires if any one differs by more than 10 percent. Reason: if the hash moves the Cartesian baseline itself, the ratio is comparing two different models, and A1 cannot be read as a statement about alignment. A2 firing voids the door. It does not support A1.
- **A3 (monotone curve).** The hashed polar curve has zero monotone violations at all four sizes. Fires on any violation, since a violation means the floor search read noise rather than the model.

## What would change the reading

- **A1 holds and A2 holds:** the sawtooth tracks the modulo alignment at these sizes. The hashed model is flat, so the zig-zag is an index artifact of `line % sets`, and the model's ratio is then a property of the index, not of the disk. This still says nothing about any real cache.
- **A1 fires and A2 holds:** the sawtooth survives an index that breaks ring-to-set alignment, so alignment is not the cause. The next door is then something in the ring sizes themselves, such as how the ring's line count changes at each N, and it gets its own falsifier.
- **A2 fires:** the door is void. The hash has changed the baseline, and the next door is a hash that leaves the Cartesian floor unchanged, or a shuffled modulus control.
- **A3 fires:** the floor search misread the hashed curve, and the ratios at that size are not usable until the grid is rerun.

## What this door does not test

It does not test a real cache, a real trace, or any hardware. It does not show that the hash is the right index for any machine. It tests one cause of one zig-zag, in one scratch model, with one hash constant. A flat result would name alignment as the candidate cause. It would not prove alignment is the only cause.

## Scope

Scratch model only. Eight ways, LRU, LINE 8, unpadded, deterministic disk and trace. No hardware, no witness, no claim about any real cache. Confidence that A1 holds: medium, since a Knuth hash scrambles the ring-to-set relation but might not match the modulo's average miss, which A2 is there to catch. Confidence that A2 holds: medium-high, since the Cartesian trace is a regular grid that a multiplicative hash spreads evenly.

## Result

Appended after the run, below this line. The three falsifiers above are not edited.

Run completed before clock `20261011.042353` (read at append time) on the copy `session-output/polar-padded/fine_capacity_hash.py`, which differs from the original only in the set index (Knuth multiplicative hash, then modulo). Command: `python3 fine_capacity_hash.py nopad 256 384 512 640`, unpadded, LINE 8, 5 percent, 6 min 44 s. Output is untracked in `session-output/polar-padded/fc_hash_nopad_20261011.txt`. The first attempt used `python3 -I`, which drops the script directory from the import path and failed on `padded_bitslice`; no reading came from it.

| Reading | N = 256 | N = 384 | N = 512 | N = 640 |
|---|---|---|---|---|
| Cartesian floor, sets, hashed (modulo) | 13.9 (12.4) | 19.0 (19.2) | 26.0 (25.0) | 32.0 (28.8) |
| Polar floor, sets, hashed | 37.0 | 57.5 | 74.4 | 100.3 |
| Ratio, polar over Cartesian, hashed | 2.67 | 3.03 | 2.86 | 3.14 |
| Monotone violations, hashed polar curve | 14 | 18 | 23 | 23 |

- **A1 (flattening, spread at most 0.10).** Fires. The hashed ratio spans 2.67 to 3.14, a spread of 0.47. The modulo readings spanned 0.29 over the same four sizes, so the hash did not flatten the zig-zag. It moved the level up and kept the spread wide.
- **A2 (baseline within 10 percent).** Fires twice. The Cartesian floor reads 12.1 percent above the modulo value at N = 256 and 11.1 percent above at N = 640. It sits within 10 percent at N = 384 and N = 512. A fired A2 voids the door, so A1 cannot be read as a statement about alignment.
- **A3 (zero monotone violations).** Fires at all four sizes, with 14 to 23 violations on the hashed polar curve. The modulo curve had none.

**Reading.** The door does not establish that ring-to-set alignment causes the sawtooth. The hash moved the Cartesian baseline, so the ratio compares two different models. The hashed polar curve is not monotone in the set count, so the floor search has read a non-smooth curve here.

**The likeliest reason for A3, named as a conjecture rather than a measured fact.** A multiplicative hash taken before the modulo gives each set count a different partition of the lines, so the miss count is not a smooth function of the set count the way it is under the modulo index. If that holds, A3 was the wrong test for a hashed index: its premise, a smooth curve in the set count, is the modulo index's property and not the hash's. That conjecture is not tested here. It would need a falsifier of its own before anyone reads A3 as a fault in the floor search.

**Confidence.** High that A1 and A2 fired as written. Medium on why A3 fired, since the cause is unmeasured.

**Scope.** Scratch model only, with no hardware, no witness, and no claim about any real cache. The alignment cause stays open.

**Next door.** Two candidates, neither run. One: a falsifier for the monotonicity conjecture, written before any run, asking whether the hashed curve becomes monotone under a finer set-count grid. Two: a different hash constant or a per-set shuffle that leaves the Cartesian baseline within 10 percent at all four sizes, so A2 holds and the alignment question can be read at last. The second is the cleaner door, since it keeps A2's job and moves the question the door was built to ask.
