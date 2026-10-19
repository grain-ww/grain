# The sawtooth door -- falsifier, written before the run

**Status:** Design -- falsifier stated before any run; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Stamp:** 20261011.121102
**Kin:** [the N=192 result](20261011-115900_the-padded-ratio-at-one-hundred-ninety-two.md) - [the line-stride paper](20261011-064146_the-alignment-door-line-stride-falsifier-first.md)

## Why this door

The N=192 result named one next door: a pre-registered run whose sizes differ in gcd(N, sets) at equal
scale, so that a sawtooth in the polar-over-Cartesian ratio can appear or fail to appear. The line-stride
measure read zero at every size tried so far, so the stride cause has never had a nonzero reading to act
on. This door asks only whether the ratio tracks gcd(N, sets) on the scratch model.

## Setup

- Scratch model `session-output/stride-door/stride.py`, unpadded (PAD=0), 8-way LRU, modulo index.
- Floor set count, read from the N=192 run: about 25 sets (floor_polar_sets 24.8 to 24.9).
- Pair A, gcd 1 with 25: N = 192 and N = 224 (gcd(192,25) = 1, gcd(224,25) = 1).
- Pair B, gcd 25 with 25: N = 200 and N = 225 (gcd(200,25) = 25, gcd(225,25) = 25).

## Falsifiers (written before the run)

- **S1 (sawtooth present).** The mean ratio of pair B exceeds the mean ratio of pair A by more than 0.15,
  with zero monotone violations on every polar trace.
- **S2 (sawtooth absent).** The absolute gap between the pair means is 0.15 or less. This is the
  prediction if gcd(N, sets) does not move the ratio.
- **S3 (model fault).** Any polar trace shows monotone violations, or the N=192 ratio is not within 0.02 of
  2.62 (the unpadded value already read). If S3 fires, the run is void and nothing is claimed.

The verdict is one of: S1 fired, S2 held, or S3 void. A pair-B mean below pair A by more than 0.15 is read
as S1 fired in the opposite direction, and it is reported as such rather than folded into S2.

## Honest limits, stated before the run

- Four sizes is a small series. A held S2 does not prove the absence of a sawtooth at other gcds.
- The set count is read from the floor, so gcd uses a rounded value; a rounding shift would change the pairs.
- Scratch LRU only. Nothing here touches a real cache.
