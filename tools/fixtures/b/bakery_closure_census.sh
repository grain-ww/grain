#!/bin/sh
# tools/fixtures/b/bakery_closure_census.sh -- a read-only census of where compile, proof and receipt work is written.
#
# WHY THIS EXISTS. The Bakery card's first rung asks where repeated work actually lives before any
# cache is built: Rishi discovery, Rye/Zig compilation, proof execution, receipt writing. This
# census answers the STATIC half -- how many call sites exist, in which files, and whether anything
# in the tree reads the content-keyed cache. It does not time anything. The runtime half (wall time
# per phase, repeat counts per lap) is the next rung, and this script says so rather than guessing it.
#
# WHAT IT READS. Tracked-looking tool sources under tools/ only (no vendor/, no gratitude/, no
# session logs, no dated shelves). It writes nothing, starts nothing, and compiles nothing.
#
# WHAT IT PRINTS. key=value lines, one reading per line. Every count is free: nothing here gates a
# lap, so the numbers move as the tree grows. Re-run it rather than trusting a figure in prose.
#
#   sh tools/fixtures/b/bakery_closure_census.sh
#
# EXIT: always 0. A census reports; it does not refuse.

set -eu

here=$(cd "$(dirname "$0")/../../.." && pwd -P)
cd "$here"

# invariant: the census reads only under tools/, so a dated shelf or a vendored tree cannot inflate it.
scope=tools

# why an explicit pattern: a Zig invocation is a zig command word (`zig`, `$zig`, `"$zig"`,
# `./zig/zig`) followed by a compile verb. Matching the verb keeps `zig` in a path or a word from
# counting. Comment lines are dropped, so a sentence about the compiler is not a compile site.
zig_pattern='(zig|ZIG)"?[[:space:]]+(build-exe|build-lib|build-obj|test|build)([[:space:]]|$)'
zig_hits=$(grep -rE "$zig_pattern" --include='*.sh' --include='*.rish' "$scope" 2>/dev/null \
  | grep -vE '^[^:]*:[0-9]+:[[:space:]]*#' || true)
zig_files=$(printf '%s\n' "$zig_hits" | grep . | cut -d: -f1 | sort -u || true)
zig_file_count=$(printf '%s' "$zig_files" | grep -c . || true)

# why a count of sites and of files: a file calling the compiler twice is one place to cache, and two
# places to forget. The per-file site count is the number a cache consumer would have to reach.
zig_site_count=$(printf '%s' "$zig_hits" | grep -c . || true)

rishi_run_files=$(grep -rlE 'rishi(/bin/rishi)?[[:space:]]+run' --include='*.sh' "$scope" 2>/dev/null | wc -l | tr -d ' ')
rishi_run_sites=$(grep -rhE 'rishi(/bin/rishi)?[[:space:]]+run' --include='*.sh' "$scope" 2>/dev/null | grep -c . || true)
rish_sources=$(find "$scope" -name '*.rish' -type f | wc -l | tr -d ' ')

receipt_files=$(grep -rli 'receipt' --include='*.sh' --include='*.rish' "$scope" 2>/dev/null | wc -l | tr -d ' ')

# why a separate reading for the cache: the consumer, its own control and witness reference
# build_cached.sh. A production caller is any other reference, and this census never counts itself.
# Zero production callers means the cache exists and nothing reads it, which the next rung answers.
cache_refs_all=$(grep -rl 'build_cached' --include='*.sh' --include='*.rish' "$scope" 2>/dev/null | sort || true)
cache_refs_total=$(printf '%s' "$cache_refs_all" | grep -c . || true)
cache_refs_production=$(printf '%s\n' "$cache_refs_all" \
  | grep -vE '(^|/)(build_cached(_control|_witness)?\.(sh|rish)|build_cached_control\.sh|build_cached_witness\.rish|bakery_closure_census\.sh)$' \
  | grep -c . || true)

echo "census=bakery_closure_static"
echo "scope=$scope"
echo "zig_compile_files=$zig_file_count"
echo "zig_compile_sites=$zig_site_count"
if [ "$zig_file_count" -gt 0 ]; then
  printf '%s\n' "$zig_files" | sed 's/^/zig_file=/'
fi
echo "rishi_run_files=$rishi_run_files"
echo "rishi_run_sites=$rishi_run_sites"
echo "rish_sources=$rish_sources"
echo "receipt_mention_files=$receipt_files"
echo "cache_refs_total=$cache_refs_total"
echo "cache_production_callers=$cache_refs_production"
echo "timed=no -- static call sites only; per-phase wall time and repeat counts per lap are the next rung"
