# Matklad — project-wide semantic understanding

**Honors:** Alex Kladov (matklad) — original author of IntelliJ Rust and rust-analyzer

**Sources:**

- Resume and writing: <https://matklad.github.io/>
- rust-analyzer architecture: <https://github.com/rust-lang/rust-analyzer/blob/master/docs/dev/architecture.md>
- Series: "One Hundred Thousand Lines of Rust"

**Role for us:** The grain-sketchbook credited Matklad for **project-wide semantic understanding** — a whole workspace held as a resolved model, not file-by-file fragments. Aurora's editor head in that archive mapped Tree-sitter AST nodes into a shared graph; today's tree reaches the same ground through **Weave**, **bolt**, and **Tilak** rather than one closed enum across consumers. The lesson is architectural: understand the whole honestly, then let each surface read only what it needs.

**Clean room:** We study public architecture docs and essays; we never copy rust-analyzer source into our modules. The Realidream lane's gratitude shelf seats this name formally per the maintainer's word (`20260708.174500`).

**Cross-ref:** [`../construction/ROADMAP.md`](../construction/ROADMAP.md) — Visual Track · [`../external-research/date/20260708/20260708-021912_grain-sketchbook-realidream-mining.md`](../external-research/date/20260708/20260708-021912_grain-sketchbook-realidream-mining.md) · distilled teachings [`../external-research/date/20260712/20260712-093812_matklad-teachings-distilled.md`](../external-research/date/20260712/20260712-093812_matklad-teachings-distilled.md)

**See also:** [`tigerbeetle/`](tigerbeetle/) -- the same teacher walks us through TigerBeetle's own machinery across the IronBeetle series. Written through episode 045 except 023, 026, 027, 029, 031, 037, 039, and 041. The five long-open gaps, 003, 007, 016, 017, and 024, were filled `20261006.005136`. Own-voice silos (tracked; submodule stays unmodified): [`ironbeetle/`](ironbeetle/).
