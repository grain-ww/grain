# The huge-page sweep: the falsifier fired, and the page walk is a candidate cause

**Status:** Research result -- the huge-page sequential sweep the 20261009 calibration named as its next door
**Room:** research for understanding -- nothing here is bound by a witness; the numbers are free and re-readable by the command in Reproduce
**Date:** 2026-10-11, clock `20261011.074228`
**Kin:** [the generic miss counter reads a fraction](20261009/20261009-222800_the-generic-miss-counter-reads-a-fraction.md) - [the generic counter reads high on a random chase](20261009/20261009-231436_the-generic-counter-reads-high-on-a-random-chase.md) - [the calibration witness](../../tools/c/cache_miss_calibrate_witness.rish)

## What this paper asks

The generic `cache-misses` counter has failed its calibration twice. On a 64 MiB sequential sweep it reads a few percent of the line fills the sweep must cause. The sweep touches 1,048,576 lines of 64 bytes, so a demand-miss counter should read near that figure, and it reads 90 to 340 thousand on this guest.

The open question is whether the shortfall is the counter's own limit, or whether the 4 KiB page walks the sweep forces count against the counter in some way that huge pages would remove.

## The falsifier, stated before the run

The previous fruit named the next door: a huge-page sequential sweep, read against the 500 to 2000 permille band the calibration note set, over one million expected fills. The falsifier, written before this run:

- **If the huge-page arm reads inside 500 to 2000 permille**, the generic event is usable as a fill proxy once page size is controlled, and the stencil claim may reopen as a candidate.
- **If it reads below 500 permille with huge pages confirmed in use**, the generic counter stays unusable as a fill proxy on this guest, whatever the page size.

## Method

Two binaries in `session-output/hugepage-chase/`, untracked scratch, built on `20261009`:

- `sweep_control` maps the 64 MiB buffer ordinarily, with 4 KiB pages.
- `sweep_huge` maps the same buffer 2 MiB aligned and calls `madvise(MADV_HUGEPAGE)`. It reads `/proc/self/smaps_rollup` after the sweep and prints the anonymous huge-page kilobytes, so a silent fallback to 4 KiB shows in the same line.

Both time one sequential pass over 1,048,576 lines through the self-count `cache-misses` event, and print permille of the expected fill count. The host has transparent huge pages set to `madvise`, so the request is the only route to huge pages here.

## Result

Four runs per arm, one run after another on the same guest, 2026-10-11:

| Arm | Run 1 | Run 2 | Run 3 | Run 4 | Huge kB reported |
|---|---|---|---|---|---|
| 4 KiB (control) | 277 | 339 | 220 | 308 | 0 |
| 2 MiB requested | 94 | 97 | 90 | 98 | 65,536 |

Permille is misses over 1,048,576 expected fills. Both arms sit below the 500 band on every run.

## Reading

- **Observation.** The huge-page arm really ran on huge pages: 65,536 kB of anonymous huge memory, every run. The control arm ran on none.
- **Observation.** Huge pages cut the counter's reading by about three times, 220 to 339 down to 90 to 98 permille.
- **Inference.** The falsifier's second branch holds. The counter stays below 500 permille with huge pages in use, so the generic event is not a fill counter on this guest at either page size.
- **Inference, candidate only.** The three-fold drop fits the page-walk cause the calibration note proposed: fewer page-table walks under huge pages means fewer counted references. This run does not isolate that. A TLB-specific event would be the test, and this guest does not expose one through the generic path.

## What this does not say

- It does not measure the prefetcher. A hardware prefetcher that fills lines a demand miss never sees would also keep the count low, and the sweep cannot separate that from the page-walk story.
- Four runs per arm give a range, not a confidence interval. The control range (220 to 339) and the huge range (90 to 98) do not overlap, so the three-fold gap is not noise at this count, but the magnitude is only as good as four runs.
- It does not reopen the stencil claim. The falsifier's second branch closed that door on this guest for the generic event.

## Next door

A raw vendor event that separates page walks from demand misses, named by the maintainer, is the only route that tests the page-walk cause directly. Without it, the generic counter stays a relative signal at best, and a stencil claim waits on that word.

## Reproduce

```sh
cd session-output/hugepage-chase
for i in 1 2 3 4; do ./sweep_control | tail -1; ./sweep_huge | tail -1; done
```

The numbers are free: the guest's THP mode, the counter's reading, and the kernel's huge-page reporting can all move between runs and hosts. Run the command rather than trusting the table above.

## Confidence and horizon

- **Horizon:** this guest, this kernel, the generic `cache-misses` event, the 64 MiB sequential pattern.
- **Confidence:** high that the generic event stays below 500 permille on this guest with or without huge pages (eight of eight readings, both arms); low on the page-walk cause, which is a candidate.
- **Falsifier for the page-walk cause:** a TLB-miss raw event that reads near the sweep's page-walk count with huge pages on and off would confirm it; a flat TLB reading across both arms would refute it.
