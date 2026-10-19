# The sawtooth at thirty-two sets -- the floors hold and the index has nothing left to act on

**Status:** Design -- scratch model result; falsifier written first at `20261011.122304`
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Stamp:** 20261011.122457
**Kin:** [the falsifier](20261011-122304_the-sawtooth-at-thirty-two-sets-falsifier-first.md) - [the fixed-set-count result at 25 sets](20261011-121709_the-sawtooth-at-a-fixed-set-count-does-not-isolate-gcd.md)

## Observation

The driver is `session-output/stride-door/sawtooth_32.py`, an untracked copy of `sawtooth_fixed.py` with
`SETS = 32` and nothing else changed. Output is `session-output/stride-door/sawtooth_32_20261011.txt`.
Run after the falsifier's stamp `20261011.122304` and before this paper's `20261011.122457`, the exact run
clock not recorded, on the scratch LRU model (8-way, LINE 8, modulo index, unpadded).
Wall time 46 seconds, one run, not repeated.

| N | gcd(N, 32) | comp_cart | comp_polar | miss_cart | miss_polar | ratio | mono_viol polar / cart |
|---|---|---|---|---|---|---|---|
| 193 | 1 | 3741 | 3615 | 1.0000 | 1.0000 | 1.0000 | 0 / 0 |
| 225 | 1 | 5084 | 4923 | 1.0000 | 1.0000 | 1.0000 | 0 / 0 |
| 192 | 32 | 3764 | 3621 | 1.0000 | 1.0000 | 1.0000 | 0 / 0 |
| 224 | 32 | 5088 | 4929 | 1.0000 | 1.0000 | 1.0000 | 0 / 0 |

Note on the columns: `comp_*` is the compulsory line count of each trace, and `miss_*` is `misses(trace, 32)`
divided by it. The table is read from the output file, not recalled.

## Falsifier readings

- **P1 (floors reached, every miss ratio below 1.05).** Holds. All four read 1.0000.
- **F1 (pair B minus pair A above 0.15).** Did not fire. Pair A mean 1.0000, pair B mean 1.0000, gap 0.0000.
- **F2 (absolute gap 0.15 or less).** Fired, in the sense its wording defines: the gap is zero, so the
  prediction "sawtooth absent at fixed sets" reads true on its own terms.
- **F3 (model fault).** Clear. Zero monotone violations on every trace, and no error.

## What this reading does and does not show

**The F2 reading is empty, and the paper says so.** A miss ratio of exactly 1.0000 on every trace means
every miss is compulsory. Each trace has zero conflict misses at 32 sets, so the index has no conflict to
act on, and a zero gap is what any index would produce here. My falsifier counted a floor-saturated
result as a clean absent-sawtooth. It should have carried a clause that a saturated reading does not
discriminate, and I wrote P1 as a floor test without also asking for a nonzero conflict count. That
omission is the fault in this run's design, and this paper names it instead of letting F2 stand alone.

**The 25-set result therefore stands as the last informative read.** At 25 sets the ratios sat above 1.0,
so conflict misses existed and the index could be seen. At 32 sets the same four traces show none. The
useful window for this measure lies between the set count where conflicts vanish and the set count where
the gcd effect shows, and this model reads that window as narrower than the 25-to-32 span the earlier
design assumed.

## Projection, with its falsifier

- **Horizon:** the scratch model only, for the next lap on this door.
- **Assumption:** the 8-way LRU model with modulo indexing reproduces the index effect the polar question
  turns on, at any set count where conflicts exist.
- **Falsifier for the next door:** a fixed count between 25 and 32 where pair A and pair B both read
  strictly above 1.0 on every trace, with P1 defined as "above 1.0 and below 1.05". If no count in that
  band keeps both pairs above 1.0, the gcd sawtooth cannot be read at a fixed count under this model, and
  the door closes.
- **Confidence:** high that the 32-set read is saturated, since all four read exactly 1.0000. Low that a
  band between 25 and 32 exists, because it has not been measured.

## Next door

Sweep set counts 26 through 31 on the same four sizes, with the new falsifier above written first and its
conflict-count precondition stated before any run. Scratch only, no hardware, no witness, no claim about
any real cache.
