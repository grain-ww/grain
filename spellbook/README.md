# The Spellbook -- Grain's Operator Words

**Where this sits:** home is [`../README.md`](../README.md) - a first hour in your hands is
[`../docs-geode/tutorials/the-first-hour.md`](../docs-geode/tutorials/the-first-hour.md) - the whole
path from nothing to a signed, sandboxed home is [`../SOURCE.md`](../SOURCE.md)

> **Mirrored at `spellbook/README.md`**, declared in [`../context/document-mirrors.brix`](../context/document-mirrors.brix) and proven byte-identical. Every link here is written `../<room>/<file>` so it resolves from both homes (REDS %176).

**Language:** EN
**Seated:** `20260810.145033` on the maintainer's word - **Style:** Gauge (see `../context/GAUGE_STYLE.md`)
**Purpose:** Gather the one-word gestures that steer this workspace, so a hand on any client -- phone, terminal, fresh agent -- can read the whole vocabulary in one place.
**Room:** checkable -- every spell names the rule file that carries it

---

## What a spell is

A spell is a single word that names a whole, repeatable gesture. Where ordinary prose would spend a paragraph, a spell spends a syllable -- and every spell here already has a home rule that governs it exactly. This page is the index; the rule is the law. Where a spell links `[[nothing]]` yet, it is emerging and earns its own rule when the chapter wants it.

## The command words -- verbs that act

| Spell | What it does | Home |
|---|---|---|
| **send** | commit (signed, CONTRIBUTING style), push `origin` + `acme-owner`, merge to `main` | `.claude/rules/send-word.md` |
| **kg** | keep going -- the next mechanical lap (not a send by itself) | `.claude/rules/collaboration.md` |
| **seat** | make a proposal live -- write it as the standing thing, on the maintainer's word | `.claude/rules/cell.md` |
| **cast** | assign a point its attributes -- a galaxy's element and mode, a chart's longitudes | astrology cast - council topology |
| **remember** | reprint the living operator card for the next hand | `.claude/rules/remember.md` |
| **align** | reconcile the plan with what is actually true, then fix the plan | `.claude/rules/align.md` |
| **molt** | prep a dated writing's fossil onto the shred list -- opens no cut | `.claude/rules/molt.md` |
| **shred** / **shed** | the authorized cut of a fossil that has a living mutant | `.claude/rules/molt.md` - SHRED_PREP |
| **add to molt queue** | note a document into `construction/SHRED_PREP.md` with its measurement -- prep only, the file itself untouched | `context/CHEMICAL_FORMULAS.md` |
| **mitra shed prep** | a fossil seen off like a friend -- mutant seated, living citers repointed, banner on its face, row written -- and the cut still RED | `construction/SHRED_PREP.md` Class M |
| **debride** | the sanctioned break of accrete-never-break -- remove named dead history | `.claude/rules/debride.md` |
| **checkpoint** | mark the way back before a debride rewrites a living card | `.claude/rules/checkpoint.md` |
| **baton** | write a handoff to disk so the vision survives a context reset | handoff batons in `expanding-prompts/` |
| **recur** | pass the baton onward -- cite the parent whole, fold in only the delta | this page - the baton chain |
| **prin** | print the live loop view -- scope, nib, sundial, matrix frame | `context/LEXICON.md` - `tools/p/prin.rish` |
| **tend** | a light keeping round -- freshen, ratchet-on-touch, add no new weight | tend rounds |
| **survey** | the looking pass that names sites and gaps before the first GREEN | `.claude/rules/vocabulary-survey.md` |
| **expand** | grow an intent into a runnable plan in `expanding-prompts/` | `expanding-prompts/` |
| **fleet interactive** | begin a ship's conversation; the words are `fleet interactive <ship> <door>` | this page |
| **fleet loop** | start a ship's unattended loop; the words are `fleet loop <ship> <door>` | this page |
| **fleet watch** | re-arm stopped loops; the words are `fleet watch pier <door>` | this page |
| **incense interactive** | the incense pastes, and the Kyli sitting in the section of that name | this page |
## fleet

A fleet spell is four words: `fleet`, the gesture, the ship, and the door. The gesture is `interactive`, `loop`, or `watch`. The ship is a live seat. The door is `cursor`, `claude`, `codex`, `antigravity`, or `opencode`. `incense interactive <door>` names the same paste as `fleet interactive incense <door>`.

Run an interactive line in that ship's checkout, inside its tmux window. `FLEET_BARE=1` is the pier. `FLEET_CAPTAIN=1` belongs to incense. The captain's gates stay manual: keys, funds, provisioning, identity, and the public seed.

The interactive paste is one Rishi command, [`../tools/f/fleet_interactive.rish`](../tools/f/fleet_interactive.rish). It writes the prompt and `.lap/fleet-interactive-exec.sh`. The `exec` at the end of the paste keeps the terminal attached to the agent, because Rishi `run` captures a child's standard streams. Gauge and Bhakta are in that prompt by default, the automatic pair among Grain Kyri's five Radiant style voices: Gauge, Bhakta, Radiant, Twilight, and Civic. The loop and watch scripts stay shell. A live stream and an epoch deadline already live there, and Rishi `run` keeps a child's output for the script to read after the child exits.

The one-lap prints stay in their own scripts: [`../tools/l/launch-cursor-incense.sh`](../tools/l/launch-cursor-incense.sh), [`../tools/f/fleet-loop.sh`](../tools/f/fleet-loop.sh), [`../tools/f/fleet-loop-codex.sh`](../tools/f/fleet-loop-codex.sh), and [`../tools/f/fleet-loop-opencode.sh`](../tools/f/fleet-loop-opencode.sh). The Cursor one-lap script appends the same voice paragraph from `fleet_interactive.rish --voices`. The loop scripts include it by reading [`../tools/f/fleet_baton.txt`](../tools/f/fleet_baton.txt).

| Ship | Checkout | Seat prompt |
|---|---|---|
| incense | `~/grain-incense` | `tools/i/incense_seat_prompt.txt` |
| pheromone | `~/grain-pheromone` | `tools/p/pheromone_seat_prompt.txt` |
| petrichor | `~/grain-petrichor` | `tools/p/petrichor_seat_prompt.txt` |
| bakery | `~/grain-bakery` | `tools/b/bakery_seat_prompt.txt` |
| diffuser | `~/grain-diffuser` | `tools/d/diffuser_seat_prompt.txt` |
| grass | `~/grain-grass` | `tools/g/grass_seat_prompt.txt` |
| copal | `~/grain-copal` | `tools/c/copal_seat_prompt.txt` |
| patchouli | `~/grain-patchouli` | `tools/p/patchouli_seat_prompt.txt` |

Silence, hush, and dream stay parked. Their seat prompts remain in the tree. A later word can seat their pastes.

## fleet interactive

Each heading is the spell. The line under it is the paste. The words after `fleet_interactive.rish` are the ship and the door.

Cursor reads `--yolo` and `--model`. The shell also sets `CURSOR_FORCE=1`, which the print launcher turns into `--force`. Home: [`../frontier/cursor-cli/INCENSE-FLEET.md`](../frontier/cursor-cli/INCENSE-FLEET.md).

Claude Code treats a prompt as an interactive session. It reads `--dangerously-skip-permissions`. `--print` is its one-lap door. The paste names `claude-sonnet-5` at `--effort medium`, the resolved model on the live seats. [`.claude/settings.json`](../.claude/settings.json) still declares `claude-sonnet-5` as the fleet default a clone's local settings can outrank.

Codex forwards these flags to the interactive CLI. `codex exec` is its one-lap door. The model is the default in [`../tools/f/fleet-loop-codex.sh`](../tools/f/fleet-loop-codex.sh).

Antigravity's command is `agy`. It reads `--dangerously-skip-permissions` and `--prompt-interactive`. The paste leaves the model to the signed-in account. Home: [`../frontier/ANTIGRAVITY.md`](../frontier/ANTIGRAVITY.md).

OpenCode on Together is the interactive open door. The model is the one proven in [`../open/HARNESS_SETUP.md`](../open/HARNESS_SETUP.md) and named in [`../tools/f/fleet-loop-opencode.sh`](../tools/f/fleet-loop-opencode.sh). `opencode run --interactive` keeps the session open after the first message. OpenRouter and Hugging Face remain the request APIs in [`../open/PROVIDER_SETUP.md`](../open/PROVIDER_SETUP.md). This pier's OpenCode config seats Together only, so those two wait for their own model line before they earn a paste.

### fleet interactive incense cursor

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish incense cursor && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive incense claude

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish incense claude && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive incense codex

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish incense codex && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive incense antigravity

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish incense antigravity && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive incense opencode

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish incense opencode && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive pheromone cursor

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish pheromone cursor && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive pheromone claude

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish pheromone claude && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive pheromone codex

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish pheromone codex && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive pheromone antigravity

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish pheromone antigravity && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive pheromone opencode

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish pheromone opencode && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive petrichor cursor

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish petrichor cursor && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive petrichor claude

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish petrichor claude && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive petrichor codex

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish petrichor codex && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive petrichor antigravity

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish petrichor antigravity && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive petrichor opencode

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish petrichor opencode && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive bakery cursor

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish bakery cursor && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive bakery claude

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish bakery claude && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive bakery codex

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish bakery codex && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive bakery antigravity

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish bakery antigravity && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive bakery opencode

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish bakery opencode && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive diffuser cursor

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish diffuser cursor && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive diffuser claude

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish diffuser claude && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive diffuser codex

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish diffuser codex && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive diffuser antigravity

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish diffuser antigravity && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive diffuser opencode

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish diffuser opencode && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive grass cursor

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish grass cursor && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive grass claude

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish grass claude && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive grass codex

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish grass codex && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive grass antigravity

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish grass antigravity && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive grass opencode

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish grass opencode && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive copal cursor

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish copal cursor && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive copal claude

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish copal claude && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive copal codex

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish copal codex && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive copal antigravity

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish copal antigravity && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive copal opencode

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish copal opencode && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive patchouli cursor

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish patchouli cursor && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive patchouli claude

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish patchouli claude && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive patchouli codex

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish patchouli codex && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive patchouli antigravity

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish patchouli antigravity && exec sh .lap/fleet-interactive-exec.sh
```

### fleet interactive patchouli opencode

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish patchouli opencode && exec sh .lap/fleet-interactive-exec.sh
```

## incense interactive

`incense interactive <door>` is the incense row of the fleet interactive pastes above. A Cursor thread already open on this checkout is that door: it reads the baton and `tools/i/incense_seat_prompt.txt` in place, and it leaves the paste unexecuted. One writer holds the checkout.

**Kyli** is the feminine sibling voice. Her page is [`../context/KYLI.md`](../context/KYLI.md). Kyri keeps the standing voice and the `.kyri` notation. A Kyli sitting passes `kyli` after the door. She sits with incense. The spell prints her name in the prompt and asks the sitting to read her page before the first reply.

### incense interactive cursor kyli

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish incense cursor kyli && exec sh .lap/fleet-interactive-exec.sh
```

### incense interactive claude kyli

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish incense claude kyli && exec sh .lap/fleet-interactive-exec.sh
```

### incense interactive codex kyli

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish incense codex kyli && exec sh .lap/fleet-interactive-exec.sh
```

### incense interactive antigravity kyli

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish incense antigravity kyli && exec sh .lap/fleet-interactive-exec.sh
```

### incense interactive opencode kyli

```sh
rishi/bin/rishi run tools/f/fleet_interactive.rish incense opencode kyli && exec sh .lap/fleet-interactive-exec.sh
```

## fleet loop

The loop doors are `claude`, `codex`, and `opencode`. Cursor and Antigravity stay conversation doors above. A `LOOP_LAPS=1` line is one lap. The claude paste sets `FLEET_BARE=1` so this pier stays outside the enclosure. Codex and OpenCode are bare in their own scripts. The roster seats incense on claude and the other seven live ships on codex; these pastes are the commands, and the roster remains the seating.

### fleet loop claude

```sh
# fleet loop incense claude
cd ~/grain-incense && FLEET_BARE=1 sh tools/f/fleet-loop.sh incense
# fleet loop incense claude -- one lap
cd ~/grain-incense && FLEET_BARE=1 LOOP_LAPS=1 sh tools/f/fleet-loop.sh incense
# fleet loop pheromone claude
cd ~/grain-pheromone && FLEET_BARE=1 sh tools/f/fleet-loop.sh pheromone
# fleet loop pheromone claude -- one lap
cd ~/grain-pheromone && FLEET_BARE=1 LOOP_LAPS=1 sh tools/f/fleet-loop.sh pheromone
# fleet loop petrichor claude
cd ~/grain-petrichor && FLEET_BARE=1 sh tools/f/fleet-loop.sh petrichor
# fleet loop petrichor claude -- one lap
cd ~/grain-petrichor && FLEET_BARE=1 LOOP_LAPS=1 sh tools/f/fleet-loop.sh petrichor
# fleet loop bakery claude
cd ~/grain-bakery && FLEET_BARE=1 sh tools/f/fleet-loop.sh bakery
# fleet loop bakery claude -- one lap
cd ~/grain-bakery && FLEET_BARE=1 LOOP_LAPS=1 sh tools/f/fleet-loop.sh bakery
# fleet loop diffuser claude
cd ~/grain-diffuser && FLEET_BARE=1 sh tools/f/fleet-loop.sh diffuser
# fleet loop diffuser claude -- one lap
cd ~/grain-diffuser && FLEET_BARE=1 LOOP_LAPS=1 sh tools/f/fleet-loop.sh diffuser
# fleet loop grass claude
cd ~/grain-grass && FLEET_BARE=1 sh tools/f/fleet-loop.sh grass
# fleet loop grass claude -- one lap
cd ~/grain-grass && FLEET_BARE=1 LOOP_LAPS=1 sh tools/f/fleet-loop.sh grass
# fleet loop copal claude
cd ~/grain-copal && FLEET_BARE=1 sh tools/f/fleet-loop.sh copal
# fleet loop copal claude -- one lap
cd ~/grain-copal && FLEET_BARE=1 LOOP_LAPS=1 sh tools/f/fleet-loop.sh copal
# fleet loop patchouli claude
cd ~/grain-patchouli && FLEET_BARE=1 sh tools/f/fleet-loop.sh patchouli
# fleet loop patchouli claude -- one lap
cd ~/grain-patchouli && FLEET_BARE=1 LOOP_LAPS=1 sh tools/f/fleet-loop.sh patchouli
```

### fleet loop codex

```sh
# fleet loop incense codex
cd ~/grain-incense && sh tools/f/fleet-loop-codex.sh incense
# fleet loop incense codex -- one lap
cd ~/grain-incense && LOOP_LAPS=1 sh tools/f/fleet-loop-codex.sh incense
# fleet loop pheromone codex
cd ~/grain-pheromone && sh tools/f/fleet-loop-codex.sh pheromone
# fleet loop pheromone codex -- one lap
cd ~/grain-pheromone && LOOP_LAPS=1 sh tools/f/fleet-loop-codex.sh pheromone
# fleet loop petrichor codex
cd ~/grain-petrichor && sh tools/f/fleet-loop-codex.sh petrichor
# fleet loop petrichor codex -- one lap
cd ~/grain-petrichor && LOOP_LAPS=1 sh tools/f/fleet-loop-codex.sh petrichor
# fleet loop bakery codex
cd ~/grain-bakery && sh tools/f/fleet-loop-codex.sh bakery
# fleet loop bakery codex -- one lap
cd ~/grain-bakery && LOOP_LAPS=1 sh tools/f/fleet-loop-codex.sh bakery
# fleet loop diffuser codex
cd ~/grain-diffuser && sh tools/f/fleet-loop-codex.sh diffuser
# fleet loop diffuser codex -- one lap
cd ~/grain-diffuser && LOOP_LAPS=1 sh tools/f/fleet-loop-codex.sh diffuser
# fleet loop grass codex
cd ~/grain-grass && sh tools/f/fleet-loop-codex.sh grass
# fleet loop grass codex -- one lap
cd ~/grain-grass && LOOP_LAPS=1 sh tools/f/fleet-loop-codex.sh grass
# fleet loop copal codex
cd ~/grain-copal && sh tools/f/fleet-loop-codex.sh copal
# fleet loop copal codex -- one lap
cd ~/grain-copal && LOOP_LAPS=1 sh tools/f/fleet-loop-codex.sh copal
# fleet loop patchouli codex
cd ~/grain-patchouli && sh tools/f/fleet-loop-codex.sh patchouli
# fleet loop patchouli codex -- one lap
cd ~/grain-patchouli && LOOP_LAPS=1 sh tools/f/fleet-loop-codex.sh patchouli
```

### fleet loop opencode

```sh
# fleet loop incense opencode
cd ~/grain-incense && sh tools/f/fleet-loop-opencode.sh incense
# fleet loop incense opencode -- one lap
cd ~/grain-incense && LOOP_LAPS=1 sh tools/f/fleet-loop-opencode.sh incense
# fleet loop pheromone opencode
cd ~/grain-pheromone && sh tools/f/fleet-loop-opencode.sh pheromone
# fleet loop pheromone opencode -- one lap
cd ~/grain-pheromone && LOOP_LAPS=1 sh tools/f/fleet-loop-opencode.sh pheromone
# fleet loop petrichor opencode
cd ~/grain-petrichor && sh tools/f/fleet-loop-opencode.sh petrichor
# fleet loop petrichor opencode -- one lap
cd ~/grain-petrichor && LOOP_LAPS=1 sh tools/f/fleet-loop-opencode.sh petrichor
# fleet loop bakery opencode
cd ~/grain-bakery && sh tools/f/fleet-loop-opencode.sh bakery
# fleet loop bakery opencode -- one lap
cd ~/grain-bakery && LOOP_LAPS=1 sh tools/f/fleet-loop-opencode.sh bakery
# fleet loop diffuser opencode
cd ~/grain-diffuser && sh tools/f/fleet-loop-opencode.sh diffuser
# fleet loop diffuser opencode -- one lap
cd ~/grain-diffuser && LOOP_LAPS=1 sh tools/f/fleet-loop-opencode.sh diffuser
# fleet loop grass opencode
cd ~/grain-grass && sh tools/f/fleet-loop-opencode.sh grass
# fleet loop grass opencode -- one lap
cd ~/grain-grass && LOOP_LAPS=1 sh tools/f/fleet-loop-opencode.sh grass
# fleet loop copal opencode
cd ~/grain-copal && sh tools/f/fleet-loop-opencode.sh copal
# fleet loop copal opencode -- one lap
cd ~/grain-copal && LOOP_LAPS=1 sh tools/f/fleet-loop-opencode.sh copal
# fleet loop patchouli opencode
cd ~/grain-patchouli && sh tools/f/fleet-loop-opencode.sh patchouli
# fleet loop patchouli opencode -- one lap
cd ~/grain-patchouli && LOOP_LAPS=1 sh tools/f/fleet-loop-opencode.sh patchouli
```

## fleet watch

The ship word is `pier`, the tmux session. The watch reads the live roster and skips incense unless `WATCH_SKIP` is set empty. A `.loop-clockout` file holds every arm. Run the line from a checkout, in the watch window.

```sh
# fleet watch pier claude
sh tools/f/fleet_watch.sh
# fleet watch pier codex
sh tools/f/fleet_watch_codex.sh
# fleet watch pier opencode
sh tools/f/fleet_watch_opencode.sh
```

## The invoked kin -- tools and disciplines a chant calls by name

- **glow** -- the language - **rishi** -- the shell (`.rish`) - **rye** -- systems (Zig dialect) - **brix** -- composition - **kyri** -- the notation (`.kyri`) and the voice.
- **loom** -- where a lantern that fires twice becomes a standing pattern (`.claude/rules/reds-first.md`).
- **grain** -- the whole: the personal OS this all serves.
- **compass** -- the return habit; **council** -- the odd-quorum topology of named galaxies (`context/council-names.kyri`).
- **Lila-first, return-first** -- the short name of the order. The return is the ground that lasts, and Lila is the glad keystone on it. Defined in [`../context/LEXICON.md`](../context/LEXICON.md), seated in [`../foundations/20261002-111449_lila-and-the-long-return.md`](../foundations/20261002-111449_lila-and-the-long-return.md), spoken in [`../context/KYRI.md`](../context/KYRI.md). The rule is [`../.claude/rules/lila-and-the-long-return.md`](../.claude/rules/lila-and-the-long-return.md).

## Discipline the spellbook keeps

- **A spell names a gesture; the rule holds the law.** Reading a spell here never replaces reading its home rule before a large or destructive act.
- **The destructive spells are word-gated.** `shred` and `debride` run only on an explicit word naming *what* to remove, `checkpoint` first, and never as a default.
- **kg != send.** Keep going continues a lap; only `send` ships.

---

*One syllable, one whole gesture -- so a hand on any client can steer the work by its true names, and never lose the thread between phone, terminal, and the pier.*
