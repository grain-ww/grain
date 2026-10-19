# The alignment door on a structured stagger, falsifiers written before the run

**Status:** Design -- falsifiers stamped `20261011.051108` and committed before any K = 2 or K = 3 run; result appended below after the run
**Room:** research for understanding (scratch model; no witness binds it yet)
**Kin:** [the per-ring offset](20261011-044643_the-alignment-door-per-ring-offset-falsifier-first.md) - [the label shuffle](20261011-044005_the-alignment-door-label-shuffle-falsifier-first.md) - [the hashed-index door](20261011-041450_the-alignment-door-hashed-index-falsifier-first.md)

## What this tests

The per-ring offset door named its next door: a **structured** offset in place of a random one,

    set = (line + off[ring]) % sets        off[ring] = (ring * K) % sets

for a small constant K. The per-ring paper's random draw raised the polar floor by 15 to 20 percent
and widened the ratio's spread, so the question is whether a regular stagger can lower the floor
that the random draw raised, and whether it flattens the sawtooth in the ratio across N.

The same question as before: is the zig-zag in the polar-to-Cartesian floor ratio across N caused by
ring-to-set alignment? A regular stagger either breaks the alignment (flattening the zig-zag) or it
does not.

**An honest statement of what already ran.** Before this paper's falsifiers existed, the scratch
script `session-output/ring-offset/stagger_offset.py` was run at K = 0 and K = 1 over N = 256, 384 and
640 (outputs `stagger_K0_256_384_640.txt` and `stagger_K1_256_384_640.txt`, written `20261011.050526`
and `20261011.050857`). Those readings are exploratory. They cannot be read as falsifier-first results,
because the falsifiers below were stamped after them. They are reported in the table below as seen,
and the falsifiers that follow are written against K = 2 and K = 3, which have not been run.

Scope: the scratch model only, 8 ways, LRU, line size 8, unpadded, 5 percent tolerance, one layout
construction (the ring-of-line definition from the per-ring paper). No hardware, no witness, and no
claim about any real cache.

## Readings already in hand (exploratory, before these falsifiers)

| K | N | Cartesian floor (sets) | Polar floor (sets) | Ratio | Polar monotone violations |
|---|---|---|---|---|---|
| 0 | 256 | 12.4 | 33.3 | 2.69 | 0 |
| 0 | 384 | 19.2 | 49.7 | 2.59 | 0 |
| 0 | 640 | 28.8 | 83.0 | 2.88 | 0 |
| 1 | 256 | 12.4 | 33.4 | 2.70 | 0 |
| 1 | 384 | 19.2 | 49.9 | 2.60 | 0 |
| 1 | 640 | 28.8 | 83.1 | 2.88 | 0 |

K = 0 reproduces the modulo baseline, as the per-ring paper's R1 required. K = 1 barely moves it:
the ratio spans 0.28 across N (2.60 to 2.88), against the modulo spread of 0.29. A stagger of one set
per ring leaves the sawtooth where it stood. Read plainly, at K = 1 the regular stagger is almost the
modulo index again, so it says little about alignment one way or the other.

## Falsifiers, written before the K = 2 and K = 3 runs

- **S1 (identity, already read).** K = 0 reproduces the modulo table at N = 256, 384 and 640, read in
  the exploratory table above. Reason: if zero stagger changes a reading, the construction is not the
  modulo baseline. This is an existing reading, not a new test, and it is recorded here so the new
  runs can be read against a known baseline.
- **S2 (Cartesian fixed).** At every N and K run, the Cartesian floor equals its modulo value
  (12.4, 19.2 and 28.8). Reason: the stagger touches the polar arm only. A moved Cartesian floor means
  a bug in the offset path.
- **S3 (stagger flattens the sawtooth).** Across N = 256, 384 and 640 at a given K, the spread of the
  ratio (max minus min) is at most 0.10. **Supports** the alignment reading for that K. The
  falsifier **fires** if the spread is at least 0.29, the modulo spread, since the stagger then removes
  none of the zig-zag. Between 0.10 and 0.29 reads as inconclusive, and the paper says so.
- **S4 (penalty survives).** At each K, the ratio stays at or above 2.0 at every N run. Reason: the
  headline claim is a polar penalty near three times. A fall below 2.0 means the penalty depends on the
  stagger, which would weaken the earlier claim. The falsifier **fires** on any reading below 2.0.
- **S5 (monotone curve).** The polar curve under the stagger has zero monotone violations at every N
  and K run. The second hash constant broke this, and the random offset broke it at 384, so the same
  check applies. Any violation **fires** the falsifier, and the count is reported as it was read.

## Ordering

K = 2 is run first at N = 256, 384 and 640, then K = 3 at the same sizes. S2 is checked on each run
before the ratio is read. The falsifiers are not edited after the run. A reading that contradicts one
is reported as a fire, not as a sign the falsifier was mis-set.

---

Appended after the run, below this line. The five falsifiers above are not edited.

**Run.** Stamped after the falsifiers were committed at `6d1305beb1`. Script:
`session-output/ring-offset/stagger_offset.py` (untracked scratch), run with `K=2` and `K=3`, outputs
`stagger_K2_256_384_640.txt` and `stagger_K3_256_384_640.txt`. Grid, tolerance, ways and layout as in the
per-ring paper. One construction, no seed: the stagger is deterministic, so each K gives one reading.

| K | N | Cartesian floor (sets) | Polar floor (sets) | Ratio | Polar monotone violations | Cartesian monotone violations |
|---|---|---|---|---|---|---|
| 2 | 256 | 12.4 | 33.9 | 2.74 | 0 | 0 |
| 2 | 384 | 19.2 | 50.7 | 2.65 | 0 | 1 |
| 2 | 640 | 28.8 | 83.3 | 2.89 | 0 | 6 |
| 3 | 256 | 12.4 | 34.2 | 2.76 | 0 | 0 |
| 3 | 384 | 19.2 | 51.1 | 2.67 | 0 | 1 |
| 3 | 640 | 28.8 | 83.7 | 2.90 | 0 | 6 |

**Falsifiers read.**

- **S1 held (prior reading).** The K = 0 table above reproduces the modulo baseline.
- **S2 held.** The Cartesian floors are 12.4, 19.2 and 28.8 at both K, equal to the modulo values, and the
  Cartesian violation counts (0, 1, 6) match the baseline.
- **S3 inconclusive.** Spread is 0.24 at K = 2 (2.65 to 2.89) and 0.23 at K = 3 (2.67 to 2.90). Both sit
  between 0.10 and 0.29, so the falsifier neither supports the alignment reading nor fires. The modulo
  spread is 0.29, so the stagger narrows the zig-zag by about 0.05 to 0.06. That is a small change, not a
  flattening.
- **S4 held.** The lowest ratio at either K is 2.65, above the 2.0 floor.
- **S5 held.** The polar curve has zero monotone violations at every N and both K. The random per-ring
  draw had produced 1 to 3 at 384, so the regular stagger does not disturb the curve's shape.

**Reading.** A structured stagger does not reveal a ring-alignment penalty. It raises the polar floor by
about 2 to 3 percent over the modulo index (33.3 to 34.2 at 256, 83.0 to 83.7 at 640), far less than the
random draw's 15 to 20 percent, and it trims the sawtooth's spread by a few hundredths. Read plainly, a
regular stagger lands near the modulo index, and a random one lands worse. The sawtooth survives every
partition change tried so far. This does not prove that alignment is absent. It shows that three
different ways of changing the line-to-set partition, a per-set relabel, a random per-ring draw and a
regular per-ring stagger, leave the zig-zag in place or move it only slightly, so the cause, if it is one
of the index's, is not a ring-start effect this construction can reach.

**Caveats, stated before the next door.** One construction and one ring-of-line definition. K = 2 and
K = 3 are the two values tried, and a stagger tied to the set count rather than a constant was not run.
The Cartesian arm shows a monotone violation at 384 and 640 in every run, which is the baseline's own
feature. No hardware, no witness, and no claim about a real cache.

**Next door, not run.** Either a stagger that depends on the sets (off[r] = r * sets / rings, which spreads
the rings evenly across the set index), with its falsifier written and committed before its run, or a
stop on this line: the ring-start family is closed at this model, and the next door is a different
cause, such as the stride between line addresses, named before any run.
