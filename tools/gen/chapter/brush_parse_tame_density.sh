#!/bin/sh
# brush_parse_tame_density.sh -- Surface p24 - living floor ≥20 invariant markers
# Kept as a tiny shell hand so rishi need not interpolate $vars inside sh -c.
set -eu
# grep -c exits 1 on zero matches, which set -e would take as a silent exit;
# the `|| true` keeps the count (0) so the INV_LOW line below still speaks.
c=$(grep -c 'invariant:' brushstroke/brush_parse.rye || true)
if [ "$c" -ge 20 ]; then
  echo "INV_OK $c"
  exit 0
fi
echo "INV_LOW $c" >&2
exit 1
