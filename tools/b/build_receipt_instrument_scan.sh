#!/bin/sh
# tools/b/build_receipt_instrument_scan.sh -- read-only instrument for the fusion build basis.
#
# WHAT IT MEASURES. The standing roster writes one receipt, construction/standing-equipment-receipt.kyri,
# recording the last fully green FULL pass on this pier: its tree digest, its head, its guard count.
# --scoped passes consult that receipt. This scan reads the receipt beside the live tree and reports
# how far the two have drifted, so a builder can see where repeated work actually lives before any
# cache is designed. It writes nothing. It reads the receipt, git, and nothing else.
#
# WHAT IT DOES NOT DO. It does not judge whether a receipt is trustworthy; a receipt is a claim about
# the tree at its head, and this scan only reports the distance. It does not run any guard.
#
# Usage: sh tools/b/build_receipt_instrument_scan.sh [receipt-path]

RECEIPT="${1:-construction/standing-equipment-receipt.kyri}"

if [ ! -f "$RECEIPT" ]; then
  echo "receipt=absent path=$RECEIPT"
  echo "verdict=no_basis"
  exit 0
fi

field() {
  # Print the value of one key-value line, or "none" when the key is absent.
  v=$(awk -v k="$1" '$1 == k { $1 = ""; sub(/^ /, ""); print; exit }' "$RECEIPT")
  if [ -n "$v" ]; then echo "$v"; else echo none; fi
}

r_head=$(field head)
r_digest=$(field digest)
r_scope=$(field scope)
r_guards=$(field guards)
r_stamp=$(field stamp)
r_gated=$(field gated)

head_now=$(git rev-parse HEAD 2>/dev/null)
if [ -z "$head_now" ]; then
  echo "verdict=no_git"
  exit 0
fi

echo "receipt_path=$RECEIPT"
echo "receipt_stamp=$r_stamp"
echo "receipt_scope=$r_scope"
echo "receipt_guards=$r_guards"
echo "receipt_gated=$r_gated"
echo "receipt_head=$r_head"
echo "receipt_digest=$r_digest"
echo "head_now=$(echo "$head_now" | cut -c1-12)"

if [ "$r_head" = none ]; then
  echo "verdict=no_head"
  exit 0
fi

# Is the receipt's head an ancestor of HEAD? If not, it was written on a checkout this tree
# does not contain, and no distance reading means anything.
if ! git merge-base --is-ancestor "$r_head" HEAD 2>/dev/null; then
  echo "head_is_ancestor=no"
  echo "verdict=foreign_head"
  exit 0
fi

echo "head_is_ancestor=yes"
commits_since=$(git rev-list --count "$r_head"..HEAD)
echo "commits_since_receipt=$commits_since"

# Files that changed between the receipt's head and HEAD, counted by path. A changed file under
# tools/ is a changed instrument; a changed file under session-logs/ is only testimony and moves
# no guard, so the two are counted apart.
changed=$(git diff --name-only "$r_head" HEAD)
changed_total=$(echo "$changed" | grep -c .)
changed_tools=$(echo "$changed" | grep -c '^tools/')
changed_testimony=$(echo "$changed" | grep -c '^session-logs/')
echo "changed_files=$changed_total"
echo "changed_tools=$changed_tools"
echo "changed_testimony=$changed_testimony"

# Uncommitted drift: a receipt is only as current as the tree it was written beside.
dirty=$(git status --porcelain | grep -c .)
echo "dirty_entries=$dirty"

if [ "$commits_since" -eq 0 ] && [ "$dirty" -eq 0 ]; then
  echo "verdict=current"
elif [ "$changed_tools" -eq 0 ] && [ "$dirty" -eq 0 ]; then
  echo "verdict=testimony_only_drift"
else
  echo "verdict=drifted"
fi
echo "run_verdict=ok"
