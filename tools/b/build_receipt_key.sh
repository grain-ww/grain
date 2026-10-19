#!/bin/sh
# tools/b/build_receipt_key.sh -- the content key for one build's declared inputs.
#
# WHY THIS EXISTS. The shared build cache may reuse a compiled binary only when every declared
# input is identical. Zig reads file content and ignores the mode bit, so a chmod alone would
# leave the binary identical and reuse it silently. This writer folds the file mode into the key
# itself, so an executable-bit change forces a miss at the receipt layer, where Zig cannot see it.
#
# WHAT IS KEYED: the source bytes (sha256), the mode bits read from the file, the flags string,
# the overlay bytes (sha256, or none), the compiler identity the caller declares, and the import
# closure: every relative `import` builtin string ending .zig, .zon or .rye that the source reaches,
# transitively, each keyed by its path relative to the source's directory and its bytes (sha256).
# WHY THE CLOSURE. The compiler reads every imported file, so a key over the root alone reuses a
# stale binary when only a sibling changes (REDS %840 -- reproduced: the key held and the proof ran
# the old code). A missing import, an absolute import, or a closure past max_closure files is a
# named refusal, because a key over an incomplete set would reuse exactly as silently.
# The path of the source itself is NOT keyed, so identical bytes at another checkout path share one
# key; dependency paths are relative to the source directory for the same reason.
# Comment mentions of an import are read too. That over-keys (an extra miss), never under-keys.
#
# USAGE: sh tools/b/build_receipt_key.sh <source> <flags> <overlay-or-dash> <compiler-id>
# PRINTS: the canonical record, one field per line, then key=<sha256 of that record>.
set -eu

# invariant: exactly four arguments; a short call is a named error, never a guessed key.
if [ "$#" -ne 4 ]; then
  echo "error=usage expected=4_args got=$#" >&2
  exit 2
fi
src=$1
flags=$2
overlay=$3
compiler=$4

# invariant: the source is a readable regular file; a missing source has no key to give.
if [ ! -f "$src" ]; then
  echo "error=source_missing path=$src" >&2
  exit 2
fi

src_sha=$(sha256sum "$src" | cut -d' ' -f1)
# why ls -l: the permission string is read from the file itself, so no caller can declare it
# wrongly. ls -l prints the same ten-column form on GNU and BSD, where stat -c does not travel.
mode=$(ls -ld "$src" | cut -c1-10)

if [ "$overlay" = "-" ]; then
  ovl_sha=none
else
  # invariant: a named overlay must exist; an overlay that vanished would key as none and reuse.
  if [ ! -f "$overlay" ]; then
    echo "error=overlay_missing path=$overlay" >&2
    exit 2
  fi
  ovl_sha=$(sha256sum "$overlay" | cut -d' ' -f1)
fi

# invariant: the import closure is walked whole or refused; a sampled closure would key as complete.
# why max_closure: 256 is a power of two, the same ceiling the tree's own flat rooms carry, so a
# closure that large is a named refusal rather than a key that silently stops short.
max_closure=256
root_dir=$(cd "$(dirname "$src")" && pwd -P)
root_abs="$root_dir/$(basename "$src")"
seen="|$root_abs|"
deps=""
members=1
set -- "$root_abs"
while [ "$#" -gt 0 ]; do
  cur=$1
  shift
  cur_dir=$(dirname "$cur")
  # why awk: a `while match` loop reads every import string on a line, not only the first.
  for imp in $(awk '{ s = $0; while (match(s, /@import\("[^"]+"\)/)) { print substr(s, RSTART + 9, RLENGTH - 11); s = substr(s, RSTART + RLENGTH) } }' "$cur"); do
    case "$imp" in
      *.zig|*.zon|*.rye) ;;
      *) continue ;;
    esac
    case "$imp" in
      /*) echo "error=import_absolute import=$imp in=$cur" >&2; exit 2 ;;
    esac
    if [ ! -f "$cur_dir/$imp" ]; then
      echo "error=import_missing import=$imp in=$cur" >&2
      exit 2
    fi
    resolved_dir=$(cd "$cur_dir" && cd "$(dirname "$imp")" && pwd -P)
    resolved="$resolved_dir/$(basename "$imp")"
    case "$seen" in
      *"|$resolved|"*) continue ;;
    esac
    seen="$seen$resolved|"
    members=$((members + 1))
    if [ "$members" -gt "$max_closure" ]; then
      echo "error=closure_over_bound max=$max_closure" >&2
      exit 2
    fi
    deps="$deps$resolved
"
    set -- "$@" "$resolved"
  done
done

# why sorted: the walk visits files in discovery order, and a key must not depend on which import
# line a file was reached by. Paths are relative to the source directory, so a checkout that moves
# keeps its key, the same reason the source's own path is not keyed.
dep_block=$(printf '%s' "$deps" | sed '/^$/d' | sort | while IFS= read -r d; do
  rel=${d#"$root_dir/"}
  printf 'dep=%s:%s\n' "$rel" "$(sha256sum "$d" | cut -d' ' -f1)"
done)

record="src=$src_sha
mode=$mode
flags=$flags
overlay=$ovl_sha
compiler=$compiler
closure=$((members - 1))"
if [ -n "$dep_block" ]; then
  record="$record
$dep_block"
fi

printf '%s\n' "$record"
key=$(printf '%s\n' "$record" | sha256sum | cut -d' ' -f1)
echo "key=$key"
