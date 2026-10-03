---
layout: project
date: "2026-09-10"
title: TeamDriveAway
nav_exclude: true
fetch_readme: false
live: https://teamdriveaway.com
description: "Moved the site off a legacy CMS onto Astro and Sanity, including the content schemas and GROQ queries."
badges:
- name: Astro
- name: Sanity CMS
- name: GROQ
images: []
order: 5
role: Client work at CodeNote
---

TeamDriveAway's site ran on a legacy CMS. As client work at CodeNote, I rebuilt it in December 2025 on [Astro](https://astro.build/), with [Sanity](https://www.sanity.io/) as the content backend.

I set up the Sanity project and wrote schemas for the home, service, and driver pages, plus reusable blocks like icon grids, advantage grids, and calls to action. Each schema has a matching Astro component, and the GROQ queries feed content into them. Once the pages were built and populated, I removed the schemas and components nothing used.

Editors control more than text. Sections take column counts and layout splits, the hero has a height setting, and rich text supports custom colors and alignment. The footer and navigation come from Sanity too, so a design change doesn't need a deploy. Dynamic `[slug]` pages are prerendered, which gives every GROQ query valid parameters at build time.

The quote, contact, and driver interest forms check reCAPTCHA on the client and submit through proxy API routes, so credentials stay in environment variables instead of the browser. When the work was done, I wrote up the CMS setup and a content editing guide for the people maintaining it.

I wrote up how the content model, forms, and handover work in [Rebuilding TeamDriveAway on Astro and Sanity](/rebuilding-teamdriveaway-on-astro-and-sanity/).

[Visit TeamDriveAway](https://teamdriveaway.com)
