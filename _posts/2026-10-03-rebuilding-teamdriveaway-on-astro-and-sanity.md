---
layout: post
title: "Rebuilding TeamDriveAway on Astro and Sanity"
description: "Rebuilding a transport company's site on Astro and Sanity: the real design work was the content model, meaning which sections exist and which choices editors get."
permalink: /rebuilding-teamdriveaway-on-astro-and-sanity/
tags: astro, sanity, cms
---

In December 2025 I rebuilt [TeamDriveAway](https://teamdriveaway.com)'s website on [Astro](https://astro.build/) with [Sanity](https://www.sanity.io/) as the CMS. Writing the components was the routine part. The decisions that shaped the site were in the content model: how to cut pages into reusable sections, and how much of each section's layout to hand to editors. Much of the work after the first pages went up was that second question.

*Versions: Astro, Sanity Studio, GROQ. The site and the Studio live in separate repositories.*

## The site

TeamDriveAway is a vehicle and freight transport company. Its site has a homepage, service pages for each kind of move (drive-away, freight, last-mile, speciality), a driver recruitment page, careers, a quote form, contact, FAQs, terms, and pages for team solutions. I built it as client work at CodeNote. The main build took most of December, and changes continued until March 2026.

## Pages are lists of sections

Every page in Sanity is an ordered list of sections, and each section type comes in two halves:
- a Sanity schema, which defines the fields an editor fills in
- an Astro component, which renders those fields

A GROQ query loads a page with its sections, and the page renders each one with its matching component. A new kind of section means writing both halves and registering the schema in the list of section types a page accepts.

I started with the homepage's sections: hero, service highlights, a feature grid, a logo cloud, testimonials, and rich text. Each later page reused what existed and added what it needed, like circular icon grids, advantage grids, image overlays, two-column layouts, alert banners, FAQ lists, and form sections.

The model makes adding a section cheap, which is also its weak spot. Sections pile up. Once every page was built, I removed every schema, section type, and component that nothing used.

## How many choices editors get

A section with no options keeps every page consistent, but editors can't adapt it. A section with many options adapts to anything, but every option is something an editor has to understand and a designer has to check. Options were added as pages needed them:

- **Column counts** on icon card grids and feature grids.
- **Split ratios** on two-column sections, either 30/70 or 50/50.
- **Hero height**, either tall or medium.
- **Rich text** with custom colours and centre alignment.
- **The footer**, with its call to action and its link groups, which moved into Sanity after a design update.

The last section added, in March 2026, was a scrolling alert banner for announcements. Its ticker pauses on hover and on keyboard focus, so it can be read by people who need it to stop.

## A bug at build time

Dynamic pages live at `[slug].astro`, and the team solutions pages built from it were unstable. Turning on prerendering for `[slug].astro` means every dynamic page gets valid parameters at build time, so its GROQ queries don't break.

## Forms

The quote, contact, and driver interest forms are built from shared form components:
- reCAPTCHA is checked in the browser.
- Submissions go through the site's own proxy API routes, so the credentials for the services behind them stay in server-side environment variables.
- Each form component takes its submission URL as a setting rather than hardcoding it.
- All forms share one success component.

## Handover

In February 2026 I wrote a guide to the setup: how Sanity and Astro connect, which repository holds what, and how to edit content. In March I added a guide for the alert banner.

## What I'd do differently

- **Ask for the design's variations before writing schemas.** Column counts, split ratios, and hero heights were added one at a time as pages needed them. A list of the variations the design uses would have put them in each schema's first version.
- **Prerender dynamic routes from the start.** The `[slug].astro` fix came after most pages were built.
- **Prune section types as you go.** One cleanup at the end worked, but pruning page by page keeps the Studio's list of section types short the whole time.
