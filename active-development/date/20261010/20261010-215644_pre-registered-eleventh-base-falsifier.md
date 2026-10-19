# Pre-registered falsifier for an eleventh seed base, named and not run

**Stamp:** `20261010.215644` -- the clock read before this file was written and before any run
**Status:** Proposed -- the falsifier is written; the run waits for the maintainer's word
**Room:** active-development -- a round's plan, not a finding. Its one measurement is a plan to be run later.
**Lineage:** [`20261010-201944`](../../../active-designing/date/20261010/20261010-201944_the-tenth-base-bootstrap-interval-contains-the-line.md) -- the tenth-base paper ruled that "until the word comes, no new base is run," and named the next door as a fresh base with its own falsifier written before the run.

## What this writes, and what it does not

This page does three things. It names one candidate seed base, `20261020`, which no base in `20261011` through `20261019` has used. It writes the falsifier for that base before any run exists. It names the one measurement that would decide the base.

It runs nothing. No tree is read for a result, no script is executed, and no number is produced. The run is the next door, and the maintainer's word opens it.

## The candidate

- **Base:** `20261020`, read as the seed stamp the tenth paper used. The 24 seeds derive from the base the way the tenth run derived them.
- **Why this base:** it is the first unused stamp after the nine recorded bases, so the base is fresh by construction. The grep that showed `20261011` through `20261019` as used ran at the stamp above.
- **Scope:** the scratch model only, the same ten families and the same column-major walk as the tenth base. No hardware, no new family, no new walk.

## The falsifier, written first

Two falsifiers, one per reading the tenth paper already named. Both are fixed here, before the run.

1. **The base decides, one way or the other**, if the 95 percent bootstrap interval of tau-b over 2,000 resamples of the 24 seeds lies wholly above 0.5 or wholly below 0.5. An interval that holds 0.5 inside it means this base cannot decide the line.
2. **The base adds to the tendency**, not to the decision, if its interval straddles 0.5. The tenth base's interval straddled the line, so a straddle here is the expected outcome, and it counts as a result, not a failure.

A point value above 0.5 with a straddling interval does not count as a decision. The tenth paper showed the point value and the interval can disagree, and the interval is the reading that decides.

## Confidence, in plain words

- **Confidence the base is fresh:** high, because the grep is exact and the stamp is unused.
- **Confidence the run decides the line:** low. The tenth base's interval spanned about 0.44 of tau-b width, and a fresh base is likely to land the same way. The projection is a straddle, and the falsifier above already says a straddle decides nothing.
- **What would change the projection:** a wider seed set, or a longer resample count. Neither is proposed here, and either would need its own falsifier before a run.

## What a the maintainer word looks like

Any one of these opens the run:

- "run `20261020`" -- the falsifier above stands as written.
- "hold the tendency" -- the question closes on the nine bases already read, and this file stays as a record.
- "widen the seeds" -- a new falsifier is written before any run on the wider set.

## Limits, said plainly

This page is a plan with a clock on it. Its falsifier is only as good as the script that will read it, and that script's own header carries the reading. Earlier bases in this series carried label faults (the sixth base's file, the eighth base's printout, and the tenth base's count parser), and the same kind of fault could appear here. The run, when it comes, is read against this file and not against any later memory of it.
