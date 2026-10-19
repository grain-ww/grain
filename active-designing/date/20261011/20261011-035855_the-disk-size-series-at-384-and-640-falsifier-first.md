# The disk-size series at N = 384 and 640, falsifiers written before the run

**Status:** Design -- falsifiers stamped `20261011.035855` and committed before any N = 384 or N = 640 run; result appended below after the run
**Room:** research for understanding (scratch model; no witness binds it yet)
**Kin:** [the N = 512 fine-grid run](20261011-035019_the-n512-fine-grid-falsifier-first.md) - [the fine capacity grid](20261011-034455_the-fine-capacity-grid-off-powers-of-two.md)

## What this door tests

The N = 512 run read the polar-to-Cartesian working-set ratio at 2.65, against 2.69 at N = 256, 2.60 at N = 128 and 2.39 at N = 64. So the rise with N has turned on this model, and the peak sits near N = 256 on four points. The N = 512 paper named this door: a disk-size series at N = 384 and N = 640 on the same fine grid, to decide whether the peak sits near 256 or moves.

Unit: the floor is a count of sets, 8 lines each, at 5 percent excess over compulsory misses. Ratio is polar floor over Cartesian floor, dimensionless. Source: `session-output/polar-padded/fine_capacity.py`, untracked scratch, unchanged for this door, run as `python3 fine_capacity.py nopad 384 640` from `session-output/polar-padded/`.

## Baseline check, before the falsifiers are read

The N = 256 row reproduces from `fc256_base_20261011.txt` at 2.69. The N = 384 and N = 640 rows count only if the scratch script still reads that N = 256 baseline within 0.01 on this rerun.

## Falsifiers, written before the run

- **F1 (band).** The unpadded ratio at N = 384 and at N = 640, LINE 8, 5 percent, each lies inside 2.6 to 3.0. Fires if either is below 2.6 or above 3.0. The band is the fine-grid paper's own, carried unchanged from the N = 512 door.
- **F2 (peak holds near 256).** Neither the N = 384 ratio nor the N = 640 ratio exceeds 2.74, which is the N = 256 value of 2.69 plus 0.05. Fires if either exceeds 2.74. Reason: the N = 512 reading of 2.65 says the rise has turned, and a return above the N = 256 value at either intermediate or larger disk would mean the peak moved past 256 or the curve is not unimodal.
- **F3 (monotone curve).** The polar miss curve has zero monotone violations at both N = 384 and N = 640. Fires on any violation, since a violation means the floor search read noise rather than capacity.

## What would change the reading

If F1, F2 and F3 hold, the ratio is flat-to-falling above N = 256 on this model, and the peak sits near 256 within the resolution of these five points. If F2 fires, the peak has moved past 256 and the next question is where, which the N = 512 reading did not settle. If F1 fires low at either size, the band itself is not stable across disk size and the fine-grid band reading must be narrowed.

## Scope

Scratch model only. Eight ways, LRU, modulo index, LINE 8, deterministic disk and trace. No hardware, no witness, no claim about a real cache. Confidence in F2 holding: medium, since the N = 512 point is the only evidence of the turn and the disk grows by a factor the trend has not yet been tested across.

## Result

Appended after the run, below this line. The three falsifiers above are not edited.

Run at clock `20261011.040300` on the scratch script, no edit to it: `python3 fine_capacity.py nopad 256 384 640`, unpadded, LINE 8, 5 percent, 2 min 51 s. Output is untracked in `session-output/polar-padded/fc384_640_nopad_20261011.txt`. The `-I` isolated flag was not used, since it removes the script's own directory from the import path and the module `padded_bitslice` fails to load under it.

| Reading | N = 256 baseline | N = 384, unpadded | N = 512, unpadded (prior) | N = 640, unpadded |
|---|---|---|---|---|
| Cartesian floor, sets | 12.4 | 19.2 | 25.0 | 28.8 |
| Polar floor, sets | 33.3 | 49.7 | 66.3 | 83.0 |
| Ratio, polar over Cartesian | 2.69 | **2.59** | 2.65 | **2.88** |
| Monotone violations, polar curve | 0 | 0 | 0 | 0 |

- **Baseline.** N = 256 reproduces 2.69, so the script has not drifted and the rows count.
- **F1 (band 2.6 to 3.0).** **Fired low at N = 384.** The ratio is 2.59 (49.7 over 19.2, 2.588 unrounded), 0.01 under the band's lower edge. N = 640 at 2.88 sits inside the band.
- **F2 (no ratio above 2.74).** **Fired high at N = 640.** The ratio is 2.88, 0.14 above the 2.74 line.
- **F3 (zero monotone violations).** Holds at both sizes.

**Reading.** The ratio does not peak near 256 and then fall. Across the six disk sizes it reads 2.39, 2.60, 2.69, 2.59, 2.65 and 2.88 at N = 64, 128, 256, 384, 512 and 640. That is a sawtooth, not a trend. The N = 512 paper's claim that the rise had turned rested on four points, and two more points now contradict it. That claim is withdrawn here; the N = 512 paper keeps its own words as testimony. Inference, not measurement: the ratio depends on N through something the disk-size axis does not isolate, plausibly how the integer set count of the modulo index lines up with each disk's ring and row counts. The model is deterministic, so the sawtooth is exact for this model and says nothing about a real cache.

**Confidence.** High that the ratio is not monotone in N on this model across 64 to 640, since both fired falsifiers read against stated bounds. Low on any shape claim, since six points on one model with one radius series cannot fix the function. The F1 miss at 384 is marginal, 0.01 under the band, and should be read as a band edge rather than a large departure.

**Scope.** Scratch model only: eight ways, LRU, modulo index, LINE 8, unpadded. No padded row was run at 384 or 640. No hardware, no witness, no claim about any real cache.

**Next door.** A falsifier-first test of the sawtooth's cause: whether the N = 384 dip and the N = 640 rise track the ratio of disk ring count to set count, which would be a pure index-alignment effect, against a reading where the disk's own geometry carries it. The falsifier for that door is to be written and committed before its run.
