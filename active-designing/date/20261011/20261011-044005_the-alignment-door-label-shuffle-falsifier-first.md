# The alignment door on a label shuffle, falsifiers written before the run

**Status:** Design -- falsifiers stamped `20261011.044005` and committed before any run; result appended below after the run
**Room:** research for understanding (scratch model; no witness binds it yet)
**Kin:** [the second hash constant](20261011-043036_the-alignment-door-second-hash-constant-falsifier-first.md) - [the hashed-index door](20261011-041450_the-alignment-door-hashed-index-falsifier-first.md) - [the N = 384 and 640 sawtooth](20261011-035855_the-disk-size-series-at-384-and-640-falsifier-first.md)

## What this tests, and a correction to the next door

The second hash constant falsified the alignment door on its own terms: the hash moved the Cartesian
baseline and broke the monotone curve, so neither index isolated alignment. That paper named a
**per-set shuffle of the modulo index** as the next door, one that "leaves the Cartesian floor
fixed."

Before running it, the mechanism needs checking, and the check changes the door. In the scratch
model a set holds lines under LRU, and a set's behavior depends only on which lines it holds, not on
its label. A shuffle that permutes set labels, `set = perm[line % sets]` for a fixed permutation
`perm` of `0..sets-1`, therefore gives every line the same partner set-mates as the modulo index.
The partition into sets is unchanged, so the miss count should be **identical**, not merely close.

This is a prediction from the code path, and the run is there to check it. If it holds, the named
shuffle is an identity: it reproduces the modulo sawtooth exactly and cannot test whether
ring-to-set alignment causes the zig-zag. The door that could test alignment has to change **which
lines share a set**, for example a per-ring offset `set = (line + off[ring]) % sets`. That needs a
ring tag on each trace entry, which the captured trace does not carry. This paper does not build it.

## The construction

A copy of `fine_capacity.py` with one function changed: the set index in `misses()` is
`perm[line % sets]`, where `perm` is a seeded random permutation of `range(sets)`, drawn once per
set count. Everything else is unchanged: 8 ways, LRU, LINE 8, unpadded, the same deterministic disk
and trace, the same 5 percent tolerance, the same floor search. The modulo baseline is rerun in the
same invocation so the two readings come from one code path.

## Falsifiers, written before the run

- **C1 (identity).** At N = 256 and N = 384, unpadded, LINE 8, 5 percent: the shuffled-label
  Cartesian floor, polar floor and ratio equal the modulo baseline run in the same invocation, to the
  printed digit, and the monotone violation counts are equal. Fires if any printed value differs.
  Reason: a relabeling that changes a miss count means the code is not a relabeling, so the identity
  argument is wrong or the code has a bug, and either way the next door cannot be read.
- **C2 (the door is a control, not a test).** If C1 holds, the label shuffle is recorded as a no-op on
  alignment, and the next door is a per-ring offset with its own falsifier. This is a reading of C1,
  not a separate measurement, so it does not fire or hold on its own.
- **C3 (a sign the premise is wrong).** Fires if the shuffled and modulo floors differ at either N.
  Reason: this would mean set identity matters beyond which lines share a set, which the model does
  not contain, and the premise above would need a new reason before any further door.

## What would change the reading

- **C1 holds:** the second-constant result stands, the per-set shuffle is retired as a door, and the
  alignment question stays open until a ring-offset construction with ring tags is written and
  falsified.
- **C1 fires:** the scratch model has a fault or an unmodeled dependence on labels, and the run
  is reported before any further claim.

## Scope

Scratch model only: no hardware, no witness, no claim about any real cache, and nothing about whether
alignment causes the sawtooth on any machine. Confidence that C1 holds: high, from the set-local LRU
argument. The confidence is about the mechanism, not about the code, which the run tests.

---

Appended after the run, below this line. The three falsifiers above are not edited.

**Run.** Completed before clock `20261011.044231` (read at append time). One file, `fine_capacity_shuffle.py`, a copy of the second-constant script with one change: the set index is `perm[line % sets]`, with `perm` a seeded permutation of the set labels. Two arms in parallel, `SHUFFLE=0` (identity, the modulo baseline) and `SHUFFLE=1` (the shuffle), each run as `python3 fine_capacity_shuffle.py nopad 256 384`, unpadded, LINE 8, 5 percent. Outputs are untracked under `session-output/polar-padded/`, named `label_modulo_nopad_20261011.txt` and `label_shuffle_nopad_20261011.txt`.

| N | Arm | Cartesian floor (sets) | Polar floor (sets) | Ratio | Monotone violations |
|---|---|---|---|---|---|
| 256 | modulo (identity) | 12.4 | 33.3 | 2.69 | 0 |
| 256 | label shuffle | 12.4 | 33.3 | 2.69 | 0 |
| 384 | modulo (identity) | 19.2 | 49.7 | 2.59 | 0 |
| 384 | label shuffle | 19.2 | 49.7 | 2.59 | 0 |

The modulo arm reproduces the earlier readings at both sizes (2.69 at N = 256 and 2.59 at N = 384, from `fc256_base_20261011.txt` and `fc384_640_nopad_20261011.txt`), so the code path is the same one those runs used.

**Check that the shuffle was real.** A matching table would mean nothing if the permutation were the identity. The seeded permutation moves 256 of 256 labels at N = 256 and 383 of 384 at N = 384, so the arms differ in their labels and agree in their misses.

**Falsifiers read.** C1 held: every printed value matches at both sizes. C3 did not fire, since the floors do not differ. C2 is the reading of C1: the per-set shuffle is a relabeling, it changes no set's contents, and it cannot test ring-to-set alignment. The door is retired as a test of alignment.

**Reading.** The check confirms the set-local LRU argument in this model. It says nothing new about the sawtooth itself, which the modulo arm reproduces unchanged. What it does is remove one door from the list and show why, before a fleet of runs spent on it. The next door that can change which lines share a set is a per-ring offset, `set = (line + off[ring]) % sets`, and it needs ring tags on the trace, which the captured trace does not carry. Its falsifier will be written, and committed, before anything is built for it.

**Scope.** Scratch model only, with no hardware, no witness, and no claim about any real cache. The alignment cause stays open. Next door, not run: a per-ring offset that changes the line-to-set partition, its ring tags captured first and its falsifiers written before the run.
