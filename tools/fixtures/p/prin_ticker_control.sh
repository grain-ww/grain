#!/bin/sh
# tools/fixtures/p/prin_ticker_control.sh -- proves tools/fixtures/p/prin_ticker.sh from both sides.
#
#   sh tools/fixtures/p/prin_ticker_control.sh
#
# The ticker is a display loop, so only its `once` mode can be checked to the end: it shows one
# verse line and exits. Three legs answer for it. A verse file holding comments alone must REFUSE
# with exit 1 and name the empty set on stderr. A verse file holding one planted line must WELCOME
# with exit 0 and show that line as 1/1. The live verse file must welcome with exit 0 in `once`
# mode. Each leg prints its own verdict, and the control prints control_verdict last, so a witness
# can hold the named legs rather than the exit alone.

set -u

ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
cd "$ROOT" || exit 1

# A throwaway pen keeps the planted verse files out of the tree. The trap removes it on any exit.
pen=$(mktemp -d "${TMPDIR:-/tmp}/prin_ticker_pen.XXXXXX") || exit 1
trap 'rm -rf "$pen"' EXIT

printf '# comments only, no verse\n\n' > "$pen/empty.txt"
printf 'a planted verse line\tplanted source\n' > "$pen/one.txt"

verdict=ok

# leg NAME WANT_EXIT NEEDLE VERSE_FILE ERR_NEEDLE
# Runs the ticker once against VERSE_FILE. The exit code must match, stdout must hold NEEDLE, and
# stderr must hold ERR_NEEDLE. An empty needle is not checked, since grep -F "" matches everything.
leg() {
  name="$1"
  want_exit="$2"
  needle="$3"
  verse="$4"
  err_needle="$5"
  out=$(PRIN_VERSE="$verse" bash tools/fixtures/p/prin_ticker.sh once 2>"$pen/err.txt")
  got_exit=$?
  err_ok=yes
  if [ -n "$err_needle" ] && ! grep -qF "$err_needle" "$pen/err.txt"; then err_ok=no; fi
  if [ "$got_exit" -eq "$want_exit" ] && [ "$err_ok" = yes ] && { [ -z "$needle" ] || printf '%s' "$out" | grep -qF "$needle"; }; then
    echo "leg=$name exit=$got_exit verdict=as_named"
  else
    echo "leg=$name exit=$got_exit verdict=refuted"
    verdict=refuted
  fi
}

leg refuses_empty_verse 1 "" "$pen/empty.txt" "no verse lines"
leg welcomes_one_planted_line 0 "1/1" "$pen/one.txt" ""
leg live_verse_once 0 "mode once" "tools/fixtures/p/prin_verse_lines.txt" ""

echo "control_verdict=$verdict"
[ "$verdict" = ok ]
