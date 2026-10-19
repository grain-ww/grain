#!/bin/sh
# tools/b/build_cached.sh -- reuse a compiled binary on an identical content key, and run the proof either way.
#
# WHY THIS EXISTS. tools/b/build_receipt_key.sh keys a build's declared inputs and proves that six
# changes each move the key. Nothing yet READ that key to skip a compile. This consumer does: on a
# key hit it runs the stored binary without calling the compiler; on a miss it compiles once and
# stores the result under the key. The owed proof -- executing the binary -- runs on both paths, so
# a skipped compile never skips the check.
#
# WHAT IS NOT CONSUMED. An overlay is keyed by the writer but this consumer does not feed one to the
# compiler. A keyed input the compiler never reads would reuse silently, so an overlay is REFUSED
# here by name rather than accepted and ignored.
#
# USAGE: sh tools/b/build_cached.sh <source> <flags> <overlay-or-dash> <compiler-id> <store-dir>
# PRINTS: key=, cache=hit|miss, compiled=yes|no, binary=, proof_exit=, verdict=
# EXITS: 0 when the proof exits 0, 1 when the proof exits nonzero, 2 on a named refusal.
set -eu

here=$(cd "$(dirname "$0")/../.." && pwd -P)
zig="$here/vendor/zig-toolchain/zig"
writer="$here/tools/b/build_receipt_key.sh"

# invariant: exactly five arguments; a short call is a named error, never a guessed build.
if [ "$#" -ne 5 ]; then
  echo "error=usage expected=5_args got=$#" >&2
  exit 2
fi
src=$1
flags=$2
overlay=$3
compiler=$4
store=$5

# invariant: an overlay is refused, because this consumer would key it without compiling it.
if [ "$overlay" != "-" ]; then
  echo "error=overlay_unsupported detail=this consumer does not feed an overlay to the compiler" >&2
  exit 2
fi

# invariant: the source is a readable file and the toolchain is present before the store is touched.
if [ ! -f "$src" ]; then
  echo "error=source_missing path=$src" >&2
  exit 2
fi
if [ ! -x "$zig" ]; then
  echo "error=no_toolchain zig=$zig" >&2
  exit 2
fi

# why an absolute source: the compiler runs from a scratch directory, so a relative path would
# name a different file there.
src_dir=$(cd "$(dirname "$src")" && pwd -P)
abs_src="$src_dir/$(basename "$src")"

record=$(sh "$writer" "$abs_src" "$flags" - "$compiler")
key=$(printf '%s\n' "$record" | tail -n 1 | sed 's/^key=//')

mkdir -p "$store"
# why canonical: the compile runs inside a scratch directory, so a relative store would resolve
# against that directory and publish a cell with no binary in it. An absolute store names one place.
store=$(cd "$store" && pwd -P)
cell="$store/$key"
bin="$cell/prog"

if [ -x "$bin" ]; then
  cache=hit
  compiled=no
else
  cache=miss
  compiled=yes
  # why a scratch directory: a half-written binary must never land at the key, so the compile
  # writes beside the store and moves in only when it succeeds.
  scratch="$store/.scratch.$key.$$"
  mkdir -p "$scratch"
  # invariant: the compile succeeds before anything is published under the key.
  if ! (cd "$scratch" && ZIG_LOCAL_CACHE_DIR="$scratch/zc" "$zig" build-exe "$abs_src" $flags "-femit-bin=$scratch/prog" >/dev/null 2>&1); then
    rm -rf "$scratch"
    echo "error=compile_failed key=$key" >&2
    exit 2
  fi
  rm -rf "$scratch/zc"
  # why the existence test: a second writer may have published this key while we compiled, and
  # the first published copy stands rather than being replaced.
  if [ -d "$cell" ]; then
    rm -rf "$scratch"
  else
    mv "$scratch" "$cell"
  fi
fi

# the owed proof: the binary runs on both paths, so a hit still answers for itself.
proof=0
"$bin" >/dev/null 2>&1 || proof=$?

echo "$record"
echo "key=$key"
echo "cache=$cache"
echo "compiled=$compiled"
echo "binary=$bin"
echo "proof_exit=$proof"
if [ "$proof" -eq 0 ]; then
  echo "verdict=proved"
  exit 0
fi
echo "verdict=proof_failed"
exit 1
