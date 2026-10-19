# The page-walk probe: blocked on this guest, falsifiers written before any run

**Status:** Research design -- the next door the huge-page sweep paper names, stated falsifier-first; no run in this lap
**Room:** research for understanding -- nothing here is bound by a witness; the blockage facts are free and re-readable by the commands in Reproduce
**Date:** 2026-10-11, clock `20261011.090601`
**Kin:** [the huge-page sweep falsifier fired](20261011-074228_the-huge-page-sweep-falsifier-fired.md) -- [the generic counter reads high on a random chase](../20261009/20261009-231436_the-generic-counter-reads-high-on-a-random-chase.md) -- [the calibration witness](../../../tools/c/cache_miss_calibrate_witness.rish)

## What this paper asks

The huge-page sweep left one question open. Its page-walk candidate needs a measurement that does not
pass through the generic `cache-misses` counter, which has now failed calibration twice. The sweep
paper names the only direct route: a raw vendor event that separates page walks from demand misses,
named by the maintainer. This paper asks two narrower things before anyone spends that word:

1. Can the probe run on this guest at all, with the tools present today?
2. If a timing probe is the fallback, what would it have to show, stated now so that the result cannot
   be bent to fit it afterward?

## What the aether row asks first

The aether row asks what the work is for before it asks what the work measures. Here the purpose is
narrow: the tree wants to know whether a cache-alignment claim survives a measurement it could not
have faked. A counter that reads a few percent of the fills it must cause cannot carry that claim
alone, so the probe has to be one the counter is not in the middle of.

## What this lap found on this guest (observed, 20261011, clock `090601`)

Observation, each line read from the machine and not from memory:

| Reading | Value | Command |
|---|---|---|
| Kernel | 6.18.41 | `uname -r` |
| CPU model | AMD EPYC-Rome Processor, 2 cores visible to the lap | `/proc/cpuinfo` |
| Hypervisor flag | present | `/proc/cpuinfo` |
| Transparent huge pages | `madvise` | `/sys/kernel/mm/transparent_hugepage/enabled` |
| Huge page defrag | `madvise` | `/sys/kernel/mm/transparent_hugepage/defrag` |
| Reserved huge pages | 0 | `/proc/sys/vm/nr_hugepages` |
| `perf` on PATH | no | `command -v perf` |
| C compilers on PATH | none of `cc`, `gcc`, `clang` | `command -v` |
| Zig on PATH | no | `command -v zig` |
| Rust on PATH | no | `command -v rustc` |
| Python 3 on PATH | yes | `command -v python3` |

Inference, one sentence per line: the two existing sweep binaries in `session-output/hugepage-chase/`
were built earlier and still run, but nothing on this shell's path can rebuild them, and the one tool
that reads a raw event is absent. A hypervisor often hides the vendor performance unit from a guest,
so the raw route may be closed by the platform as well as by the missing tool.

## Why a Python timing arm is refused before it runs

A pointer chase in Python measures the interpreter. Each access carries tens of nanoseconds of
bytecode overhead, and a page walk on a 4 KiB page costs on the order of the same scale, so the arm
would carry the noise it was built to isolate. This paper therefore refuses a Python arm in advance,
rather than running it and calling the result a probe.

## The timing probe, falsifiers stated before any run

If a native build becomes available, the fallback is a timing probe on the same 64 MiB buffer, two
arms (4 KiB pages and 2 MiB huge pages, the same random permutation of lines, the same line count).
The figures below are written now and are not measured.

- **F1 (the walk is dominant).** For page walks to be the main cost of a random chase on this guest,
  the nanoseconds per access with 2 MiB pages must sit at least 15 percent below the 4 KiB arm. Source
  of the 15 percent: an estimate from the scale of a walk against a DRAM access, not a measured value.
  The threshold is open to argument before the run, and this paper names it so that argument happens
  first. If the gap is under 5 percent, the walk is not dominant at this footprint on this guest, and the
  page-walk candidate is refuted for this pattern.
- **F2 (the huge arm is real).** The huge arm is void unless `AnonHugePages` in
  `/proc/self/smaps_rollup` reads at least 60,000 kB during the run. The last sweep confirmed 65,536 kB,
  but a silent fallback to 4 KiB pages would make F1 read a gap of zero for the wrong reason. A void
  arm is reported as void, not as a fire.
- **F3 (the walk model predicts the sweep too).** Under the same two arms, a sequential sweep should
  show a smaller relative gap than the random chase, because hardware prefetch hides walks on a
  predictable stride. If the sequential gap is equal to or larger than the random gap, the walk model is
  wrong about what hides it, and the probe's reading cannot be attributed to walks.

Horizon: this guest, this kernel, one 64 MiB buffer, the two patterns above. Assumptions: the timing
measures the access and not the loop; the permutation is the same across arms; the huge arm is granted.
Confidence: low on F1's threshold, moderate on F2, moderate on F3. The probe does not measure
`cache-misses` and does not reopen the stencil claim.

## What would settle it

A raw vendor event that counts page-table walks directly would test the cause without a timing model.
That event is the sweep paper's own next door. Two gates stand before it, and both are the maintainer's word:

1. Name the raw event, or grant a compiler and a performance tool so the lap can read the unit.
2. Confirm the hypervisor passes the performance unit through. If it does not, no raw event is readable
   on this guest and the timing probe above is the only route.

## Status of this lap

- No probe ran. The timing arms were not built, and no ratio is claimed in this paper.
- The sweep binaries in `session-output/hugepage-chase/` were not re-run, since the sweep paper already
  holds their four-run readings.

## Reproduce the blockage

```sh
uname -r; cat /sys/kernel/mm/transparent_hugepage/enabled /sys/kernel/mm/transparent_hugepage/defrag
cat /proc/sys/vm/nr_hugepages; grep -m1 'model name' /proc/cpuinfo; grep -m1 -o hypervisor /proc/cpuinfo
for t in perf cc gcc clang zig rustc python3; do printf '%s: ' "$t"; command -v "$t" || echo none; done
```

The numbers are free: the guest's THP mode, the reserved count, and the toolchain on the path can all
change between sessions. Run the command rather than trusting the table above.
