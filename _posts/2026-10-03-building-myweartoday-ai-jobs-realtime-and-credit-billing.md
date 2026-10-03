---
layout: post
title: "MyWearToday: the work around the model"
description: "Building an AI wardrobe app on Next.js and Inngest: the model calls were the small part. Jobs, checked output, realtime updates, and billing were the rest."
permalink: /building-myweartoday-ai-jobs-realtime-and-credit-billing/
tags: nextjs, ai, inngest, billing
---

[MyWearToday](https://myweartoday.com) classifies photos of your clothes and suggests outfits from what you own. The model calls behind that are the small part. Most of the three and a half months I spent building it went into four things around the model. Calls had to run in the background, output had to be checked, users needed live progress, and billing had to charge correctly when something failed halfway. Each one went through at least one rewrite.

*Versions: Next.js and Prisma on PostgreSQL, self-hosted Inngest, the Gemini API, Node 22, Docker Compose.*

## The app

Users upload photos of their clothes. Each item is cut out of its photo, classified by type, colour, pattern, and style, and added to a digital wardrobe. Users can then ask for an outfit (say, "something for dinner"), get one built from their own items, and see it on themselves with a virtual try-on. Plans are Razorpay subscriptions that grant credits, and AI work spends them. I've built it since February 2026 as client work at CodeNote, including an Android app that wraps the site.

## 1. Nothing slow happens in the request

Processing a single photo means several steps:
- upload the image to S3
- remove the background with a separate `rembg` service
- classify the item with Gemini
- store an embedding

To cut request latency, the upload request now only saves the file to temporary storage and returns the item straight away, marked pending. An Inngest function does the rest. If a step fails, the item is marked failed and the user is notified. An item stuck in processing can be cancelled, and a daily job clears temporary files older than a day.

Outfit recommendations and try-ons run the same way. That's also what lets several recommendations run at once.

I set Inngest's retries to 1 instead of the default 5. The classification steps started as one function, and I later split them into separate stages under `lib/ai/clothing-pipeline`.

## 2. Model output is checked, not trusted

The first version parsed the model's replies with regular expressions. I switched to JSON output constrained by a schema and validated with Zod. Output that doesn't match the schema is rejected, not half-parsed.

Valid JSON can still be wrong, so three more checks sit around the model.

**Before the model, the app works out what the user asked.** A query interpreter classifies the request first. Questions that aren't about outfits get their own answer instead of a forced outfit. The occasion and style carry through to the outfit prompt. A request for a single item returns items, not a whole look.

**After the model, suggestions are matched against what the user owns.** The model describes clothes, and the app has to map those descriptions back to real items. Colours and types are normalized before comparison, so "navy" matches "blue". When the user asks for something they don't own, a guardrail says so instead of quietly substituting the nearest match. The classifier also rejects photos that aren't clothing.

**Retrieval uses PostgreSQL, not embeddings.** For recommendations I replaced embedding-based retrieval with full-text search. It's a weighted `tsvector` column kept current by a trigger, with a GIN index. Outfits a user marks "not my style" feed into later suggestions.

Prompts live in their own files under `prompts/`, with few-shot examples, and the model for each task is set by an environment variable.

## 3. Realtime, rebuilt twice

Item status, notifications, and the credit balance update live. That layer went through three versions:

1. Polling and server-sent events.
2. A custom WebSocket server, which replaced both across the app in April 2026. Its connection issues took several fixes.
3. Firebase Realtime Database, two weeks later. The server writes with the Admin SDK, clients subscribe with a Firebase custom token, and one shared hook handles sign-in, removes duplicate sign-ins, and tracks the connection state.

Moving to Firebase let me delete the WebSocket server, its context, its hooks, the broadcast service, and an API route. The cost is a dependency on a third-party service for something that sits on every page. The move also brought two bugs: a listener attached to the wrong channel name, and components that reacted to stale values on mount until I added a baseline guard.

## 4. Billing that survives partial failures

Credits were first charged by the actual token usage the Gemini API reported. In May 2026 I switched to a fixed cost per classification and per recommendation, and fixed charges on requests that weren't outfit requests.

The harder problem was correctness. Billing touches the database, Razorpay, and notifications, and most of its bugs happened when one of those succeeded and another didn't:

- **Grants applied twice.** Razorpay's timestamps drifted enough that the same credit grant could be applied twice.
- **Wallets going negative.** An expiring grant could take a wallet below zero.
- **Webhooks stuck.** Events stuck in "received" are now picked up again. Prisma's transient P2028 transaction error is handled, and events for accounts that don't exist are skipped instead of retried forever.
- **Orphaned subscriptions.** A Razorpay subscription could be created while the database transaction around it failed.
- **Notifications inside transactions.** Notifications were sent from inside database transactions, so I moved them out.
- **Audit trail.** A usage event is saved even when the charge itself fails, so there's always a record.

Limits had loopholes of the same kind. A multi-file upload could go past a plan's item cap, so the cap is now checked on the server. Credits are checked before an item is created. Failed and non-clothing items don't count toward the cap. And the cap is frozen when a subscription starts, so changing a plan later doesn't change it for people already on it.

## What I'd do from the start next time

- **Structured output on the first prompt.** The regex parser lasted about six weeks.
- **A hosted realtime service from day one.** The custom WebSocket server lasted two weeks before Firebase replaced it.
- **Billing as a ledger with idempotency keys.** Most of the billing bugs were replays or half-completed operations. An append-only ledger with an idempotency key on every grant and charge would have ruled out most of them by design.
