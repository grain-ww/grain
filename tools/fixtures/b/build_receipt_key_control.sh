#!/bin/sh
# tools/fixtures/b/build_receipt_key_control.sh -- prove the receipt key from both sides.
#
# Every refusal is planted and then lifted, so a check that always answers the same way cannot
# pass. A key that ignored the mode would read silent_reuse on the executable-bit row; the
# planted mutant below proves the scan would catch that. Each leg prints ok or fail by name.
#
# USAGE: sh tools/fixtures/b/build_receipt_key_control.sh
set -eu

here=$(cd "$(dirname "$0")/../../.." && pwd -P)
writer="$here/tools/b/build_receipt_key.sh"
scan="$here/tools/fixtures/b/build_receipt_key_scan.sh"
pen=$(mktemp -d "${TMPDIR:-/tmp}/receipt-key-control.XXXXXX")
trap 'rm -rf "$pen"' EXIT INT TERM
fails=0

# The plant law (REDS %519): a sed that matches nothing copies the writer byte for byte, and the
# mutant then reads as the healthy writer. plant_write names that case instead of passing it.
. "$here/tools/fixtures/p/plant.sh"

# leg NAME STATUS -- STATUS is the exit code of the check that just ran; 0 is ok, anything else fails.
leg() {
  if [ "$2" -eq 0 ]; then
    echo "leg=$1 result=ok"
  else
    echo "leg=$1 result=fail"
    fails=$((fails + 1))
  fi
}

key_of() {
  sh "$writer" "$1" "$2" "$3" "$4" | sed -n 's/^key=//p'
}

# invariant: a file at two paths holding identical bytes keys identically; the path is not keyed.
mkdir "$pen/a" "$pen/b"
printf 'x\n' > "$pen/a/f.zig"
printf 'x\n' > "$pen/b/f.zig"
chmod 644 "$pen/a/f.zig" "$pen/b/f.zig"
ka=$(key_of "$pen/a/f.zig" "-O Debug" - "zig")
kb=$(key_of "$pen/b/f.zig" "-O Debug" - "zig")
if [ "$ka" = "$kb" ] && [ -n "$ka" ]; then leg path_independent 0; else leg path_independent 1; fi

# invariant: the same inputs key the same on a second read; a nondeterministic key is no key.
kc=$(key_of "$pen/a/f.zig" "-O Debug" - "zig")
if [ "$ka" = "$kc" ]; then leg repeat_stable 0; else leg repeat_stable 1; fi

# invariant: the executable bit moves the key; if it does not, chmod alone reuses a binary.
chmod 755 "$pen/a/f.zig"
kd=$(key_of "$pen/a/f.zig" "-O Debug" - "zig")
if [ "$ka" != "$kd" ]; then leg mode_forces_miss 0; else leg mode_forces_miss 1; fi
chmod 644 "$pen/a/f.zig"

# invariant: a wrong argument count is a named error with exit 2, never a key.
set +e
sh "$writer" "$pen/a/f.zig" "-O Debug" >/dev/null 2>"$pen/err"
rc=$?
set -e
if [ "$rc" -eq 2 ] && grep -q 'error=usage' "$pen/err"; then leg usage_refuses 0; else leg usage_refuses 1; fi

# invariant: a missing source is a named error with exit 2, never a key over nothing.
set +e
sh "$writer" "$pen/nope.zig" "-O Debug" - "zig" >/dev/null 2>"$pen/err"
rc=$?
set -e
if [ "$rc" -eq 2 ] && grep -q 'error=source_missing' "$pen/err"; then leg missing_source_refuses 0; else leg missing_source_refuses 1; fi

# invariant: the scan reads all six mutations as a miss on the real writer.
out=$(sh "$scan")
if [ "$(printf '%s\n' "$out" | grep -c 'result=miss')" -eq 6 ]; then leg scan_all_miss 0; else leg scan_all_miss 1; fi

# invariant: a writer that drops the mode reads silent_reuse on the executable-bit row, so the
# scan would catch a regression. The mutant is the real writer with the stat line removed.
if plant_write "$writer" "$pen/mutant.sh" "s|^mode=\$(ls -ld.*|mode=0|" mode_drop; then
  if KEY_WRITER="$pen/mutant.sh" sh "$scan" | grep -q 'executable_bit result=silent_reuse'; then leg mode_drop_is_caught 0; else leg mode_drop_is_caught 1; fi
else
  leg mode_drop_plant_landed 1
fi

echo "fails=$fails"
[ "$fails" -eq 0 ] && echo verdict=ok || { echo verdict=fail; exit 1; }
