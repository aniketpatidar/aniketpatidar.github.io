---
layout: project
date: "2026-09-10"
title: aniketpatidar.com
nav_exclude: true
fetch_readme: false
live: https://aniketpatidar.com
description: "This site: Jekyll on the Minima theme with custom layouts and structured data. A weekly GitHub Action pulls each project's README into its page."
badges:
- name: Jekyll
- name: GitHub Pages
images: []
order: 6
role: Personal project
---

This site is built with [Jekyll](https://jekyllrb.com/) on the Minima theme, with my own layouts, includes, and styles on top. It's served from GitHub Pages on a custom domain.

The project pages update themselves. A weekly GitHub Action (`scripts/fetch_readmes.rb`) fetches each project's README and writes it into the page, below anything I've written above it.

Posts carry `BlogPosting` structured data with me as the author, and the About page describes me as a `Person` with links to my profiles. AI agents get an `llms.txt` describing the site, and a Cloudflare Worker serves them Markdown versions of pages when they ask.
