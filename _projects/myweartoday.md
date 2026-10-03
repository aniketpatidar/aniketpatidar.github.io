---
layout: project
date: "2026-09-10"
title: MyWearToday
nav_exclude: true
fetch_readme: false
live: https://myweartoday.com
description: "An AI-powered digital closet that classifies your clothes, suggests outfits, and lets you try them on. Built at CodeNote with Next.js, Inngest, and Gemini."
badges:
- name: Next.js
- name: Prisma
- name: Gemini API
- name: Inngest
images: []
order: 3
role: Client work at CodeNote
---

MyWearToday is an AI-powered digital closet. People upload photos of their clothes, the app classifies each item, and then it suggests outfits from what they already own and shows what they'd look like on. I've built it as client work at CodeNote since February 2026: a Next.js app on Prisma and PostgreSQL, an Android app that wraps it, and the AI pipeline behind both.

## Slow AI work happens in the background

Processing a photo takes too long to do inside a request, so none of it happens there. An upload is saved to temporary storage and the item comes back straight away in a pending state. An Inngest job then moves the image to S3, cuts the item out with a background-removal service, classifies it with the Gemini API, and stores its embedding. Each item tracks its own status, failures notify the user, and an item stuck in processing can be cancelled. A daily job clears temp files older than a day.

Outfit suggestions and try-ons run the same way, so several can be in flight at once. Results reach the browser in real time. That started as polling, moved to a WebSocket server, and now runs on Firebase Realtime Database, which removed the custom socket server entirely.

## Getting useful answers out of the model

Model output is structured JSON checked against a Zod schema, which replaced the regex parsing I started with. Prompts live in their own files with few-shot examples, separate from the code that calls them.

Before suggesting an outfit, the app works out what the user is actually asking for, so questions that aren't about outfits are handled on their own and the occasion and style carry through to the curator prompt. Colors and clothing types are normalized before matching, so "navy" counts as "blue". If someone asks for a specific item that isn't in their wardrobe, a guardrail says so instead of offering something close. Retrieval uses PostgreSQL full-text search over a weighted `tsvector` with a GIN index, and when someone marks an outfit "not my style", that combination counts against later suggestions.

## Trying outfits on

Virtual try-on sits behind one interface with two adapters, Vertex AI and LightX, so the provider can change without touching the flow. Requests and results are stored rather than held in the session, and the user's photo and garment picks autosave as a draft, so a try-on in progress survives a page reload.

## Billing that adds up

Plans are Razorpay subscriptions that grant credits, with welcome credits spent first. Admins set how many items each plan can hold, and the cap is fixed when a subscription starts. Getting this right took a pass of its own: notifications moved out of database transactions, webhook events stuck in "received" are picked up again, timestamp drift from Razorpay can no longer grant credits twice, and an expiring grant can't push a wallet below zero.

Upstash Redis rate-limits the expensive endpoints, and AppSignal monitors the app in production. The Android app is a React Native wrapper with Firebase push notifications and native back navigation.

I wrote up the pipeline, the realtime layer, and the billing fixes in [MyWearToday: the work around the model](/building-myweartoday-ai-jobs-realtime-and-credit-billing/).

[Visit MyWearToday](https://myweartoday.com)
