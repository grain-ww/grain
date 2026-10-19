#!/bin/sh
# tools/fixtures/b/build_receipt_key_scan.sh -- measure the receipt key against six mutations.
#
# Each row plants one change against a baseline and reads whether the key moved. A changed
# key is a miss, which is the correct answer for a changed input. An unchanged key on a
# changed input is a silent reuse, which is the fault this writer exists to prevent.
#
# The compiler and toolchain rows are declared identities, so they show the key moves when the
# caller declares a different identity. They do not prove a different toolchain produces a
# different binary; that needs a second toolchain on the pier, which this one does not have.
#
# USAGE: sh tools/fixtures/b/build_receipt_key_scan.sh
set -eu

here=$(cd "$(dirname "$0")/../../.." && pwd -P)
key_writer="${KEY_WRITER:-$here/tools/b/build_receipt_key.sh}"
pen=$(mktemp -d "${TMPDIR:-/tmp}/receipt-key-scan.XXXXXX")
trap 'rm -rf "$pen"' EXIT INT TERM

# invariant: the writer exists before the scan reads it; a missing writer is a named error.
if [ ! -f "$key_writer" ]; then
  echo "error=writer_missing path=$key_writer" >&2
  exit 2
fi

src="$pen/main.zig"
ovl="$pen/overlay.txt"
printf 'pub fn main() void {}\n' > "$src"
printf 'opt=debug\n' > "$ovl"
chmod 644 "$src"

key_of() {
  sh "$key_writer" "$1" "$2" "$3" "$4" | sed -n 's/^key=//p'
}

base=$(key_of "$src" "-O Debug" "$ovl" "zig-0.16-vendored")
echo "baseline=$base"

# mutation: source bytes change on the same path.
printf 'pub fn main() void { _ = 1; }\n' > "$src"
k=$(key_of "$src" "-O Debug" "$ovl" "zig-0.16-vendored")
printf 'mutation=source result=%s\n' "$([ "$k" = "$base" ] && echo silent_reuse || echo miss)"
printf 'pub fn main() void {}\n' > "$src"

# mutation: flags change.
k=$(key_of "$src" "-O ReleaseFast" "$ovl" "zig-0.16-vendored")
printf 'mutation=flag result=%s\n' "$([ "$k" = "$base" ] && echo silent_reuse || echo miss)"

# mutation: overlay bytes change.
printf 'opt=release\n' > "$ovl"
k=$(key_of "$src" "-O Debug" "$ovl" "zig-0.16-vendored")
printf 'mutation=overlay result=%s\n' "$([ "$k" = "$base" ] && echo silent_reuse || echo miss)"
printf 'opt=debug\n' > "$ovl"

# mutation: executable bit on the same bytes. The one Zig cannot see.
chmod 755 "$src"
k=$(key_of "$src" "-O Debug" "$ovl" "zig-0.16-vendored")
printf 'mutation=executable_bit result=%s\n' "$([ "$k" = "$base" ] && echo silent_reuse || echo miss)"
chmod 644 "$src"

# mutation: declared compiler identity changes.
k=$(key_of "$src" "-O Debug" "$ovl" "zig-0.17-candidate")
printf 'mutation=compiler_pin result=%s\n' "$([ "$k" = "$base" ] && echo silent_reuse || echo miss)"

# mutation: declared toolchain identity changes.
k=$(key_of "$src" "-O Debug" "$ovl" "zig-0.16-vendored+musl")
printf 'mutation=toolchain_pin result=%s\n' "$([ "$k" = "$base" ] && echo silent_reuse || echo miss)"
