#!/bin/sh
# tools/fixtures/b/brush_parse_density_control.sh -- prove the invariant-density floor from both sides.
#
# WHAT THIS DOES. tools/gen/chapter/brush_parse_tame_density.sh counts `invariant:` markers in
# brushstroke/brush_parse.rye and exits 0 at or above 20, 1 below it. A floor proven only by the
# passing tree cannot be told from a floor that never reads anything, so this plants a shallow
# brush_parse.rye in a throwaway pen (19 markers, one under the floor) and a full one (20, at the
# floor), and asserts the refusal and the welcome. The real tree is read last, as a third leg.
#
# WHY THE SCRIPT RUNS INSIDE THE PEN. It reads its target by a relative path, so the pen is the
# working directory and the script is named by absolute path. Nothing else is touched.
#
# Usage:  sh tools/fixtures/b/brush_parse_density_control.sh
# Exit 0 only when every leg answers as named.

set -u
HERE=$(cd "$(dirname "$0")" && pwd)
ROOT=$(cd "$HERE/../../.." && pwd)
SCRIPT="$ROOT/tools/gen/chapter/brush_parse_tame_density.sh"
PEN=$(mktemp -d "${TMPDIR:-/tmp}/brush_parse_density_control.XXXXXX") || exit 2
trap 'rm -rf "$PEN"' EXIT INT TERM

failed=0
legs=0

# plant <markers> -- writes a brush_parse.rye carrying exactly that many invariant: lines.
plant() {
  mkdir -p "$PEN/brushstroke"
  : > "$PEN/brushstroke/brush_parse.rye"
  i=0
  while [ "$i" -lt "$1" ]; do
    echo "// invariant: planted marker $i" >> "$PEN/brushstroke/brush_parse.rye"
    i=$((i + 1))
  done
}

# leg <name> <want_exit> <markers> -- plant, run, and hold the exit code to the named answer.
leg() {
  legs=$((legs + 1))
  plant "$3"
  (cd "$PEN" && sh "$SCRIPT" >/dev/null 2>&1)
  got=$?
  if [ "$got" -eq "$2" ]; then
    echo "leg=$1 markers=$3 exit=$got verdict=as_named"
  else
    echo "leg=$1 markers=$3 exit=$got want=$2 verdict=FAIL"
    failed=$((failed + 1))
  fi
}

leg refuses_below_floor 1 19
leg welcomes_at_floor 0 20
leg welcomes_above_floor 0 25

# The real tree, read in place. Its own marker count is not pinned here -- the floor is the claim.
legs=$((legs + 1))
(cd "$ROOT" && sh "$SCRIPT" >/dev/null 2>&1)
got=$?
if [ "$got" -eq 0 ]; then
  echo "leg=live_tree exit=$got verdict=as_named"
else
  echo "leg=live_tree exit=$got want=0 verdict=FAIL"
  failed=$((failed + 1))
fi

echo "legs=$legs failed=$failed"
if [ "$failed" -eq 0 ]; then
  echo "control_verdict=ok"
  exit 0
fi
echo "control_verdict=red"
exit 1
