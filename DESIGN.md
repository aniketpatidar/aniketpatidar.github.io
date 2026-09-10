---
name: Aniket Patidar
description: A warm paper reading room where the only color that speaks is the shipped-green of verifiable work.
colors:
  primary: "#1a7f37"
  secondary: "#0969da"
  accent-sky: "#0969da"
  ground: "#f6f2ea"
  surface: "#ffffff"
  surface-deep: "#efe8db"
  code-bg: "#efe8db"
  text-strong: "#24211c"
  text-body: "#403b33"
  text-soft: "#504a41"
  text-muted: "#6f675c"
  text-card-meta: "#70675a"
  rule: "#e0d8c8"
  rule-strong: "#cbc2af"
  placeholder: "#d8d0bf"
typography:
  display:
    fontFamily: Georgia, "Iowan Old Style", Charter, "Times New Roman", serif
    fontSize: "clamp(2.75rem, 8vw, 5.25rem)"
    fontWeight: 500
    lineHeight: 1.02
    letterSpacing: "-0.04em"
  headline:
    fontFamily: Georgia, "Iowan Old Style", Charter, "Times New Roman", serif
    fontSize: "2rem"
    fontWeight: 500
    lineHeight: 1.25
  title:
    fontFamily: Georgia, "Iowan Old Style", Charter, "Times New Roman", serif
    fontSize: "1.625rem"
    fontWeight: 500
    lineHeight: 1.3
  body:
    fontFamily: -apple-system, system-ui, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif
    fontSize: "1rem"
    fontWeight: 400
    lineHeight: 1.5
  label:
    fontFamily: ui-monospace, SFMono-Regular, SF Mono, Menlo, Consolas, "Liberation Mono", monospace
    fontSize: "0.72rem"
    fontWeight: 500
    letterSpacing: "0.02em"
  emoji-fallback:
    fontFamily: "Segoe UI Emoji", "Noto Color Emoji", Apple Color Emoji, Symbola
    note: Declared so emoji/icon glyphs are an explicit, allowed fallback and not a spec violation.
rounded:
  sharp: "0px"
  xs: "3px"
  photo: "4px"
  menu: "10px"
spacing:
  xs: "15px"
  md: "30px"
components:
  site-title:
    typography:
      fontFamily: Georgia, "Iowan Old Style", Charter, "Times New Roman", serif
      fontSize: "1.75rem"
      fontWeight: 400
    textColor: "{colors.text-strong}"
  nav-item:
    textColor: "{colors.text-body}"
    typography: "{typography.body}"
  hero-role:
    textColor: "{colors.text-muted}"
    typography:
      fontFamily: ui-monospace, SFMono-Regular, SF Mono, Menlo, Consolas, "Liberation Mono", monospace
      fontSize: "0.8rem"
      letterSpacing: "0.12em"
      textTransform: "uppercase"
  hero-name:
    textColor: "{colors.text-strong}"
    typography: "{typography.display}"
  hero-photo:
    size: "232px"
    radius: "{rounded.photo}"
    border: "1px solid {colors.rule-strong}"
  proof-list:
    textColor: "{colors.text-card-meta}"
    typography:
      fontFamily: ui-monospace, SFMono-Regular, SF Mono, Menlo, Consolas, "Liberation Mono", monospace
      fontSize: "0.85rem"
      lineHeight: 1.6
  hero-cta:
    textColor: "{colors.primary}"
    backgroundColor: "{colors.surface}"
    border: "1px solid rgba(26,127,55,0.4)"
    rounded: "{rounded.sharp}"
  project-plate:
    textColor: "{colors.text-body}"
    border: "2px solid {colors.text-strong}"
  plate-tag:
    textColor: "{colors.text-card-meta}"
    typography: "{typography.label}"
  rec-plate:
    textColor: "{colors.text-body}"
    border: "2px solid {colors.text-strong}"
  breadcrumb:
    textColor: "{colors.text-card-meta}"
    typography:
      fontSize: "0.85rem"
      lineHeight: 1.5
  breadcrumb-link:
    textColor: "{colors.primary}"
  read-more:
    textColor: "{colors.primary}"
---

# Design System: Aniket Patidar

## Overview

**Creative North Star: "Paper Ledger"**

A warm paper reading room built on the minima light theme. The page is a toned-off-white sheet (`#f6f2ea`), the type is near-black ink, and the only color that runs is the shipped-green of verifiable work (`#1a7f37`). Mastheads are set in the reader's serif; body text stays in the operating system's own sans; ledger metadata is set in monospace ticks. Structure is drawn with ink hairlines — and at the few moments that matter (the hero nameplate, a project or recommendation plate), with a firm 2px ink rule. Evidence — a merged pull request, a project plate, a recommendation — is marked the way code merges are marked: green.

The system is deliberately un-derivative of AI-generated design. There are no webfonts, no gradients, no glow, no glass. Density is calm: a single 800px column, generous vertical rhythm, and one accent hue used only where the ledger records something real. The personality is a quiet typesetter's desk: credible, legible, fast — an engineer's site where the substance is the content and the decoration stays out of the way.

**Key Characteristics:**
- Warm paper ground with ink-toned text at every tier (never pure white backgrounds, never pure black text).
- Serif display type (system Georgia/Charter stack) for mastheads and headings; system sans for body; monospace for ledger metadata.
- Structure is ink: 1px hairlines for the everyday, 2px ink rules for the nameplate and the plates of completed work. Shadows appear only on floating menus and as a warm 1–2px lift on interactive cards at hover.
- Shipped-green `#1a7f37` as the single brand accent, reserved for evidence-of-work surfaces: project links, tag ticks, plate stamps, recommendation names, hero CTAs. On-paper link blue (`#0969da`) carries ordinary prose navigation.
- Agentive CTAs and the largest surfaces are flat and square; only portraits (4px) and floating menus (10px) take a radius.

## Colors

The palette is a warm paper ledger with one green ink. On-paper blues carry body navigation; warm paper neutrals — never pure white, never pure black — carry surfaces and text.

### Primary
- **Shipped Green** (#1a7f37): The brand accent. Project links, breadcrumb links, hero CTAs, tag ticks, plate stamps, and recommendation names — anything that points at work that is real and done. It is the color of a merge. Hover deepens to `#0e6730`. Used on paper, it holds strong contrast (≈5:1+) for small text.

### Secondary
- **Ledger Blue** (#0969da): Default link color for ordinary body prose and footer contact navigation (the on-paper reading-room blue). A darker hover (`#0550ae`) warms on interaction.

### Neutral
- **Ground** (#f6f2ea): Page background. Warm paper, never pure white.
- **Surface** (#ffffff): Paper-white sheets — floating nav menus and hero CTAs that sit above the paper.
- **Surface Deep** (#efe8db): The active item in the collapsed mobile menu and code wells — the shaded reverse of paper-white.
- **Code Surface** (#efe8db): Inline and block code backgrounds.
- **Text Strong** (#24211c): Headings and the ink rules — ink near-black, never pure black. **Text Body** (#403b33): Body copy. **Text Soft** (#504a41): Site title support text. **Text Muted** (#6f675c): Hero role colophon, meta, dates, footer. **Text Card Meta** (#70675a): Proof list, plate tags, breadcrumbs.
- **Rule** (#e0d8c8): Default hairline — dividers, proof-list rules, code outlines. **Rule Strong** (#cbc2af): Photo borders and heavier hairlines.

### Named Rules
**The Green Means Shipment Rule.** Green is only ever used for evidence of completed work: links into projects, tag ticks, plate stamps, proof figures, hero CTAs, and the recommendation names of people who shipped it. It is never decorative, never a background fill, and never used for content that is not a real, shippable artifact.

**The Ledger's One Ink Rule.** Shipped-green is the only brand accent. If a design moment needs a second hue, it must be one of the existing on-paper blues (#0969da / #0550ae), not a new color invented for the moment.

## Typography

**Display Font:** Georgia, "Iowan Old Style", Charter, "Times New Roman", serif
**Body Font:** -apple-system, system-ui, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif
**Label/Mono Font:** ui-monospace, SFMono-Regular, SF Mono, Menlo, Consolas, "Liberation Mono", monospace

**Character:** The masthead and headings read like a journal set by a typesetter; body copy stays in the operating system's clean sans for long-form comfort; the ledger's metadata (proof list, tag ticks, role colophon, rec relationship) is set in monospace ticks. Nothing to download, nothing to render late, nothing to mismatch across platforms. Weight carries hierarchy: a 500 masthead, 500 headings, and 400 body.

### Hierarchy
- **Display** (500, `clamp(2.75rem, 8vw, 5.25rem)`, line-height 1.02, letter-spacing -0.04em): The hero name only. Fluid with the viewport, tight-tracking, runs on one or two quiet lines.
- **Role Colophon** (500, 0.8rem, mono, uppercase, tracking 0.12em, text-muted): Sits inside the nameplate beside the hero name — the masthead's small print, deliberately quiet, never a colored eyebrow above the name.
- **Headline** (500, 2rem, line-height 1.25): Page headings (`page-heading`) on static pages.
- **Title** (500, 1.625rem, line-height 1.3): Section headings, h3 within posts, plate titles.
- **Body** (400, 1rem, line-height 1.5): Default prose within the 800px column; long-form post copy.
- **Label** (500, 0.72rem, mono, tracking 0.02em): Plate tags and proof metadata — the ledger's mechanical voice.

### Named Rules
**The System-Type Rule.** Never add a webfont or @font-face. The pairing is the operating system's own families (serif display, sans body, mono ticks); importing a display face would make the site slower and louder for zero design gain.

## Layout

A single forgiving reading column: `.wrapper` max-width 800px, 30px side padding on desktop, 18px on mobile, centered. Vertical rhythm runs on a 15px base (headings and paragraphs) with 30px section blocks and 30px gaps between post-list entries.

- **Breakpoints:** 600px flips the header nav into the icon-only collapse menu; 600px also lays project plates out main-image side-by-side.
- **Hero:** the nameplate (name + role colophon) runs full width under a 2px ink rule; below it the lede, then a foot that places the proof + CTAs beside the 232px portrait on wide screens, stacked on mobile.
- **Projects & recommendations:** single-column ledger plates — one row per artifact, ink rules above and below, the figure beside the text at ≥600px and above it on mobile.
- Content hierarchy is top-down and left-aligned; the hero is the masthead of the sheet.

## Elevation & Depth

The system is **flat**. Depth is carried by ink hairlines and paper tone, not shadow; elevation is a state, not a resting property. Content lives on the sheet; only a floating menu lifts above it.

### Shadow Vocabulary
- **Card Rest** (`0 1px 2px rgba(70, 60, 30, 0.08)`): Nearly invisible; for interactive cards that do not float.
- **Card Lift** (`0 6px 16px rgba(70, 60, 30, 0.14)`): On hover for interactive cards, paired with a 2px upward translate. Also the resting shadow of the collapsed mobile nav menu, which genuinely floats above the sheet.

### Named Rules
**The Lift-on-Hover Rule.** A content card or plate sits flat at rest and moves only when the pointer arrives. Elevation on content is a response, never a permanent posture.

**The Menus-Float Exception.** A floating menu (the collapsed mobile navigation dropdown) is the one surface allowed to hold Card Lift at rest — a sheet that has left the desk may cast a shadow. No content surface may.

**The Hairline-Before-Shadow Rule.** Every boundary is first a hairline in the neutral rule tone (or a 2px ink rule where the ledger records work). Reach for a shadow only when an interactive element needs to lift above its neighbors; never use shadow to create structure that a border could define.

## Shapes

The form language is **flat ledger stock**: agentive controls and large surfaces are square, portraits carry a soft 4px rounding, and only floating menus round to 10px. No pill shapes, ever.

- **0px (sharp)** — hero CTA buttons: deliberate, square, the intelligence-of-a-form edge.
- **3px** — inline code, code blocks, code badges.
- **4px** — portraits: hero photo and recommendation photos. Square, gently set, never cropped into circles.
- **10px** — the floating mobile nav menu.

Borders are 1px hairlines in the neutral rule tone; the nameplate and each ledger plate close with a firm **2px ink rule** (`text-strong`). Green is applied as marks — tag ticks, plate stamps, links — not as fills or borders.

## Components

### Navigation
- **Shape:** flat header, `3px` shipped-green top rule, `1px` bottom hairline in the rule tone.
- **Masthead (Site Title):** serif 500, 1.75rem, text-strong. The quiet masthead of the sheet.
- **Nav Items (desktop):** body type, text-body; hover underlines; the active page is set in text-strong with a green underline.
- **Collapse (≤600px):** a bare icon-only trigger (SVG hamburger, no text, no border, no fill, right-aligned in the header). It opens a floating 10px-radius paper panel holding Card Lift, borders at rule-strong, list-style entries; the active item is marked with a surface-deep fill.

### Hero
- **Nameplate:** the display name at fluid clamp size, tight-tracked, with the mono role colophon beside or below it; the whole plate closes with a 2px ink-strong rule and 1.25rem of breathing room.
- **Lede:** body text at 1.125rem/1.65, max-width 52ch, following the nameplate.
- **Proof list:** monospace ticks at 0.85rem, text-card-meta, as disc bullets whose markers are shipped-green, bound by hairlines top and bottom. Numbers only where they are real (years, merged PRs).
- **CTA row:** 2 primary actions — proof (Projects) and credentials (Resume) — paper-white fill, shipped-green border/text, sharp corners, shipped-green hover.
- **Portrait:** 232px square, 4px radius, 1px rule-strong border, lightly desaturated so it sits inside the quiet reading room rather than shouting "photo card."

### Project Plate
- **Structure:** a ledger row — 2px ink rule above; title (serif, 1.625rem), description, and a meta line (mono tags with green ticks, then arrowed links) stacked on the main column; a framed figure beside it at ≥600px, above it on mobile.
- **Figure:** local screenshots at 16/10 `object-fit: cover`, edge to edge; GitHub og-screen captures at 19/10, uncropped so they read as evidence rather than a clipped card.
- **Links:** shipped-green with arrow-prefixed glyphs (→ Visit, ↗ external).
- **Interaction:** hover deepens green links; the plate carries no shadow and never lifts — it stays on the sheet.
- **Internal Padding:** 1.25rem–1.5rem; content stacks on a 0.75rem gap.

### Plate Tag
- **Style:** mono label type, `0.72rem`, weight 500, text-card-meta; preceded by a small shipped-green tick glyph.
- **Role:** stack/language labels on project plates. Never a pill, never a fill — always a real technology label.

### Recommendation Plate
- **Structure:** the same ledger row as a project plate; a serif quote opens with a large shipped-green “ mark, followed by a square 56px photo (4px radius), the name (shipped-green link), the headline, and a mono relationship citation (e.g. "Manager · 2022–2024").
- **Read More:** link toggles the clamped quote — shipped-green, underline on hover.

### Breadcrumb
- **Style:** 0.85rem, text-card-meta, bottom hairline, 1.5rem bottom margin.
- **Links:** shipped-green, underline on hover — breadcrumb trails point into other people's work, so they carry the shipment green.

## Do's and Don'ts

### Do:
- **Do** keep the warm paper ground (#f6f2ea) and ink-toned text at every tier (never pure white, never pure black).
- **Do** set mastheads and headings in the system serif and body in the system sans; no webfonts, no font files.
- **Do** draw structure with 1px hairlines and close the moments that matter — the nameplate, each ledger plate — with a 2px ink rule.
- **Do** reserve shipped-green (#1a7f37) for evidence-of-work surfaces only: links, ticks, stamps, CTAs, names.
- **Do** keep content flat at rest; only a floating menu may hold a shadow, and interactive cards may lift 1–2px on hover.
- **Do** keep agentive controls sharp (0px) and softness only to portraits (4px) and floating menus (10px).
- **Do** keep the homepage hero factual: proof figures must be real (years, merged PRs), never invented.
- **Do** keep semantic HTML and the site's discoverability layer intact (stable URLs, sitemap, robots, llms.txt).

### Don't:
- **Don't** use pure black (#000) or pure white (#fff) for surfaces or text.
- **Don't** add webfonts, icon fonts, or third-party type.
- **Don't** use gradient text, purple-to-blue accents, glassmorphism, glow, or particle decoration — the brand is the antithesis of generic AI-tool design.
- **Don't** put shadow on content at rest — elevation on content is hover-only, and only menus float.
- **Don't** introduce a second brand accent hue beyond shipped-green and the existing on-paper blue link tone.
- **Don't** pill-shape anything, don't crop portraits into circles, and don't fill tags or borders with green — green marks, it never fills.
- **Don't** turn tag ticks or green into decoration; every mark must map to a real artifact.
- **Don't** re-import the dark theme's palette: this world is paper and ink, green-on-paper — not near-black and gray.