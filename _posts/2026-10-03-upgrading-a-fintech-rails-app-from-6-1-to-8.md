---
layout: post
title: "Upgrading a fintech Rails app from 6.1 to 8.0"
description: "Upgrading Kreditz's Rails app from 6.1 to 8.0.1: the errors took days, the changes that raised nothing took weeks, and how a staging server caught them."
permalink: /upgrading-a-fintech-rails-app-from-6-1-to-8/
tags: ruby-on-rails, upgrades
featured: true
---

I upgraded [Kreditz](https://kreditz.com)'s main Rails app from 6.1 to 8.0.1 between December 2024 and April 2025. Most of the errors were fixed in the first two weeks. The rest of the time went on changes that raised nothing. Callbacks stopped firing, a Sidekiq batch went quiet, and log files stopped appearing. I only found those by running every flow by hand on a staging server of its own.

*Versions: Rails 6.1 to 8.0.1.*

## The app and the constraint

Kreditz is a Swedish open banking platform. Lenders send their customers through it to connect a bank, and get back a report on income, spending, and risk. The Rails app behind it serves the client portal lenders use and four versions of the lender API. It also talks to Yapily, Klarna, and Enable Banking, runs Sidekiq jobs, pushes live status over Action Cable, and renders PDF reports with Wicked PDF. A lot of that is hard to cover with specs, like a PDF render, a redirect to a bank and back, or the admin portal calling the API.

Feature work didn't stop for the upgrade. I did it in a long-lived branch between other tasks, rebasing onto main as main moved, and in late January I set it aside for a couple of weeks. A branch keeps main safe, but it drifts, and every rebase is a chance to lose something. GitHub and Shopify both upgraded on main instead, with a dual boot.

## Errors the specs caught

Going from 6.1 to 8 crosses several releases' worth of removals, and most of them showed up at boot or in the suite.

Rails 8 removed the keyword form of `enum`, so every declaration moved to the positional form. `OrganizationRequest` also raised an `ArgumentError` over conflicting enum definitions, which I refactored. `serialize` now takes its coder as a keyword. The JSON coder failed on two columns, `notes` and `payload`, so they use YAML:

```ruby
# before (enum values are illustrative)
enum status: { pending: 0, accepted: 1 }
serialize :notes

# after
enum :status, { pending: 0, accepted: 1 }
serialize :notes, coder: YAML
```

The rest were small. database_cleaner, rspec-rails, and stronger_parameters needed newer versions. net-smtp had to go into the Gemfile, since newer Rubies stopped bundling it and the mail gem depends on it. `fixture_path` became `fixture_paths`, and `Dir.exists?` became `Dir.exist?`.

## Settings and assets

`Rails.application.secrets` is deprecated, so the app's settings had to move. They went to per-environment credentials first, then to environment variables. The second move had a cost I didn't see coming: environment variables are always strings. Settings that used to be integers or lists showed up as `"30"` and `"a,b"`, so I changed how those values are read and fixed the specs that relied on the old types.

Rails 8 defaults to Propshaft, so I tried it. I got it working with Wicked PDF, whose stylesheet paths came out without the right extension, and then went back to sprockets-rails anyway. Nothing in the upgrade needed a new asset pipeline, and with the pipeline unchanged, any bug I hit had to come from Rails. I kept Uglifier over Terser for the same reason.

## The changes that raised nothing

Each of these passed the test suite.

Since Rails 7.1, `after_commit` and the other transaction callbacks run in the order they're defined. Before that, they ran in reverse. Some of the app's callbacks relied on the old order, and on staging some of them stopped triggering. Rails keeps a setting for the old behaviour, and I used it:

```ruby
config.active_record.run_after_transaction_callbacks_in_order_defined = false
```

It got the upgrade out, but it leaves a debt. The callbacks still depend on an order nobody wrote down, and only this setting keeps them working.

Newer defaults also change how signed and encrypted messages are serialized. Messages written by the old version had to stay readable on the new one, so I kept `:marshal` and used the same setting on both deployments:

```ruby
config.active_support.message_serializer = :marshal
```

A Sidekiq batch callback stopped triggering too, and needed its own fix. A callback that never runs doesn't raise anything, so the only way to notice is to check that the work after it happened.

On staging, log files stopped being created. A logger configured to write to STDOUT was the cause, and removing it brought them back.

The deprecation warnings told me about `fixture_path`, but nothing warned me about the callbacks. The upgrade guides do describe that change, so they're worth reading for changes in behaviour as well as for removals.

## How the silent changes were found

The specs passed long before the app worked, so I tested it the way production runs it, in three passes.

First, I ran the app locally with `RAILS_ENV=production`, which turns on eager loading and production configuration. That caught a gross income PDF that failed to generate.

Second, in February 2025 the branch went to a staging server of its own, where I worked through every flow by hand:

- API, iframe, and manual requests, with one bank and with several
- continuous access, partner flows, the municipality flow, and send-payload
- each open banking provider
- CSV and PDF reports
- the admin portal pointed at the staging API

That pass found the callback order problem. It also turned up an uninitialized constant that only appeared through the admin portal, an Excel worksheet name over Excel's 31-character limit, and an error uploading PDF data. With the server to myself, the branch could sit there for weeks without blocking anyone else's deploys.

Third, the upgrade went to the shared staging server. I repeated the flows there and added the external API through Postman, the health check dashboard, event logs, and statistics.

## What I'd do differently

Next time I'd dual-boot instead of branching. GitHub upgraded from Rails 3.2 to 5.2 by making its main branch bootable on two Rails versions at once, with a CI job per version that became required as each one went green. Shopify did the same for Rails 5, with a lockfile per version switched by an environment variable. Each fix lands in main as soon as it's ready, so there's nothing to drift. My branch got there, but I paid for it in rebases and in a two-week pause that left it stale.

I'd also turn the flow list into tests. That manual list found every silent change in this upgrade, and most of it could become request specs, so the next upgrade doesn't depend on someone clicking through every flow again.

And I'd pay down the callback debt. Restoring the old order was the right way to ship, but those callbacks should work in any order, so the setting can go.
