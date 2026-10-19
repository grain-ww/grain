# The alignment door on the distinct-line stride, falsifiers written before the run

**Status:** Design -- falsifiers stamped `20261011.065207` and committed before any run; no ratio is computed here
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Kin:** [the line-stride door](20261011-064146_the-alignment-door-line-stride-falsifier-first.md) - [the set-spread stagger](20261011-052411_the-alignment-door-set-spread-stagger-falsifier-first.md) - [the per-ring offset](20261011-044643_the-alignment-door-per-ring-offset-falsifier-first.md)

## Why this door follows the stride result

The pre-registered line-stride run (falsifiers stamped `20261011.064146`, run later in the same lap) returned **stride 0 at
N = 256, 384 and 640**, in both the unpadded and the line-padded arms. The cause is in the definition
rather than in the polar layout. A polar walk visits each cell's five neighbours, and eight cells share
one line, so a ring's subsequence of line indices is mostly the same line repeated. The modal consecutive
difference is then 0 at every N, and `g_N = gcd(0, sets) = sets` tracks the set count, not a stride.
That result is recorded in the run's own paper and is not repaired here.

This paper names the next door: keep the same definition but **collapse runs of equal consecutive line
indices** within each ring's subsequence before taking differences. The modal difference of what remains
is the **distinct-line stride** `d'_r`. It is a different definition, and the line-stride paper says it
did not compare definitions. This paper therefore states its falsifiers before any run, and the run
reports against them without editing them.

## Prior readings the falsifiers cite

| N | Modulo ratio (line-stride run, `session-output/stride-door/stride.py` PAD=0; `ring_offset.py` OFFSETS=0 gives the same) | Sets at modulo floor (rounded) |
|---|---|---|
| 256 | 2.69 | 33 |
| 384 | 2.59 | 50 |
| 640 | 2.88 | 83 |

Local maxima of the modulo ratio across the measured sawtooth (`2.39, 2.60, 2.69, 2.59, 2.65, 2.88` at
N = 64, 128, 256, 384, 512, 640, from the sawtooth paper): **256 and 640** are local maxima, and **384**
is a local minimum. This reading is fixed here so the falsifiers can be read without reference to the run.

Scope, as before: scratch model only, 8 ways, LRU, line size 8, unpadded, 5 percent tolerance, the same
disk and stencil as `ring_offset.py`.

## Falsifiers, written before the run

- **D1 (defined and non-degenerate).** The collapsed definition yields a nonzero modal difference at each
  of N = 256, 384 and 640. The falsifier **fires** if any N returns 0, because a stride of 0 again means
  the definition still does not see a stride.
- **D2 (baseline).** The unpadded modulo arm reproduces the table above (ratio within 0.01, floors
  12.4/33.3, 19.2/49.7, 28.8/83.0). The falsifier **fires** if any value moves; the run stops there.
  This baseline was already reproduced by the line-stride run, so D2 is a re-check of the same harness.
- **D3 (distinct stride ranks the local extrema).** Let `g'_N = gcd(d'_N, sets_N)` at the rounded
  modulo floor. The stride cause is supported only if the N with the **largest** `g'_N` is 640 and the
  N with the **smallest** `g'_N` is 384, with no ties. The falsifier **fires** on any other ordering or on
  a tie. Two of the three N values are the local extrema, so this asks for the full ordering and does
  not accept a partial match.
- **D4 (not the padding already tested).** The line-padded arm moves the ratio by under 0.10 at each N
  while `d'_N` holds at its unpadded value. The falsifier **fires** on a move of 0.10 or more.

## Ordering, and what counts as a result

D2 runs first, then D1, then D3 and D4 from the same run. A fire is reported as a fire. A pass on D3 is
three N values, so it is a reason to build a larger set-count sweep rather than a conclusion. D1 and D2
each stop the run on failure, and the result paper says which stopped it.

## Caveats, stated before the run

- One definition of distinct-line stride, the modal difference after collapsing equal neighbours. A
  mean difference or a histogram would give another number, and this paper does not compare them.
- Collapsing equal neighbours is a choice that discards repeat counts. A cell whose five neighbours
  revisit a line is treated as one visit to that line. Any effect of repeat counts is outside D1 to D4.
- The gcd uses the rounded modulo floor, which is an integer set count only by rounding. A floor of
  33.3 is read as 33, and 49.7 as 50. The rounding is fixed here.

## Next door, not run here

D1 to D4 are stated, and the run is the next lap's work, since this paper's commit is the falsifier-first
step. The distinct-line stride is a new definition, so a fire on D3 does not overturn the line-stride
result, which stays as recorded.

---

**Reading.** None yet. This paper stands as falsifiers committed before the run they describe.
