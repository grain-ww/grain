# P1 cannot pass below the working-set floor -- a trace-length repair would not help

**Status:** Design -- reasoning from measurements already on disk; no new run
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Stamp:** 20261012.013938
**Kin:** [the falsifier, written before the run](../20261011/20261011-124637_the-sawtooth-set-count-table-below-twenty-six-falsifier-first.md) - [the 26-to-31 sweep](../20261011/20261011-123141_the-sawtooth-sweep-26-to-31-no-discriminating-count.md)

## What this door is

Ninety-one diffuser laps have held on the same stall. The falsifier paper above reads the set-count
table from 8 to 25 only if every miss ratio stays below 1.05 on both arms (precondition P1). The
table failed P1 on all 36 rows, so the paper says it "is not read," and every lap since has held
for a ruling. This note asks a narrower question: **can a longer trace repair P1, so the held
laps could simply run again?** The answer decides whether the ruling the maintainer or Claude owes is
about the trace or about the precondition itself.

## Observation (measured, not re-run)

The untracked driver `session-output/stride-door/sawtooth_sweep.py` calls
`session-output/ring-offset/ring_offset.py`, which prints one `floor_polar_sets` value per row.
Those values are the model's own estimate of the set count below which the polar arm cannot hold
its compulsory lines. Read from the outputs on disk (scratch model, `20261011`):

| N | PAD | floor_cart_sets | floor_polar_sets | Source |
|---|---|---|---|---|
| 200 | 0 | 9.4 | 25.8 | `sawtooth_20261011.txt` |
| 224 | 0 | 11.2 | 29.2 | `sawtooth_20261011.txt` |
| 225 | 0 | 10.4 | 28.8 | `sawtooth_20261011.txt` |
| 256 | 0 and 1 | 12.4 | 33.3 | `ring-offset` outputs |

The model names a `ring_offset.py` line that prints both floors and their ratio (`fp/fc`), so the
figures are the program's own, not inferred.

## Inference

1. P1 asks the **miss ratio** to sit under 1.05. A miss ratio near 1 means the trace fits the cache
   at its compulsory line count. For the polar arm that needs roughly `floor_polar_sets` sets or more.
2. The table reads sets 8 through 25. For the repaired pair (N = 223 and 224) the polar floor is about
   29 sets, and for N = 200 it is 25.8. So every row in the read range sits below the polar floor.
3. Lengthening the trace changes how many times each line is touched, not how many sets the cache
   has. The floor is a **capacity** estimate, so no trace length moves it below the set count the
   model prints. A longer trace would make the ratio converge to the same above-1.05 value.
4. Therefore P1 cannot pass on rows 8 through 25 in this model at any trace length. The 36 failures
   are the expected output of a precondition that is structurally unsatisfiable in that range, not a
   run that came in short.

## Projection, with horizon, assumptions, falsifier, and confidence

- **Horizon:** this scratch model and this lap's reading. It says nothing about a real cache.
- **Assumptions:** the 8-way LRU model, the row-major Cartesian walk, and the polar walk as
  `ring_offset.py` implements them. The floor estimate is the model's own and I did not re-derive it.
- **Falsifier of this note:** a trace-length run, pre-registered before it is read, in which the
  polar miss ratio falls under 1.05 at any set count from 8 through 25 for N = 223 or 224. If that
  happens, step 3 is wrong and a longer trace does repair P1. I expect it not to happen.
- **Falsifier of the precondition, and the ruling owed:** P1 as written cannot be satisfied in the
  range it governs. The ruling is one of two: restate P1 relative to `floor_polar_sets` (read the
  table only above each row's floor, or set the range to the floor), or retire the range and move
  to a dense N grid at a set count the model can actually discriminate. Either changes a
  pre-registered rule, so the choice belongs to the maintainer or Claude, not to this lap.
- **Confidence:** high that P1 is unsatisfiable on rows 8 through 25 as written, because the floor
  values above sit above the range. Moderate that the program's floor estimate is exact, since I
  read it and did not re-derive it.

## What this does not decide

Whether the sawtooth question is worth answering. The falsifier was honest and the held laps were
honest about it. This note only shows that the next run cannot come from the trace.

## Why the note exists

A held lap that repeats its reason adds a commit and no evidence. This note makes the reason
checkable, so the ruling can be made on the arithmetic instead of on the stall.

Measured inputs are free to re-read: `head -2 session-output/stride-door/sawtooth_20261011.txt`
and `grep -n floor_polar_sets session-output/ring-offset/ring_offset.py`.
