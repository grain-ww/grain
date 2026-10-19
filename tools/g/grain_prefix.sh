#!/bin/sh
# grain_prefix.sh -- the single-stranded date prefix, backward compatible.
# Resolves from the tree's own folder name, handling both the current `grain-<ship>`
# and the dated `YYYYMMDD-grain-<ship>` shapes, so a script prepends $GRAIN_PREFIX
# rather than hard-coding a home path. One fact, one place (the single-stranded law).
set -eu
root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
base="$(basename "$root")"
GRAIN_PREFIX="$(printf '%s' "$base" | sed -n 's/^\([0-9]\{8\}\)-grain-.*/\1/p')"
GRAIN_SHIP="$(printf '%s' "$base" | sed -n 's/^\([0-9]\{8\}-\)\{0,1\}grain-\(.*\)$/\2/p')"
: "${GRAIN_SHIP:=incense}"
export GRAIN_PREFIX GRAIN_SHIP
grain_home() {
  _ship="${1:-$GRAIN_SHIP}"
  if [ -n "$GRAIN_PREFIX" ]; then echo "$HOME/${GRAIN_PREFIX}-grain-${_ship}"
  else echo "$HOME/grain-${_ship}"; fi
}
[ "${1:-}" = "--print" ] && echo "prefix=${GRAIN_PREFIX:-<none>} ship=$GRAIN_SHIP home=$(grain_home)"
