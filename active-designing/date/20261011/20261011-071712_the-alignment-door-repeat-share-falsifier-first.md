# The alignment door on the repeat share, falsifiers written before the run

**Status:** Design -- falsifiers stamped `20261011.071712` and committed before any run; no ratio is computed here
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Kin:** [the distinct-line result](20261011-071402_the-alignment-door-distinct-line-stride-result.md) - [the distinct-line falsifiers](20261011-065207_the-alignment-door-distinct-line-stride-falsifier-first.md) - [the line-stride door](20261011-064146_the-alignment-door-line-stride-falsifier-first.md)

## Why this door follows the distinct-line result

The distinct-line run (falsifiers `20261011.065207`, result `20261011.071402`) returned **d' = 1 at N = 256,
384 and 640** in both arms, so D3 fired on a three-way tie. The previous paper named its own next door as
"a histogram of line-index differences rather than only their modal value". Before writing falsifiers for
that door, this paper checks what the door would add, because the check decides whether the door tests
anything new.

**Observation, from the definitions alone (no run):** collapsing runs of equal neighbours removes only
the zero differences. Take a ring sequence `a, a, b, b, c`. Its collapsed form `a, b, c` has differences
`b-a, c-b`. Its raw form has differences `0, b-a, 0, c-b`. The **nonzero** differences are the same in
both, and so is their modal value. A histogram that keeps the nonzero differences and drops the zeros
therefore reproduces d' exactly. It is not a second test of the distinct-line definition.

**Inference:** the only content the named next door adds beyond d' is the **repeat share**, the fraction
of consecutive pairs with difference 0. The door as previously phrased would, in effect, rerun the
distinct-line result under another name. This paper states falsifiers for the repeat share instead, so
the door asks a question the distinct-line run did not ask. The correction to the previous paper's
next door is written here and is not edited into it.

## Prior readings the falsifiers cite

| N | Modulo ratio (unpadded) | Floors cart / polar (unpadded) | Modal stride d' (both arms) |
|---|---|---|---|
| 256 | 2.69 | 12.4 / 33.3 | 1 |
| 384 | 2.59 | 19.2 / 49.7 | 1 |
| 640 | 2.88 | 28.8 / 83.0 | 1 |

These are the distinct-line result's own readings (`20261011.071402`). The repeat share has no prior
reading. This paper therefore predicts it from the layout, and does not claim one.

Scope, as before: scratch model only, 8 ways, LRU, line size 8, 5 percent tolerance, the same disk and
stencil as `ring_offset.py`. Repeat share is defined over the same consecutive ring pairs the distinct-line
run already walks.

## Definitions

- **Repeat share** `r_N`: over all consecutive pairs in all rings, in the unpadded arm, the fraction whose
  line-index difference is exactly 0.
- **Repeat share spread** `s_N`: the maximum minus the minimum of `r_N` across N = 256, 384 and 640.
- **Padding move** `p_N`: `|r_N(padded) - r_N(unpadded)|` at each N.

## Falsifiers, written before the run

- **D1 (identity check).** At each N in both arms, the modal nonzero difference equals d' from the
  distinct-line run (1 at all three N). The falsifier **fires** on any mismatch. A pass says the
  distinct-line definition and the nonzero histogram are one reading, which this paper predicts. A fire
  would contradict the derivation above and would need a new paper before anything else is read.
- **D2 (baseline).** The unpadded modulo ratio and floors reproduce the table above (ratio within 0.01,
  floors 12.4/33.3, 19.2/49.7, 28.8/83.0). The falsifier **fires** if any value moves, and the run stops
  there.
- **D3 (repeat share is flat across N).** The repeat share spread `s_N` is under 0.02. The prediction is
  that repeats come from the eight-cells-per-line geometry, which does not change with N, so the share
  cannot carry a sawtooth that moves with N. The falsifier **fires** if `s_N` is 0.02 or more. A fire
  would mean the share varies with N and could carry the cause, which would name the next door rather
  than support any stride reading.
- **D4 (padding does not move the share).** `p_N` is under 0.02 at each N. The prediction is that line
  padding shifts where lines begin and leaves the zero-difference fraction nearly unchanged. The
  falsifier **fires** on any `p_N` of 0.02 or more.

## Ordering, and what counts as a result

D2 runs first and stops the run on failure. D1, D3 and D4 then run from the same pass. A fire is reported
as a fire. A pass on D3 is three N values, so it bounds a claim about this geometry and no more. It is
not evidence about a cache.

## Caveats, stated before the run

- Repeat share is a fraction over pairs. It is not weighted by how often each line is visited, so a line
  revisited many times weighs the same as one visited once.
- Three N values can only show whether the share is flat over these three. They cannot show whether it
  is flat over a sweep, and the sawtooth needs a sweep to be read at all.
- D1 is the check of the derivation above. If it passes, D1 says nothing about the cache, only that the
  two definitions agree on the nonzero differences.

## Next door, not run here

D1 to D4 are stated. The run is the next lap's work, since this paper's commit is the falsifier-first step.
The distinct-line result stands as recorded, and nothing here overturns it.

---

**Reading.** None yet. This paper stands as falsifiers committed before the run they describe.
