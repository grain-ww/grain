#!/bin/sh
# rishi_fusion_measure_scan.sh -- where does a Rishi build's wall time live, phase by phase?
#
# WHY THIS EXISTS. The Bakery spine's first item (construction/ITINERARY.md, Bakery section) asks to
# instrument discovery, dependency closure, compilation, proof, and receipt writing, and to measure
# where repeated work actually lives BEFORE any cache changes. This is that measurement, bounded and
# replayable, on a throwaway pen. It answers in milliseconds per phase, and it says plainly which
# phases it cannot isolate from outside.
#
# WHAT IT TIMES, each as one wall-clock span read from the one host clock:
#   rish_startup  -- `rishi/bin/rishi run` on a no-op script: interpreter start and discovery of one file
#   compile_cold  -- zig build-exe of a unique source into a PRIVATE global cache (every byte a miss)
#   compile_warm  -- the same bytes rebuilt against that cache (every byte a hit)
#   witness_wall  -- one whole witness, tools/b/basin_witness.rish, which builds its own binary first
#
# WHAT IT CANNOT ISOLATE, and says so. Dependency closure and receipt writing happen inside `rishi`
# and inside the witness, with no timing hook, so they are reported as `not_isolated` rather than
# guessed. A phase that cannot be read from outside is not a phase with zero cost.
#
# THE PRIVATE CACHE IS ON PURPOSE. The shared ~/.cache/zig holds hundreds of thousands of entries
# written by eight ships at once, so a timing taken there reads peers' work. This scan never touches it.
#
# Usage: sh tools/fixtures/b/rishi_fusion_measure_scan.sh
# Output: key=value lines and a final verdict. Exits 0 when every timed phase read a positive span
# and the warm compile ran no slower than the cold one, 1 otherwise, 2 on setup failure.

ROOT=$(cd "$(dirname "$0")/../../.." && pwd -P) || exit 2
ZIG="$ROOT/vendor/zig-toolchain/zig"
RISHI="$ROOT/rishi/bin/rishi"
[ -x "$ZIG" ] || { echo "verdict=no_toolchain zig=$ZIG"; exit 2; }
[ -x "$RISHI" ] || { echo "verdict=no_rishi rishi=$RISHI"; exit 2; }

PEN="$ROOT/.lap/fusion-measure.$$"
PRIV="$PEN/global-cache"
mkdir -p "$PEN/src" "$PRIV" || { echo "verdict=no_pen"; exit 2; }
trap 'rm -rf "$PEN"' EXIT

# Milliseconds between two nanosecond stamps. Integer arithmetic only; a span under 1ms reads 0.
ms() { echo $(( ($2 - $1) / 1000000 )); }
now() { date +%s%N; }

# A no-op Rishi script, so rish_startup measures start-up and discovery rather than any work.
printf 'let noop = "measure"\n' > "$PEN/src/noop.rish"

# A unique body per run, so no earlier run's cache entry can answer for this one.
UNIQ=$(date +%s%N)
printf 'const std = @import("std");\npub fn main() void { std.debug.print("measure %s {d}\\n", .{7}); }\n' "$UNIQ" > "$PEN/src/x.zig"

t0=$(now); "$RISHI" run "$PEN/src/noop.rish" >/dev/null 2>&1; rc_startup=$?; t1=$(now)
startup_ms=$(ms "$t0" "$t1")

build() {
    # $1 output name. Built inside the pen; private global cache; local cache beside the source.
    (cd "$PEN/src" && ZIG_GLOBAL_CACHE_DIR="$PRIV" ZIG_LOCAL_CACHE_DIR="$PEN/src/.zc" "$ZIG" build-exe x.zig "-femit-bin=$1" >/dev/null 2>&1)
}

t2=$(now); build x_cold; rc_cold=$?; t3=$(now)
cold_ms=$(ms "$t2" "$t3")

t4=$(now); build x_warm; rc_warm=$?; t5=$(now)
warm_ms=$(ms "$t4" "$t5")

t6=$(now); (cd "$ROOT" && "$RISHI" run tools/b/basin_witness.rish </dev/null >/dev/null 2>&1); rc_witness=$?; t7=$(now)
witness_ms=$(ms "$t6" "$t7")

echo "rish_startup_ms=$startup_ms rc=$rc_startup"
echo "compile_cold_ms=$cold_ms rc=$rc_cold"
echo "compile_warm_ms=$warm_ms rc=$rc_warm"
echo "witness_wall_ms=$witness_ms rc=$rc_witness"
echo "dependency_closure=not_isolated -- no timing hook inside rishi discovery"
echo "receipt_writing=not_isolated -- lives inside the witness with no timing hook"

if [ "$rc_cold" -ne 0 ] || [ "$rc_warm" -ne 0 ]; then
    echo "verdict=build_failed -- a timed compile did not exit 0, so its span is not a reading"
    exit 2
fi
if [ "$cold_ms" -le 0 ]; then
    echo "verdict=no_cold_span -- the cold compile read 0ms, so the reading cannot be trusted"
    exit 2
fi
if [ "$warm_ms" -le "$cold_ms" ]; then
    echo "verdict=measured -- the warm compile ran no slower than the cold one"
    exit 0
fi
echo "verdict=warm_slower -- the warm compile read longer than the cold one; the cache is not carrying its weight"
exit 1
