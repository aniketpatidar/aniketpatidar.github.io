---
layout: page
title: Career
permalink: /career/
description: "Everything I have worked on at CodeNote since 2022, year by year: open banking and credit decisioning for Kreditz, a Rails 8 upgrade, and client products."
---

This is the long version of my [About](/about/) page: everything I've worked on since I joined [CodeNote IT Solutions](https://www.codenote-it.com/) in 2022, in order. I kept a daily work log the whole time, and this page is written from it.

Most of it is client work for [Kreditz](https://kreditz.com), a Swedish platform that lets lenders check a person's or a company's finances through open banking and make credit decisions. Its platform is a set of Rails services behind a client portal, a React admin portal, an external API, and an iframe that lenders embed in their own sites. End users connect their bank through it, and lenders get back a certificate: a report of income, spending, and risk built from the transactions. From 2025 I also worked on three other client products.

The Kreditz names that come up below:

- **Vista**: the client portal lenders use.
- **External API**: the API lenders integrate with.
- **Auth microservice**: handles sign-in.
- **Admin portal**: a React frontend.
- **Alta**: Kreditz's analytics and decisioning service.
- **BKSP and UDCS**: the sources for accounting data and Swedish Tax Agency data.
- **Staging servers**: pre-vista and pre-vista-3, and later vista-dev and a sandbox.

## Software Engineer Intern, Sep 2022 to Feb 2023

I started on the customer-facing bank connection flow and the client portal.

**Markets and localization.** I tested the Dutch rollout across the three ways a request starts (manual request, API, and iframe), checked the SMS templates for the Netherlands, and added Belgium as a market in the request log. I also adjusted the bank list and consent views so they lined up with each other.

**Phone numbers.** The phone field had to show only the lender's own markets and warn when the number's country didn't match the market. I stored the dialling code in its own column, explored intl-tel-input, added masking and validation, stripped spaces and dashes, and permitted the field on the user create, edit, and profile forms.

**Read-only sub-accounts.** Lenders wanted accounts that can see the request log and nothing else. I added the filters and checks that hide every other feature when a sub-account is set to read-only.

**Identity numbers in the iframe.** For Defero's Finnish iframe I saved the personal identity number the user typed and wrote its validation. The Finnish format (PPKKVVYNNNT) excludes the letters G, I, O, and Q in the check position, and the field also had to reject underscores, brackets, and backticks.

**Two-factor login for admins.** I added two-factor authentication with one-time codes from `active_model_otp`: a secret key per admin, a verification step in the sessions controller, and codes sent by email. I also made sure the secret never went out over a WebSocket message.

**Collector Bank and certificate PDFs.** I worked through Collector Bank's feedback on the bank list and consent views, and on making the certificate's tabs modular, so a PDF includes only the tabs a lender has turned on, with page breaks between tabs and graphs that match each view.

## Associate Software Engineer, Mar 2023 to Feb 2025

### 2023: configurable forms and a new bank provider

**Forms the backend configures.** A lender in Denmark needed users to fill in a series of forms before connecting their bank. I built it as a general feature rather than a one-off, and renamed it from "Danish flow" to "customized flow" with its own setting:

- An endpoint that creates a request and receives its payload in the same call.
- Forms rendered in a sequence the backend defines, with a table of reusable components, the current form tracked in the session, and a guest session holding answers before the user is known.
- Fields prefilled from the payload or from an earlier submission, the same form returned with its data after a reload, and per-lender CSS stored with each form.
- Select and radio options stored as JSON on the component, with a reload that fetches fresh options from the lender's system. Components can also nest.
- A `postMessage` to the parent page once every form is done, so the lender's site knows when to move on.

**Live status over Action Cable.** This was my first Action Cable work: a channel that pushes a request's status to the browser, which hides the spinner or shows the bank list when the backend is ready, and a custom loader each lender can turn on.

**Partner responses and sandbox mode.** I added user details and partner IDs and names to the responses sent to brokers and partners. Swedbank and Sparbankerna declined sandbox connections when an identity number was passed, so I stopped sending identity numbers to banks in the sandbox, and wrote rake tasks that switch chosen providers, personal and business, into sandbox mode. I also split the identity number into two fields, the one the lender sent and the one the user entered on the consent page, so mismatches could be traced.

**Integrating Yapily.** From August 2023 I integrated [Yapily](https://www.yapily.com/), an open banking provider, next to Klarna and Enable Banking. I wrote it up in [Integrating Yapily into an open banking Rails app](/integrating-yapily-into-a-multi-provider-open-banking-app/).

- Authentication, the bank list, consent creation, and the callback that exchanges the authorization code.
- Bank customer, bank, account, and transaction records built from Yapily's responses.
- A second bank's consent in multi-bank requests, plus fixes where the flow broke during bank data processing.
- Live and sandbox credentials, a rake task that syncs Yapily's institutions by country, and renaming methods that clashed with the Klarna and Enable Banking services.
- Transactions fetched for a date range, and a form that asks for the PSU ID when a corporate bank requires it before authorization.

**Other 2023 work.** Swedbank's decoupled login in the Enable Banking sandbox. UI changes for Axactor's flow. A custom consent page with a bank dropdown for Defero, and a fix for Danske Bank users who weren't sent back to Defero's site after authenticating. Leo Vegas's bank list height. A certificate scrollbar that opens on the latest month. A setting that controls whether opening a category in the monthly view closes the others. Fixes for Excel downloads that returned a 500 error or a zero balance for Kindred, and failed on child requests for Banky. And an exploration of OAuth 2.0's client-credentials flow.

### 2024: sharper flows, validation, and a corporate report

**Cleaning up the bank data code.** I made Klarna processing skip fetching accounts and balances when the bank data already existed and stop duplicating sessions. I merged two admin refetch actions that were copies of each other, one for Enable Banking and one for Klarna, into one that works for any provider. I also removed a microservice call that several controllers made separately, enabled `force_ssl`, and spent a few weeks removing an unused model and dashboard actions, then tested every flow afterwards.

**Bank selection.** I moved Santander's dynamic flow off its own default and onto the general setting for picking a single bank from the multi-bank view, and set up Skanska's flow on it. Bank credential fields for Enable Banking banks like Handelsbanken and SEB got descriptions and placeholders per bank, stored as JSON templates on each provider and translated. Collector Bank's iframe got its own credential fields.

**Validation on the consent page.** I validated personal and company identity numbers as the user types, with errors under each field that appear on blur and clear once fixed. The submit button stays disabled until everything is valid, including whitespace-only input and text cut or pasted with the mouse. Each lender can turn this on, it shared one script across every lender's layout, and I wrote it up for the team.

**Live updates on Safari and iOS.** After the iOS 17.5 update, Safari stopped receiving Action Cable updates when users left the page to log in to their bank. I overrode `ActionCable.Connection.prototype.close` so the socket stayed open until the data arrived, then restored it, and handled `beforeunload` so connections closed cleanly. [The write-up](/action-cable-updates-safari-and-firefox-lost/) covers this and the later Firefox bug. I also stopped iPhone Safari from zooming in on inputs, first in Santander's layout and then as a setting for every lender.

**Filtering transactions.** Lenders could ask for income or expenses only. I saved the filtered data and made the certificate follow it: tabs that don't apply are hidden in the web view and the PDF, search respects the active tab, and empty tabs say why.

**Other 2024 flow work:**

- Clear, translated messages when a bank login fails, shown in the user's portal language.
- A tooltip on the refetch button showing whether the bank session token had expired.
- Unique client reference IDs enforced across all four API versions.
- A setting that lets partners turn off callbacks on shared requests, and partner details stored for every broker, starting with Klara Lån.
- The average time from request to certificate opened, in IKANO's Vista statistics tab, with a switch to hide it.
- Data fetched for a specific time period for Kindred.
- Duplicate JavaScript removed from Zmarta, Axactor, Defero, Monetti, Landshypotek, and Sambla's layouts.
- C Finance's send-payload integration debugged (missing mandatory keys left requests stuck in processing), and the same API tested for Northmill, Savelend, and Ferratum.
- Each request's bank account included in API responses.
- Account data uploads moved out of the controller into the model.
- An early-refetch categorization path that updates balances only on regular refetches.
- Parameters added to the iframe documentation that had been missing.
- Documentation for the multi-provider feature, Santander's dynamic flow, and identity number validation.

**Yapily, continued.** I made Yapily fit the new multi-provider setup. The worker now checks that consent is still authorized before refetching. UK consents are looked up by institution and user ID. Accounts without an account number can be saved. And admins can refetch from the admin portal.

**A corporate financial report.** From August 2024 I built much of the frontend and data mapping for version 2.0 of the corporate certificate, which reports on a company from its bank and accounting data:

- Overview, cash flow, growth, profitability, balance sheet, and discrepancies tabs, first against sample JSON, then mapped to Alta's real output as its structure changed.
- Reusable Highcharts templates (column, column-line, donut, and grouped charts), generic tables, collapsible rows, scrollbars for long series, axes that rescale to the visible bars, and a second percentage axis.
- The same charts rendering in Wicked PDF, which needed separate chart code for PDFs.
- Year filters, CSV and XLSX export, and figures shown with units, a dash for zero, and "n/a" for missing data.
- Styles scoped to the new pages so they stopped leaking into other tabs, plus IT documentation.

**Performance.** Two problems ended 2024:

- *Slow PDF reports.* PDF reports timed out because each download recalculated everything. I changed them to build from data uploaded per tab after the request finished, and made sure the download events fire only after that upload.
- *Slow admin login.* It was slow because of the dashboard behind it. I added indexes, created concurrently with `disable_ddl_transaction!` so the table never locked, tightened the scopes, and removed request counts nothing used.

I also set up BKSP and a refetch worker for its accounting data, and fixed the category order Banky reported in the spending tab, which had no explicit ordering, so parent and child categories are alphabetical everywhere, and updated Highcharts to version 11.

**Starting the Rails upgrade.** In late December 2024 I started upgrading the app from Rails 6.1 to Rails 8.0.1. More on that below.

## Software Engineer, Mar 2025 to now

### The Rails 8 upgrade

The upgrade ran from December 2024 to April 2025, alongside other work. I wrote it up in more detail in [Upgrading a fintech Rails app from 6.1 to 8.0](/upgrading-a-fintech-rails-app-from-6-1-to-8/).

- **Dependencies.** I updated database_cleaner, rspec-rails, stronger_parameters, and net-smtp.
- **Rails 8 changes.** I moved enums and `serialize` to the new syntax. Two serialized columns had to switch from the JSON coder to YAML because the JSON one was failing. I resolved enum name conflicts, replaced `fixture_path` with `fixture_paths` and `Dir.exists?` with `Dir.exist?`, and fixed a Sidekiq batch callback that stopped firing.
- **Configuration.** Settings moved from secrets to credentials and then to environment variables, including integers and multi-value settings. I went through the configuration guide and replaced outdated settings, and CI got `SECRET_KEY_BASE`.
- **Assets.** I tried Propshaft and adapted Wicked PDF to it, then went back to sprockets-rails because nothing needed the change. I kept Uglifier instead of Terser for the same reason.
- **Behaviour that changed quietly.** Some `after_commit` callbacks stopped firing because Rails 8 changed their order, so I restored the old order. I kept the message serializer on `:marshal` so old and new versions could read each other's signed and encrypted messages during the rollout.
- **Testing.** I ran the app locally with `RAILS_ENV=production`, then on the pre-vista-3 staging server. I went through every flow: API, iframe, and manual requests, continuous access, partner and municipality flows, Santander's flow, send-payload, each open banking provider (Yapily, BKSP, Enable Banking), report and PDF downloads, and the admin portal. That testing turned up bugs like a worksheet name over Excel's 31-character limit and a missing log because of a stdout logger setting. I also removed a custom PgHero patch and fixed Nordea showing twice because it was enabled for both Enable Banking and Kreditz's own provider.

### Kreditz, 2025 to 2026

**Code quality.** I fixed the code smells RubyCritic found in the Organization model (duplication, nil checks, unclear names) and centralized request-type mappings in one initializer. I logged provider errors in one place, with Slack alerts. I also removed a dashboard controller and worker classes that duplicated a common worker, and wrote specs for the user-mismatch check. I removed Wästgöta Finans's legacy response code once their V2 response was confirmed working.

**Security.** I worked through a series of fixes:

- Personal data removed from flow URLs.
- Security headers: `nosniff`, a referrer policy, and a cross-origin resource policy. HSTS was tried and then left to the firewall.
- Login password fields allow up to 64 characters.
- Internal API endpoints check an app token with `ActiveSupport::SecurityUtils.secure_compare` and explicit presence checks.
- An unauthenticated broadcast endpoint locked down.
- Partner IDs parsed with `YAML.safe_load` instead of a quote-swapping `JSON.parse`.
- twilio-ruby upgraded from 5.77 to 7.8.5 so a patched JWT version could be installed.

**Income data from Skatteverket.** I built the certificate tab that shows a person's income as reported to Skatteverket, the Swedish Tax Agency, through UDCS:

- Charts by employer, with each payment coloured by how late in the month it was reported, using rules seeded from a CSV.
- Foreign income in several currencies.
- 3- and 6-month averages with empty months counted, and estimated annual income.
- Sole proprietorship data, and SSN and name filled in from the UDCS response when a request lacked them.
- A redesign with year-on-year growth and a breakdown of transaction income.
- A FASCO tab that appears whenever a UDCS connection exists.
- PDF versions throughout, which meant replacing ES6 `includes()` with `hasOwnProperty()` for Wicked PDF's older JavaScript engine and setting Highcharts 11's colour palette explicitly so PDFs matched the web view.

Later I switched it from our own formatter to Alta's `/tax_agency` endpoint and cached the response in S3. I also moved DNB's income endpoint from GPS to Alta, and stored Alta's raw responses in an S3 analytics bucket from a background worker.

**Configurable flows, version 2.** The 2023 form flows came back as dynamic flows with a summary page that combines every submitted form, prefilled bank data, and new flows for Santander, Collector, and Kreditz's default flow. The setup lived in a large rake task, so I rewrote it as service objects (`BankPayloadFormBuilder`) that update existing records instead of deleting them, with RSpec coverage for each. I also logged every form and component submission as an event.

**Requests and redirects:**

- Manual requests can preselect banks and data sources and skip bank selection. A Select2 picker loads providers from a service object, and the same prefill works for API and iframe requests.
- FASCO's flow is triggered from a Kreditz ID matrix through provider profile mappings, with CRUD APIs for the admin portal.
- Reusing a link after its bank connection now returns the right status by `postMessage` instead of starting over.
- I added a `UrlBuilder` concern so redirects stop producing URLs with two question marks, and fixed Santander's error page, which dropped its query parameters on Close. I also handled cancellations from Enable Banking's Tilisy page and built Santander's 206 customization.
- Firefox missed `postMessage` events because broadcasts went out before the subscription existed. I delayed the broadcast, and turned off Turbo on the dynamic form, where it fought with Action Cable.
- A 403 seen only in the sandbox turned out to be the web application firewall reading a redirect URI as command injection.
- Temporary 5xx errors from a provider no longer cancel a user's bank request. Only a real "not found" does.
- Banks that are unavailable in the sandbox are skipped instead of showing a white screen.

**Testing support.** In the sandbox, chosen test identity numbers now trigger specific provider errors, so lenders can test their error handling.

**Smaller pieces of 2025 to 2026 work:**

- Creditor and debtor names in transaction responses for Qred, as a per-lender setting, after comparing how Tink, Enable Banking, Klarna, Nordigen, and others represent them.
- A bank priority column for ordering the bank list.
- A bank account number for Collector's account verification flow, falling back to the IBAN.
- SMS reminders formatted in E.164, which fixed delivery to Norway.
- Refetches that return only new transactions when asked to.
- Faraday's `NestedParamsEncoder` so array parameters reach Rails correctly.
- S3 storage tested locally against LocalStack, with integration specs.
- Keyboard focus and ARIA fixes on the bank selection pages.
- Corporate financials moved to Alta's single cached accounting-data endpoint, with a data-driven warning-indicators table.
- A CSV of bank connection frequency per market.
- API documentation moved into kreditz-services-documentation, nokogiri bumped in the client portal and the auth microservice, and paper_trail versioning added to Maglev CMS pages.

### Printrizz, Apr 2025 to Jan 2026

A print-on-demand marketplace. I started it as a Rails prototype (passwordless login, money-rails, Dropzone uploads, and a Fabric.js demo that clips artwork onto a product). From June 2025 it's a NestJS API on Prisma with a Next.js frontend. I built the variant data model, per-placement design previews, the cart and Razorpay checkout, item-level fulfilment, Delhivery shipping behind a courier interface, influencer referral commissions, seller wallets, WebSocket notifications, short links and social sharing, PDF order sheets, and soft deletes. [The project page](/projects/printrizz/) and [the write-up](/printrizz-variants-orders-and-shipping/).

### TeamDriveAway, Dec 2025 to Mar 2026

As CodeNote work, I rebuilt the website of TeamDriveAway, a freight and vehicle-transport company, on Astro and Sanity: the content schemas and the matching Astro components, CMS-driven navigation and footer, forms behind reCAPTCHA and proxy API routes, a scrolling alert banner, and a guide for the people editing it. [The project page](/projects/teamdriveaway/) and [the write-up](/rebuilding-teamdriveaway-on-astro-and-sanity/).

### MyWearToday, Feb 2026 to now

An AI digital closet on Next.js. Classification, outfit suggestions, and virtual try-on run as Inngest jobs on the Gemini API, Vertex AI, and LightX, and retrieval uses PostgreSQL full-text search. Realtime updates run on Firebase. It also has Razorpay credit billing, a Telegram bot, and an Android app that wraps the site, with push notifications. [The project page](/projects/myweartoday/) and [the write-up](/building-myweartoday-ai-jobs-realtime-and-credit-billing/).

## Alongside work

I've contributed to open source along the way, including the notification system in [Moneygun](https://github.com/yshmarov/moneygun/pull/286) and fixes in Ruby for Good's [Human Essentials](https://github.com/rubyforgood/human-essentials/pull/4215). They're all on the [contributions page](/contributions/). CodeNote named me Star Performer of 2024 and Creative Thinker of the Quarter.
