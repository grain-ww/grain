# The sawtooth door -- result (confounded by the set count)

**Status:** Design -- result of the pre-registered sawtooth run; the design did not isolate gcd; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Stamp:** 20261011.121203
**Kin:** [the falsifier, written first](20261011-121102_the-sawtooth-falsifier-first.md) - [the N=192 result](20261011-115900_the-padded-ratio-at-one-hundred-ninety-two.md)
**Raw output:** `session-output/stride-door/sawtooth_20261011.txt`, unpadded (PAD=0), `stride.py` at `20261011.121104`

## What was run

`PAD=0 python3 -I stride.py 192 224 200 225`, scratch model, 46 seconds on this guest.

## Readings

| N | Rings | Polar floor (sets) | Rounded sets | Ratio | Monotone violations (polar) | gcd(N, rounded sets) |
|---|---|---|---|---|---|---|
| 192 | 96 | 24.8 | 25 | 2.62 | 0 | 1 |
| 224 | 112 | 29.2 | 29 | 2.61 | 0 | 1 |
| 200 | 100 | 25.8 | 26 | 2.74 | 0 | 2 |
| 225 | 112 | 28.8 | 29 | 2.76 | 0 | 1 |

Pair A (gcd 1 by design): mean 2.615. Pair B (gcd 25 by design): mean 2.75. Gap 0.135.

## Against the falsifiers

- **S3 (model fault).** Did not fire. Zero monotone violations everywhere, and the N=192 ratio reads 2.62,
  the value already on file.
- **S2 (gap of 0.15 or less).** Literally held: the gap is 0.135. **Read this as inconclusive, not as an
  absence of a sawtooth.**
- **S1 (sawtooth present).** Did not fire at the 0.15 threshold.

## Why S2 does not settle the question

The design assumed the floor sat at about 25 sets for every size, so that gcd(N, 25) would vary as
intended. It does not. The rounded set count moves with N: 25, 26, 29, 29. The gcd that actually varies
is therefore not the one the pairs were built to hold fixed:

- Pair A's "gcd 1" is true for 192 (gcd with 25) and for 224, 225 only against 29 (gcd(225, 29) = 1,
  gcd(224, 29) = 1), so the pair mixes a set count of 25 with two of 29.
- Pair B's "gcd 25" is false for 200. Against its real count of 26 the gcd is 2, and 225 is gcd 1 against 29.

The two pair means differ by 0.135, which is small, and the sizes in each pair do not share a set count.
The gap cannot be attributed to gcd(N, sets) because the set count changed between the pairs as well. The
pre-registered design checked the wrong variable, and the check that would have caught it, reading the
rounded set count for each N, was not run before the falsifier was stated.

## Inference, bounded

On this model the polar-over-Cartesian ratio sits between 2.61 and 2.76 across these four sizes, with no
monotone violations. The ratio tracks N with no pattern this design can name, and it does not track
gcd(N, rounded sets) in any way these four points can show.

## Next door

A sawtooth test can only be read after the set count is fixed per run. The next door is a run that
prints the rounded set count and sets it explicitly, so gcd(N, sets) is set rather than inferred. Its
falsifier must be stated after reading the rounded count and before the run. A run that varies N at
one fixed set count is the cleaner test, and it is still scratch-only.
