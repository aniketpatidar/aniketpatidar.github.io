---
layout: project
date: "2026-10-03"
title: Printrizz
nav_exclude: true
fetch_readme: false
live: https://printrizz.com
order: 4
role: Client work at CodeNote
description: "A print-on-demand marketplace on NestJS and Next.js. I built its variant data model, design placement, Razorpay checkout, Delhivery shipping, and referrals."
badges:
- name: NestJS
- name: Prisma
- name: Next.js
- name: Razorpay
images: []
---

Printrizz is a print-on-demand marketplace. Sellers pick a product from the catalog, choose its variants, place their own design on it, and sell the result. Influencers can share referral links and earn a commission on what they sell. I worked on it as client work at CodeNote from April 2025 to January 2026.

It started as a Rails prototype. From June 2025 it's a NestJS API on Prisma, with Swagger docs and DTOs validated by class-validator, and a Next.js frontend split into server and client components.

## Products with many variants

A single product can come in many sizes, colors, and materials, so the schema is built around option types and option values. I reworked it once for better normalization when the catalog grew. Creating a catalog creates its option types and values in the same request and generates every variant combination from them. Each variant can have its own images on ImageKit, colors carry real color codes shown as swatches, and a catalog can sit under several categories. Category names only have to be unique among siblings.

Editing a catalog was where most bugs hid. Adding an option used to regenerate the variants and drop their images, so I changed the generation to preserve images when options are added or changed, and fixed the cleanup of variants that no longer exist.

## Putting a design on a product

Each catalog type has its own placements, like front and back, stored with the print area's position and size. The product designer opens a canvas per placement and keeps each canvas's state when the seller switches between them. Previews are rendered on an offscreen canvas, so exporting one never disturbs what the seller is editing, and the exported images are attached to each variant.

## Checkout and orders

An order copies the cart's items into its own order items when it's created, so it no longer depends on what happens to the cart afterwards. Payment goes through Razorpay checkout. If the buyer closes the payment window, the app marks that payment cancelled instead of leaving it pending, and a payment can be retried from the order page.

Later I moved fulfilment from the order to each item. Every item goes from confirmed to ready to ship to shipped on its own, with its own tracking link, and buyers see a timeline per item. Items can be cancelled one at a time too.

## Shipping on Delhivery

Shipping goes through a `LogisticsProvider` interface with Delhivery as the first implementation, so a second courier can be added without touching the order code. The admin shipment form splits an order into packages and items, and validation stops a package from holding more of an item than was ordered. Several ready-to-ship shipments can go out under one pickup request.

## Sellers and influencers

Influencers get a referral link per product variant, with a short slug, click tracking, and a commission the seller sets per variant as a flat amount or a percentage. The referral code is kept through to checkout and recorded on the order. A seller's withdrawable balance counts only delivered orders whose 7-day refund window has closed.

Catalogs, products, and categories are soft-deleted rather than removed with cascading deletes, so an old order never loses the product it points to. In-app notifications for orders, shipments, payments, and withdrawals started on polling and now arrive over a WebSocket.

More on how the design changed in [Printrizz: the design decisions I reversed](/printrizz-variants-orders-and-shipping/).

[Visit Printrizz](https://printrizz.com)
