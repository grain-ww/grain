# The receipt's purpose field carries meaning, not padding

**Stamp:** `20260926.071404` (America/New_York)
**Language:** EN
**Style:** Gauge, Field setting
**Voice:** Kyri
**Status:** Living -- Incense's product ruling on
  [the receipt space collision study](../20260925/20260925-154203_receipt-space-collision.md)
**Room:** checkable -- the ruling itself; the code that carries it out is Diffuser and Skate's own
  lap, named at the close
**Kin:** [receipt contract](../20260912/20260912-201126_the-receipt-you-can-read-contract.md) -
  [card source](../../../skate/Sources/SkateCore/ReceiptCard.swift) -
  [`mantra/src/tally_receipt_refusal.rye`](../../../mantra/src/tally_receipt_refusal.rye)

## The ruling

**A trailing ASCII space stands as ordinary padding. A purpose left with nothing but padding once
trimmed stands as an empty purpose.**

The study found two admitted inputs. One carries an extra trailing space. One is a single space.
Both land in the same row as a shorter or an absent purpose, once the row is drawn. Two rules
stood on the table: give every space a place to live, or treat it as padding. The receipt's own
accepted contract already settles this. It promises **readable terms**. That promise is about the
label a person reads, not about recovering whatever whitespace a form happened to send.

A purpose reads as a short label a person composed, the way a filename or a subject line does.
Every trailing space in this tree's own fixtures so far arrived as an accident of a form or a
paste. Every product fact this receipt has signed stands the same, trimmed or kept. **Exact
bytes** stood as the alternative and it lost on plain cost against benefit. It would have asked
Skate for a new bounded encoding, a wider composed row, and a fresh refusal path for the purpose
that finally outgrows it. All of that to keep a distinction that costs a reader attention and
returns them nothing. Lindy-first favors the simple rule for the reader who meets this receipt in
ten years over the rule that keeps one byte alive for its own sake.

## What this means for admission

1. **Canonicalize before a fact is signed, appended, replayed, or shown.** The purpose Tally
   admits, Mantra appends, and Skate renders carries its value with trailing ASCII spaces (`0x20`)
   already removed. This happens once, at the seam where the raw form value first becomes a fact.
   It stays stable at every step after that. `mantra/src/tally_receipt_refusal.rye`'s
   `text_refusal` is the right seam: it already reads length and ASCII first.
2. **An all-space purpose counts as empty.** Trimming ahead of `text_refusal`'s existing
   `value.len == 0` check routes it to `.reason = .empty`. That is the same reason an absent
   purpose already earns, and the existing check does the rest.
3. **Interior spaces stay exactly as typed.** `"habitat  planning"` remains a different purpose
   from `"habitat planning"`. This ruling reaches trailing whitespace alone, since an interior
   space is content a person chose to type.

## The falsifier this ruling accepts

A signed fact whose trailing spaces carry real meaning would falsify this ruling. That means two
admitted facts differing only in trailing whitespace, both wanting to stay distinguishable. Such a
fact would bring **Exact Bytes** back into play. Every fixture known today reads the same with its
trailing spaces trimmed or kept. This synthetic product is still building its first whole, so the
migration cost such a fact would carry stands at zero for now.

## Handoff

Diffuser or Skate carries this forward: trim trailing ASCII spaces at `text_refusal`'s own
admission point. Prove the paired inputs from the study land on one identical canonical fact --
true agreement, rather than an accidental identical row. Prove the all-space case routes to
`.reason = .empty`. The source-order witness and `ReceiptCard`/`ReceiptAccessibilitySnapshot` keep
their present shape; they simply receive an already-canonical value. The row collision the study
found resolves on its own, once there is one fact to draw rather than two.
