---
layout: post
title: "Printrizz: the design decisions I reversed"
description: "Building a print-on-demand marketplace on NestJS and Prisma: six schema and design decisions I made, reversed, and what each reversal cost."
permalink: /printrizz-variants-orders-and-shipping/
tags: nestjs, prisma, nextjs, ecommerce
---

Over nine months on [Printrizz](https://printrizz.com), a print-on-demand marketplace, I reversed six of my own design decisions. Each first version was the simplest thing that worked. Each reversal came when a real case didn't fit. Some reversals were cheap, like dropping a pincode check. Others meant migrating data that already existed, like order status and deletes. Looking back, the cost depended less on how big the change was than on how much data already relied on the first design.

*Versions: NestJS with Prisma, Next.js, ImageKit, Razorpay, and Delhivery.*

## The product

Sellers pick a product from Printrizz's catalog, such as a t-shirt or a mug, choose which variants to offer, place their own design on it, and sell it. Buyers order through Razorpay, and orders ship through Delhivery. Influencers share referral links and earn a commission. I worked on it as client work at CodeNote from April 2025 to January 2026. It started as a Rails prototype and moved to a NestJS API with Prisma and a Next.js frontend in June 2025.

## 1. Variants: from fields to option types

The first product variant stored its options directly as `optionName` and `optionValues` fields, with images in a separate `ProductImage` table. That works for one kind of option. It doesn't work once a product has both a size and a colour, and each combination needs its own price and images.

In July 2025 I redesigned the schema for normalization and flexible variants:
- A catalog has option types, like size and colour.
- Each option type has option values, like M, L, and navy.
- Variants are combinations of those values.
- Creating a catalog creates its option types and values in the same request, and the API generates every combination, which a seller can then prune.
- Images became attachments on the catalog and on each variant, stored as ImageKit URLs.

I dropped the `optionName` and `optionValues` fields and the `ProductImage` table.

The cost showed up in editing rather than creating. Adding an option regenerated the variants, and existing images were lost. I had to change the generation to preserve images when options are added or changed, and fix the cleanup of variants that no longer exist. Editing a set of generated combinations is a merge, not a rewrite.

## 2. Print areas: from code to data

The product designer first had the product type and its print areas hardcoded. Supporting several placements per catalog, like front and back, meant moving them out of the code.

In September 2025 I moved them into the database. A `CatalogType` has `Placement` records, and each placement stores its print area as `x`, `y`, `width`, and `height`. `GET /catalog-types` returns the types with their placements, and the catalog form builds its options from that. The designer opens one canvas per placement, keeps each canvas's state when the seller switches between them, and renders previews on an offscreen canvas so exporting doesn't disturb what's being edited.

I made the coordinate columns nullable so the migration could run against the catalogs that already existed.

## 3. Orders: from the cart to their own items

At first an order was linked to the cart it came from. In September 2025 I removed that relation. An order now copies the cart's items into its own order items when it's created, so it's independent of whatever happens to the cart afterwards.

The cost is duplication: the same product, variant, and quantity now live in both the cart and the order. That's the point, though. An order records what was bought, while a cart is a draft that keeps changing.

## 4. Status: from the order to the item

Orders started with a single status. In November 2025 I moved status to the order item:
- Each item goes from confirmed to ready to ship to shipped, with its own tracking URL.
- Buyers see a timeline per item.
- In January 2026, items became cancellable one at a time, and the order-level cancel button went away.

This was the most expensive reversal. It changed the backend services, the admin and seller panels, the customer order page, and the notifications. By then, orders already flowed through all of those.

## 5. Deletes: from cascades to soft deletes

In July 2025 I added `ON DELETE CASCADE` across the foreign keys, so deleting a product cleaned up everything under it. In January 2026 I replaced that with soft deletes for catalogs, products, and categories, and stopped admins deleting catalogs at all.

A marketplace with orders can't hard-delete what its orders point to. Cascades were convenient while there was no real data. With real orders in the database, they were a risk.

## 6. Shipping: from a service to an interface

Shipping started as a `DelhiveryService` called directly. Within two weeks I replaced it with a `LogisticsProvider` interface, with Delhivery as the first implementation, to standardize shipment handling and leave room for more couriers. The interface defines DTOs for creating shipments, checking serviceability, turnaround time, and cost. Each method returns Delhivery's raw response, so callers can see exactly what the courier said.

The courier gave that boundary plenty to absorb:
- Package creation failed with `'NoneType' object has no attribute 'end_date'`. After confirming our payload matched their spec, I raised it with Delhivery's tech team.
- The manifest API failed with `ClientWarehouse matching query does not exist`. The turnaround-time call needed a specific date format and parameter name.
- In the sandbox, prepaid packages weren't enabled for the account. In production, one shipment failed on insufficient balance after the package was partly saved.

On our side, a failed courier call no longer creates a local shipment record. Empty tracking numbers are stored as null, so the unique constraint doesn't reject the second shipment without one.

Two smaller reversals followed the same pattern. The product page first checked the buyer's pincode with Delhivery to estimate delivery. In November 2025 I removed that, and the estimate now comes from a processing-time value on each catalog. Referral commissions started as a global rate, then moved to each product variant, set by the seller as a flat amount or a percentage, and recorded against the order item.

## What I'd decide earlier next time

Not every first version was wrong. The cart relation and the hardcoded print areas were fine until the product grew past them, and each was replaced within days. The expensive reversals were the ones that touched data with history behind it, and I'd settle those on day one:

- **Deletion semantics.** Soft deletes from the first table that orders will point to.
- **Status granularity.** Status per item, even if every order has one item for now.
- **External boundaries.** An interface in front of any third-party API before the first call, since the first call is when its quirks start leaking into your code.
