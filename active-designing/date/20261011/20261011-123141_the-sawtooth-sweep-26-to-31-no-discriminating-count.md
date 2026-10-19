# The sawtooth across 26 to 31 sets -- no count discriminates, and the pairs were confounded

**Status:** Design -- result of the falsifier at 123052; scratch model only
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Stamp:** 20261011.123141
**Kin:** [the falsifier](20261011-123052_the-sawtooth-sweep-26-to-31-falsifier-first.md) - [the 32-set result](20261011-122457_the-sawtooth-at-thirty-two-sets-saturates-to-compulsory.md)

## Observation

Run: `python3 -I sawtooth_sweep.py 26 27 28 29 30 31 -- 192 193 224 225`, from
`session-output/stride-door/`, output kept beside the driver as `sawtooth_sweep_20261011.txt`. Fourteen
seconds on the Framework bench, one run, 24 rows. Each row is one trace at one set count.

| sets | N | gcd | conflict cart | conflict polar | miss cart | miss polar |
|---|---|---|---|---|---|---|
| 26 | 192 | 2 | 0 | 0 | 1.0000 | 1.0000 |
| 26 | 193 | 1 | 0 | 0 | 1.0000 | 1.0000 |
| 26 | 224 | 2 | 0 | 2025 | 1.0000 | 1.4108 |
| 26 | 225 | 1 | 0 | 2070 | 1.0000 | 1.4205 |
| 27 | 224 | 1 | 0 | 1422 | 1.0000 | 1.2885 |
| 27 | 225 | 9 | 0 | 1481 | 1.0000 | 1.3008 |
| 28 | 224 | 28 | 0 | 599 | 1.0000 | 1.1215 |
| 28 | 225 | 1 | 0 | 827 | 1.0000 | 1.1680 |
| 29 | 224 | 1 | 0 | 318 | 1.0000 | 1.0645 |
| 29 | 225 | 1 | 0 | 103 | 1.0000 | 1.0209 |
| 30 | 224 | 2 | 0 | 10 | 1.0000 | 1.0020 |
| 30 | 225 | 15 | 0 | 0 | 1.0000 | 1.0000 |
| 31 | all four | 1 | 0 | 0 | 1.0000 | 1.0000 |

Rows for 192 and 193 at 27 to 30 are omitted here as conflict-free at every count, and the full table
is the saved output. Observation, nothing more: the Cartesian arm shows **zero conflict misses at every
count and every N**. The conflicts sit only in the polar arm, and only for N = 224 and 225, and only at 26
to 30. N = 192 and 193 show no polar conflicts at any count tested.

## Inference: the preconditions as written

- **P1 (floors reached, every miss ratio below 1.05 on both arms).** Fails at 26, 27 and 28 for N = 224
  and 225 (polar ratios 1.12 to 1.42), and at 29 for N = 224 (1.0645). It holds at 30 and 31.
- **P2 (a conflict count nonzero in each pair, on both arms).** Fails at **every** count. The Cartesian
  arm never shows a conflict, so the literal "both arms" reading cannot pass at any set count in 26 to 31.
- **P3 (no fault).** Clear. Every polar and Cartesian trace shows misses at or above its compulsory
  line count, and the run completed without error. Note: the 32-set paper's P3 also ran a monotone check
  across a set-count grid. This sweep did not rerun that grid, so P3 here is the fault check only, a
  narrower reading than the falsifier named, and the paper says so.

## Verdict under the pre-registered falsifiers

**F4 fires, as written.** No set count in 26 to 31 passes P2 on both arms, so the sweep says nothing
about gcd. F1, F2 and F3 are not read. The literal result is that this model's Cartesian arm is
conflict-free at these counts for every N tested, so an arm-to-arm read cannot discriminate here.

## What the pairs were, and why the pair mean is not the gcd reading

The falsifier named pair A as N = 193 and 225, and pair B as N = 192 and 224. Pair A therefore holds one
conflict-free size (193) beside one conflicting size (225), and pair B holds one conflict-free (192)
beside one conflicting (224). Each pair mean averages a flat 1.0 with a value near 1.0 to 1.4. The
means then land near one another by construction, and the pair gap at every count stays under 0.03:

| sets | pair A mean (193, 225) | pair B mean (192, 224) | gap |
|---|---|---|---|
| 26 | 1.2103 | 1.2054 | 0.005 |
| 27 | 1.1504 | 1.1443 | 0.006 |
| 28 | 1.0840 | 1.0608 | 0.023 |
| 29 | 1.0105 | 1.0323 | 0.022 |
| 30 | 1.0000 | 1.0010 | 0.001 |
| 31 | 1.0000 | 1.0000 | 0.000 |

A reading of F2 on these means would say "absent," and that reading would be wrong about the model,
because the gap is small only because the pairing cancels the size effect. **This is a fault in the
pairing I pre-registered**, found after the run and named here rather than hidden. The 32-set paper
said the pairs were redrawn to split gcd cleanly. They did split gcd (1 against 32), but they did not
balance N size, and at these counts N size is the variable that carries the conflicts. The gcd split
is therefore not the thing this design reads.

## Per-N reading, in place of the pair mean

Read one N at a time, and the gcd prediction would be that gcd 1 with the sets raises conflict and gcd
equal to the set count lowers it. The table does not show that pattern. At 28 sets, N = 224 has gcd 28
and conflict 599, while N = 225 has gcd 1 and conflict 827, so the higher gcd carries fewer conflicts,
the reverse of a gcd-driven sawtooth. At 26 sets, N = 224 (gcd 2) and N = 225 (gcd 1) differ by under
0.01 in ratio. So in this model the conflict count tracks N's distance from the set count and from the
floor, and gcd does not read as the driver. This is inference from the ten set counts that carry a polar conflict, across two N values, not
a measured gcd law, and it would be killed by a wider N sweep at fixed sets that holds N size and
varies gcd alone.

## Falsifier of this inference

If a wider N sweep, with N size held near 224 and gcd varied across 1, 2, 4, 8 and 28 at a fixed set count
in 26 to 30, shows the conflict count tracking gcd rather than N size, this inference is wrong and the
sawtooth is a gcd effect after all. If conflict tracks N size with gcd flat, the inference stands.

## Next door

Two honest options, neither run:

1. **Repair the pairing, falsifier first.** Hold N size near 224 and vary gcd alone at a fixed count in
   26 to 30, since per-N reading shows gcd does not carry the effect at these sizes. This answers whether
   gcd matters at all in this model, rather than re-reading the same confounded pair mean.
2. **Drop the pair design.** Read conflict count against N across a dense N grid at 28 sets. It needs no
   pairs, and so no pairing fault can enter it.

Option 1 is the next door this paper recommends, and it needs its own falsifier written before any run.

## What this does not claim

Nothing about hardware, a real cache, a real stencil kernel, or any compute target. The model is an
8-way LRU with modulo indexing, scratch, untracked. The result is a statement about this model at these
counts, and a model that does not match the hardware it might one day describe would make every number
here a number about the model alone.

## Reproduce

```sh
cd session-output/stride-door
python3 -I sawtooth_sweep.py 26 27 28 29 30 31 -- 192 193 224 225
```

The untracked driver and its output are not in the repository's tree; the falsifier paper and this
result are the testimony that stands beside them.
