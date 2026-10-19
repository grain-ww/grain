#!/bin/sh
# fleet_rename_dated.sh -- rename ~/grain-<ship> to ~/<prefix>-grain-<ship>, safely.
#
# Hand-run with the fleet QUIESCED (stop fleet_watch and every loop first). It refuses to
# rename the tree the shell runs from (the harness/shell cwd hard-stop), refuses a tree with
# uncommitted changes, skips a destination that already exists, and repoints each moved tree's
# own .git/config absolute gpg.program/core.sshCommand/ssh_config_jail paths -- because an
# absolute path a rename leaves stale refuses every sign and push (birth_a_clone's own lesson),
# and nothing tracked can catch it since .git/config is untracked.
#
#   sh tools/f/fleet_rename_dated.sh            # prefix defaults to 20260618
#   sh tools/f/fleet_rename_dated.sh 20260618
set -eu
PREFIX="${1:-20260618}"
SHIPS="incense bakery pheromone petrichor grass copal patchouli diffuser"
here="$(pwd)"
for ship in $SHIPS; do
  old="$HOME/grain-$ship"; new="$HOME/${PREFIX}-grain-$ship"
  [ -e "$old" ] || { echo "skip $ship: no $old"; continue; }
  [ -e "$new" ] && { echo "skip $ship: $new already exists"; continue; }
  case "$here" in "$old"|"$old"/*) echo "REFUSE $ship: run this from OUTSIDE $old (the shell cwd hard-stop)"; continue;; esac
  if [ -n "$(git -C "$old" status --porcelain 2>/dev/null)" ]; then
    echo "REFUSE $ship: $old has uncommitted changes -- commit or stash first"; continue
  fi
  mv "$old" "$new"
  for f in "$new/.git/config" "$new/.git/ssh_config_jail"; do
    [ -f "$f" ] || continue
    sed "s|$old/|$new/|g" "$f" > "$f.tmp" && cat "$f.tmp" > "$f" && rm -f "$f.tmp"
  done
  gp="$(git -C "$new" config gpg.program 2>/dev/null || true)"
  if [ -n "$gp" ] && [ ! -x "$gp" ]; then echo "WARN $ship: gpg.program $gp not executable -- check $new/.git/config"; fi
  echo "renamed $ship -> $new"
done
echo "done. A tree you were standing in must be renamed from a neutral shell, then re-entered."
