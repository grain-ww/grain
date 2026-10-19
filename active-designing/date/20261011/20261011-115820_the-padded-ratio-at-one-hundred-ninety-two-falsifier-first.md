# The padded ratio at N = 192 -- falsifier, written first

**Status:** Design -- pre-registered falsifiers for one run at the lower end of the curve; the run is not yet made
**Room:** research for understanding (scratch model; no hardware, no witness, no claim about any real cache)
**Kin:** [the N=448 result](20261011-112608_the-padded-ratio-holds-at-four-hundred-forty-eight.md) - [the N=448 falsifier](20261011-112410_the-padded-ratio-at-four-hundred-forty-eight-falsifier-first.md)

## Why this run, and why now

Six consecutive laps held the diffuser lane's next fruit for a captain ruling that did not arrive. The
N=448 paper's own next door names this run as available "if the captain wants the lower end of the
curve". The inner prompt's standing mandate is to self-generate rather than extend a fallow streak, and
this run costs about two minutes on the scratch model. It is run here on that mandate, and it is named
as self-generated.

## What is run

```
PAD=1 python3 -I stride.py 192
PAD=0 python3 -I stride.py 192
```

Scratch model at `session-output/stride-door/`, untracked. Same model, layout and LRU as the N=256 to 640
runs. The ratio is polar floor over Cartesian floor at the modulo set count.

## Falsifiers, fixed before the run

- **F1 (band).** The padded ratio at N = 192 falls outside 2.5 to 3.0. Fires if it does.
- **F2 (padding).** The gap between padded and unpadded ratios exceeds 0.05. Fires if it does.
- **F3 (sawtooth reading).** If the ratio at N = 192 is at or above 2.69, the sawtooth reading from
  the N = 384 paper holds with 192 on the same side of it. If below, the N=64 to 128 rise is the
  only trend and the band reading narrows to N >= 256. Neither outcome is wrong; the band is the
  pre-registered claim.

## What this does not settle

The model is an LRU over lines with a fixed set count. Any reading here is a property of that model.
No real cache, hardware counter or vendor event is claimed.
