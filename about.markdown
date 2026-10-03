---
layout: page
title: About
permalink: /about/
profile_page: true
seo:
  type: WebPage
---

I'm Aniket Patidar, a software engineer based in India. I joined [CodeNote IT Solutions](https://www.codenote-it.com/) as an intern in 2022, became an associate software engineer in 2023, and have been a software engineer there since 2025. Much of that time has gone into Rails backends for fintech, with PostgreSQL underneath and TypeScript, React, or Next.js on the frontend when a project needs it.

## What I've worked on

This is the short version. [My career page](/career/) goes through everything year by year.

**For [Kreditz](https://kreditz.com)**, a credit and risk decisioning platform and a CodeNote client:

- Led the production upgrade of their external API from Rails 6.1 to Rails 8.0.1, with zero downtime. [How the upgrade went](/upgrading-a-fintech-rails-app-from-6-1-to-8/).
- Integrated [Yapily](https://www.yapily.com/) alongside Klarna, so the platform keeps access to bank data during third-party outages. [How the integration went](/integrating-yapily-into-a-multi-provider-open-banking-app/).
- Built lending flows and credit-scoring pipelines that process users' bank transaction data.
- Built financial dashboards on the Fortnox and Visma accounting APIs.
- Fixed a slow admin login by speeding up the dashboard behind it. I added indexes, creating them concurrently so the table never locked, tightened the scopes, and dropped count queries nothing needed.
- Stopped PDF reports from timing out by building them from stored data instead of recalculating on every download.
- Kept live bank-connection updates working across browsers. On iOS 17.5, Safari dropped the Action Cable socket when users navigated away to authenticate with their bank, and Firefox missed broadcasts sent before its subscription was ready. [How I tracked both down](/action-cable-updates-safari-and-firefox-lost/).
- Built form flows that the backend configures per client: the sequence of forms and fields comes from the database, and I later moved its setup out of a rake task into service objects with RSpec coverage.
- Built the charts and tables for a corporate financial report that renders the same in the browser and in Wicked PDF, which runs an older JavaScript engine.
- Fixed security issues: timing-safe token checks on internal API endpoints, `YAML.safe_load` in place of hand-rolled parsing, personal data removed from URLs, and a Twilio upgrade so a patched JWT library could be installed.

**Other client work at CodeNote:**

- [MyWearToday](/projects/myweartoday/): an AI-powered digital closet on Next.js. Classification, outfit suggestions, and virtual try-on run as Inngest background jobs on the Gemini API and Vertex AI, with credit-based billing on Razorpay.
- [Printrizz](/projects/printrizz/): a print-on-demand marketplace on NestJS and Next.js. I built its product-variant data model, per-placement design previews, Razorpay checkout, shipping through Delhivery, and influencer referral commissions.
- [TeamDriveAway](https://teamdriveaway.com): I moved the site from a legacy CMS to Astro and Sanity, and wrote its content schemas and GROQ queries.

## Open source

- **[Moneygun](https://github.com/yshmarov/moneygun)**, a Rails SaaS boilerplate. I built its notification system on the Noticed gem, with email delivery and live in-app updates through a custom Turbo Stream delivery method ([PR #286](https://github.com/yshmarov/moneygun/pull/286)). The live updates didn't show up in development at first, and the cause turned out to be Action Cable's `async` adapter. [How I tracked it down](/contributions/full-in-app-notification-system-using-the-noticed-gem/).
- **[Human Essentials](https://github.com/rubyforgood/human-essentials)** by Ruby for Good. I fixed a purchase form that lost the chosen storage location after a failed save ([PR #4215](https://github.com/rubyforgood/human-essentials/pull/4215)), and stopped kits from being saved with negative quantities, a fix I redesigned during code review ([PR #4163](https://github.com/rubyforgood/human-essentials/pull/4163)).
- **[KlinicCon](https://github.com/rt4914/KlinicCon-Backend)**, an open-source healthcare platform. I added four Rails models for doctors' places of practice, built a shared React `Input` component, and wrote the contribution guide and PR template. [Details](/contributions/frontend-backend-contributions-to-the-healthcare-platform/).
- I've also made smaller fixes: the TLS port in Enable Banking's [open banking eIDAS broker](https://github.com/enablebanking/open_banking_eidas_broker/pull/60), a heading on [rubyonrails.org](https://github.com/rails/website/pull/236), and a curl example in the GitLab docs. [All contributions](/contributions/).

## Writing

I write here about Rails and the problems I run into at work. The [posts](/posts/) are where I work things out in public.

## Get in touch

The fastest way to reach me is email: [aniketpatidar01@gmail.com](mailto:aniketpatidar01@gmail.com). I'm also on [LinkedIn](https://linkedin.com/in/aniketpatidar) and [GitHub](https://github.com/aniketpatidar). My [resume](/resume/) has the full history.
