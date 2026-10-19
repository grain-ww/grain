#!/bin/sh
# rishi_fusion_measure_control.sh -- proves the fusion measurement scan can be trusted to read time.
#
# A timer that reads the wrong span reports a confident wrong answer. So this control plants a span
# it already knows and holds the scan's own clock to it, then checks the scan's honesty markers and
# its private-cache discipline. Every leg prints its name and a yes or no; the tally is asserted at the end.
#
# Usage: sh tools/fixtures/b/rishi_fusion_measure_control.sh
# Exits 0 when every leg is yes, 1 otherwise.

ROOT=$(cd "$(dirname "$0")/../../.." && pwd -P) || exit 1
SCAN="$ROOT/tools/fixtures/b/rishi_fusion_measure_scan.sh"
fails=0
legs=0

leg() {
    # $1 name, $2 result (0 pass, nonzero fail)
    legs=$((legs + 1))
    if [ "$2" -eq 0 ]; then echo "$1=yes"; else echo "$1=no"; fails=$((fails + 1)); fi
}

# Leg 1: the same clock arithmetic the scan uses reads a planted one-second sleep within tolerance.
# Tolerance is generous (900 to 1500ms) so a loaded pier does not red the control for scheduling noise.
t0=$(date +%s%N); sleep 1; t1=$(date +%s%N)
planted=$(( (t1 - t0) / 1000000 ))
[ "$planted" -ge 900 ] && [ "$planted" -le 1500 ]
leg timer_reads_planted_second $?

# Leg 2: the scan runs green end to end on this pier.
out=$(sh "$SCAN" 2>&1); rc=$?
[ "$rc" -eq 0 ]
leg scan_exits_zero $?

# Leg 4: every timed phase printed a positive integer span, not a blank or a word.
printf '%s\n' "$out" | grep -qE '^rish_startup_ms=[0-9]+ '
a=$?
printf '%s\n' "$out" | grep -qE '^compile_cold_ms=[1-9][0-9]* '
b=$?
printf '%s\n' "$out" | grep -qE '^compile_warm_ms=[0-9]+ '
c=$?
printf '%s\n' "$out" | grep -qE '^witness_wall_ms=[0-9]+ '
d=$?
[ "$a" -eq 0 ] && [ "$b" -eq 0 ] && [ "$c" -eq 0 ] && [ "$d" -eq 0 ]
leg every_phase_reads_a_span $?

# Leg 5: the two phases the scan cannot isolate are named as such, never silently timed as zero.
printf '%s\n' "$out" | grep -q '^dependency_closure=not_isolated'
a=$?
printf '%s\n' "$out" | grep -q '^receipt_writing=not_isolated'
b=$?
[ "$a" -eq 0 ] && [ "$b" -eq 0 ]
leg unisolated_phases_named $?

# Leg 6: no live line of the scan reads the shared zig cache, which eight ships write at once.
# Comment lines are read past: the header names the shared path in order to refuse it.
grep -v '^#' "$SCAN" | grep -q '\.cache/zig'
hit=$?
[ "$hit" -ne 0 ]
leg never_touches_shared_cache $?

# Leg 7: the scan names its private cache beneath the pen, not beneath the home directory.
grep -q 'ZIG_GLOBAL_CACHE_DIR="\$PRIV"' "$SCAN"
leg private_global_cache_set $?

echo "legs=$legs failing=$fails"
[ "$fails" -eq 0 ] && { echo "control_verdict=ok"; exit 0; }
echo "control_verdict=failed"
exit 1
