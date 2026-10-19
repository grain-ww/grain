#!/bin/sh
# tools/fixtures/b/build_cached_control.sh -- prove the build consumer on real compiles in a throwaway pen.
#
# Every leg is a planted input and an expected answer. A leg that reads the wrong answer counts as
# a failure, and the verdict says so by name, because a witness that only proves the passing
# direction cannot be told from a bypass. The pen is a mktemp directory, removed on exit; the
# compiler uses its own default global cache, which is the sharing being measured.
#
# USAGE: sh tools/fixtures/b/build_cached_control.sh
# PRINTS: one leg_ok or leg_fail line per leg, then control_legs, control_failed, control_verdict.
set -eu

here=$(cd "$(dirname "$0")/../../.." && pwd -P)
consumer="$here/tools/b/build_cached.sh"
pen=$(mktemp -d "${TMPDIR:-/tmp}/build-cached-control.XXXXXX")
trap 'rm -rf "$pen"' EXIT INT TERM

# invariant: the consumer exists before the control reads it; a missing consumer is a named error.
if [ ! -f "$consumer" ]; then
  echo "error=consumer_missing path=$consumer" >&2
  exit 2
fi

legs=0
failed=0

# expect NAME GOT WANT -- one leg, counted, printed beside its own answer.
expect() {
  legs=$((legs + 1))
  if [ "$2" = "$3" ]; then
    echo "leg_ok: $1 (got $2)"
  else
    failed=$((failed + 1))
    echo "leg_fail: $1 (got $2, want $3)"
  fi
}

# field OUTPUT NAME -- one key=value field out of the consumer's printed answer.
field() {
  printf '%s\n' "$1" | sed -n "s/^$2=//p" | tail -n 1
}

# build SRC FLAGS OVERLAY COMPILER STORE -- sets OUT to the answer, ERR to its refusal text, RC to the exit code.
build() {
  OUT=$(sh "$consumer" "$1" "$2" "$3" "$4" "$5" 2>"$pen/err.txt") && RC=0 || RC=$?
  ERR=$(cat "$pen/err.txt")
}

store="$pen/store"
mkdir -p "$pen/a" "$pen/b"
printf 'pub fn main() void { }\n' > "$pen/a/x.zig"
cp "$pen/a/x.zig" "$pen/b/x.zig"

# leg 1: a first build of new bytes misses and compiles once.
build "$pen/a/x.zig" "" - zig-0.16 "$store"
expect "first build misses the key" "$(field "$OUT" cache)" miss
expect "first build compiles" "$(field "$OUT" compiled)" yes
expect "first build proves" "$(field "$OUT" verdict)" proved
key_a=$(field "$OUT" key)

# leg 2: identical bytes at another checkout path hit the key and skip the compile.
build "$pen/b/x.zig" "" - zig-0.16 "$store"
expect "same bytes at another path hit the key" "$(field "$OUT" cache)" hit
expect "a hit does not compile" "$(field "$OUT" compiled)" no
expect "a hit still proves" "$(field "$OUT" verdict)" proved
expect "another path keys identically" "$(field "$OUT" key)" "$key_a"

# leg 3: the same path again also hits.
build "$pen/a/x.zig" "" - zig-0.16 "$store"
expect "same path again hits" "$(field "$OUT" cache)" hit

# leg 4: a changed source byte misses and keys differently.
printf 'pub fn main() void { }\n// changed\n' > "$pen/a/x.zig"
build "$pen/a/x.zig" "" - zig-0.16 "$store"
expect "changed source misses" "$(field "$OUT" cache)" miss
key_src=$(field "$OUT" key)
expect "changed source keys differently" "$([ "$key_src" != "$key_a" ] && echo yes || echo no)" yes

# leg 5: a changed flag misses, with the source held identical to leg 4.
build "$pen/a/x.zig" "-O ReleaseSmall" - zig-0.16 "$store"
expect "changed flags miss" "$(field "$OUT" cache)" miss

# leg 6: a changed executable bit misses with identical bytes. Stored at 644 first, so the miss
# is the mode alone.
build "$pen/a/x.zig" "" - zig-0.16 "$store"
expect "unchanged mode hits its stored key" "$(field "$OUT" cache)" hit
chmod +x "$pen/a/x.zig"
build "$pen/a/x.zig" "" - zig-0.16 "$store"
expect "changed executable bit misses" "$(field "$OUT" cache)" miss
expect "executable bit moves the key alone" "$([ "$(field "$OUT" key)" != "$key_src" ] && echo yes || echo no)" yes
chmod -x "$pen/a/x.zig"

# leg 7: a changed declared compiler identity misses, with bytes, mode and flags unchanged.
build "$pen/a/x.zig" "" - zig-0.17 "$store"
expect "changed compiler identity misses" "$(field "$OUT" cache)" miss

# leg 8: an overlay is refused by name, never keyed and ignored.
build "$pen/a/x.zig" "" "$pen/a/x.zig" zig-0.16 "$store" || true
expect "an overlay is refused with exit 2" "$RC" 2
expect "the refusal names the overlay" "$(printf '%s\n' "$ERR" | sed -n 's/^error=\([a-z_]*\).*/\1/p')" overlay_unsupported

# leg 9: a failing program still runs its proof on a hit, and the hit reports the same failure.
printf 'pub fn main() void { @panic("red"); }\n' > "$pen/a/red.zig"
build "$pen/a/red.zig" "" - zig-0.16 "$store" || true
expect "a failing program misses first" "$(field "$OUT" cache)" miss
expect "a failing program reports its proof" "$(field "$OUT" verdict)" proof_failed
red_exit=$(field "$OUT" proof_exit)
build "$pen/a/red.zig" "" - zig-0.16 "$store" || true
expect "a failing hit does not compile" "$(field "$OUT" compiled)" no
expect "a failing hit runs the proof again" "$(field "$OUT" proof_exit)" "$red_exit"
expect "a failing hit reports the failure" "$(field "$OUT" verdict)" proof_failed

# leg 10: a missing source is a named refusal before the store is touched.
build "$pen/a/none.zig" "" - zig-0.16 "$store" || true
expect "a missing source refuses with exit 2" "$RC" 2
expect "the refusal names the missing source" "$(printf '%s\n' "$ERR" | sed -n 's/^error=\([a-z_]*\).*/\1/p')" source_missing

# leg 11: a relative store still publishes a runnable binary. The compile runs inside a scratch
# directory, so a relative store used to resolve against that directory and publish a cell with no prog.
here_cwd=$(pwd -P)
cd "$pen"
build "$pen/a/x.zig" "" - zig-0.16 rel-store
cd "$here_cwd"
expect "a relative store misses first" "$(field "$OUT" cache)" miss
expect "a relative store proves its binary" "$(field "$OUT" verdict)" proved

# The import closure (fourteen legs). The compiler reads every imported sibling, so the key must hold
# each one. Before the closure was keyed, changing only the sibling reused the stale binary and its
# proof ran the old code (REDS %840, reproduced in a pen before the repair).
mkdir -p "$pen/imp"
printf 'const h = @import("helper.zig");\npub fn main() void {\n    if (h.code() != 0) @panic("red");\n}\n' > "$pen/imp/main.zig"
printf 'pub fn code() u8 {\n    return 0;\n}\n' > "$pen/imp/helper.zig"
build "$pen/imp/main.zig" "" - zig-0.16 "$store"
expect "an imported sibling misses on its first build" "$(field "$OUT" cache)" miss
expect "the closure names the one sibling" "$(field "$OUT" closure)" 1
key_imp=$(field "$OUT" key)
printf 'pub fn code() u8 {\n    return 1;\n}\n' > "$pen/imp/helper.zig"
build "$pen/imp/main.zig" "" - zig-0.16 "$store" || true
expect "changing only the sibling misses" "$(field "$OUT" cache)" miss
expect "the sibling change moves the key" "$([ "$(field "$OUT" key)" != "$key_imp" ] && echo yes || echo no)" yes
expect "the changed sibling's proof fails on its own" "$(field "$OUT" verdict)" proof_failed

# A transitive import is keyed too -- a change two files deep misses.
printf 'const d = @import("deep.zig");\npub fn code() u8 {\n    return d.value();\n}\n' > "$pen/imp/helper.zig"
printf 'pub fn value() u8 {\n    return 0;\n}\n' > "$pen/imp/deep.zig"
build "$pen/imp/main.zig" "" - zig-0.16 "$store"
expect "the transitive closure names two siblings" "$(field "$OUT" closure)" 2
printf 'pub fn value() u8 {\n    return 1;\n}\n' > "$pen/imp/deep.zig"
build "$pen/imp/main.zig" "" - zig-0.16 "$store" || true
expect "a change two imports deep misses" "$(field "$OUT" cache)" miss
expect "the deep change fails its proof" "$(field "$OUT" verdict)" proof_failed

# A missing import is a named refusal before any key or store is written.
rm -f "$pen/imp/deep.zig"
build "$pen/imp/main.zig" "" - zig-0.16 "$store" || true
expect "a missing import refuses with exit 2" "$RC" 2
expect "the refusal names the missing import" "$(printf '%s\n' "$ERR" | sed -n 's/^error=\([a-z_]*\).*/\1/p')" import_missing

# The closure bound, from both sides. c0 reaches 256 siblings (257 files) and refuses; c1
# reaches 255 (256 files, exactly the bound) and still walks free and proves.
mkdir -p "$pen/chain"
k=0
while [ "$k" -le 256 ]; do
  next=$((k + 1))
  if [ "$k" -eq 0 ]; then
    printf 'const n = @import("c%d.zig");\npub fn main() void {\n    _ = n;\n}\n' "$next" > "$pen/chain/c$k.zig"
  elif [ "$k" -lt 256 ]; then
    printf 'const n = @import("c%d.zig");\npub fn value() u8 {\n    return n.value();\n}\n' "$next" > "$pen/chain/c$k.zig"
  else
    printf 'pub fn value() u8 {\n    return 0;\n}\n' > "$pen/chain/c$k.zig"
  fi
  k=$((k + 1))
done
build "$pen/chain/c0.zig" "" - zig-0.16 "$store" || true
expect "one file past the closure bound refuses with exit 2" "$RC" 2
expect "the refusal names the closure bound" "$(printf '%s\n' "$ERR" | sed -n 's/^error=\([a-z_]*\).*/\1/p')" closure_over_bound
printf 'const n = @import("c2.zig");\npub fn main() void {\n    _ = n;\n}\n' > "$pen/chain/c1.zig"
build "$pen/chain/c1.zig" "" - zig-0.16 "$store"
expect "a closure of exactly the bound walks free" "$(field "$OUT" closure)" 255
expect "a closure of exactly the bound proves" "$(field "$OUT" verdict)" proved

echo "control_legs=$legs"
echo "control_failed=$failed"
if [ "$failed" -eq 0 ]; then
  echo "control_verdict=ok"
  exit 0
fi
echo "control_verdict=failed"
exit 1
