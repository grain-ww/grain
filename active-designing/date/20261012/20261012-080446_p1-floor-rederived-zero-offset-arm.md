# P1 floor re-derived -- the cited table is the zero-offset arm

**Status:** Design -- a re-derivation of the floor values the P1 note cites; one run, no new falsifier, no ruling made
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Stamp:** 20261012.080446
**Kin:** [the P1 floor note](20261012-013938_p1-floor-is-capacity-not-trace-length.md) - [the sawtooth falsifier](../20261011/20261011-124637_the-sawtooth-set-count-table-below-twenty-six-falsifier-first.md)

## What this corrects

The P1 floor note (`20261012.013938`) marked its floor table "measured, not re-run" and said the
N = 256 value came from "ring-offset outputs", and it did not say which arm those outputs ran.
Re-deriving them shows the cited table is the **zero-offset arm** (`OFFSETS=0`). The default arm,
which `ring_offset.py` runs when `OFFSETS` is unset, reads higher. The note's conclusion holds on
both arms. Its figures hold on one arm only, and it should have said so.

## Observation (measured on this checkout, 20261012, one run each)

Command, from `session-output/ring-offset/`: `OFFSETS=0 python3 -I ring_offset.py 200 224` and
`python3 -I ring_offset.py 200 224`. Each printed both N in about 29 seconds on this machine.

| N | Arm | floor_cart_sets | floor_polar_sets | ratio |
|---|---|---|---|---|
| 200 | zero offsets (`OFFSETS=0`) | 9.4 | 25.8 | 2.74 |
| 224 | zero offsets (`OFFSETS=0`) | 11.2 | 29.2 | 2.61 |
| 200 | default offsets (`OFFSETS` unset) | 9.4 | 29.5 | 3.15 |
| 224 | default offsets (`OFFSETS` unset) | 11.2 | 34.3 | 3.06 |

The zero-offset row reproduces the recorded `sawtooth_20261011.txt` values exactly (25.8 at N = 200,
29.2 at N = 224), and the N = 256 value of 33.3 sits in the zero-offset files
`session-output/ring-offset/r1_zero_256_384.txt` and `stagger_K0_256_384_640.txt`.

One further figure is on disk and is not re-run here. `offset_seed1_256_384_640.txt`, which carries
the default arm, reads **39.4** at N = 256. This lap did not run N = 256 on either arm, so that value
stands as the file's own testimony. The zero-offset value of 33.3 is the only N = 256 figure the P1
note uses.

## Inference

1. The P1 note's table is correct as the zero-offset arm. Its N = 200 floor (25.8) sits **0.8
   sets above** the top of the governed range (25). That margin is thin, and it is the one arm that
   reaches the range at all.
2. On the default arm every row in the governed range sits lower, with a margin of 4.5 sets or more
   at N = 200. The P1 conclusion (no row in 8 through 25 clears its own floor) therefore holds on
   both arms.
3. The note's reading that a longer trace cannot move the floor was not re-tested here. This lap
   changed only which arm the figures belong to.

## Projection, with horizon, assumptions, falsifier, and confidence

- **Horizon:** this scratch model, the 8-way LRU walk, and the two offset arms as `ring_offset.py`
  implements them. No hardware.
- **Assumptions:** the printed floors are the program's own estimate (`cross` at tolerance 0.05 over
  the set grid to 2^13). This lap re-ran that code and did not re-derive the estimate itself.
- **Falsifier of this correction:** a re-run that prints a zero-offset floor below 25.8 at N = 200,
  or a default-arm floor below 25 at N = 200. Either reds the claim that every governed row sits
  below its floor on both arms.
- **Falsifier of the P1 conclusion, unchanged from the note:** a polar miss ratio under 1.05 at any
  set count from 8 through 25 for N = 223 or 224.
- **Confidence:** high that the zero-offset table reproduces exactly. Moderate that the conclusion
  generalises across N, since only N = 200 and 224 were re-run here.

## The ruling, still owed, and what this note does not do

This note does not restate P1, retire the range, or pick a new set count. Each of those changes a
pre-registered rule after the data was read, which the falsifier-first discipline refuses. The owed
choice still belongs to the maintainer or Claude, and the P1 note lists its two options.

A recommendation, offered and not applied: retire the 8-through-25 range, and pre-register a new
falsifier on set counts above the largest zero-offset floor in the table, which is 33.3 at N = 256.
The new rule would be written before its run. Restating P1 against each row's own floor would read
the existing data after it was seen, and that is the reading this note declines.

## Why the note exists

The P1 hold has lasted over a hundred laps on one owed ruling. A correction that names which arm
the figures belong to lets whoever makes the ruling see that the numbers are right on one arm and
still support the conclusion on both, without repeating the stall.

Measured inputs are free to re-read: `OFFSETS=0 python3 -I session-output/ring-offset/ring_offset.py 200 224`
and `python3 -I session-output/ring-offset/ring_offset.py 200 224`, both from the diffuser checkout.
