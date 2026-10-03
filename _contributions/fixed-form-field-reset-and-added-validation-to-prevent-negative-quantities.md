---
layout: contribution
date: "2026-09-10"
title: "Human Essentials (Ruby for Good): data consistency fixes"
nav_exclude: true
order: 2
org:
- rubyforgood/human-essentials
repo:
- https://github.com/rubyforgood/human-essentials
description: "Two merged fixes to Ruby for Good's inventory app for diaper banks: a purchase form that reset the chosen storage location after a failed save, and kits that could be saved with negative item quantities."
github: https://github.com/rubyforgood/human-essentials
featured: true
prs:
- label: "PR #4215"
  url: https://github.com/rubyforgood/human-essentials/pull/4215
- label: "PR #4163"
  url: https://github.com/rubyforgood/human-essentials/pull/4163
---

[Human Essentials](https://github.com/rubyforgood/human-essentials) is inventory control for diaper banks and other essentials banks, built by [Ruby for Good](https://rubyforgood.org) volunteers. In March 2024 I fixed two data bugs in it.

## Purchase form lost the storage location ([PR #4215](https://github.com/rubyforgood/human-essentials/pull/4215))

When a new purchase failed validation and the form re-rendered, the storage location the user had picked reset to the organization's default. The helper chose the default whenever the purchase was a `new_record?`, and a purchase that failed to save is still a new record. I changed it to keep the selected location and fall back to the default only when none was chosen, and added a helper spec for it.

## Kits accepted negative quantities ([PR #4163](https://github.com/rubyforgood/human-essentials/pull/4163))

Kits could be saved with negative item quantities. My first version added the check to each `LineItem`. During review I moved it up to the `Kit` model instead, reusing the existing quantity check in the `Itemizable` concern and adjusting that check so it works for models without a storage location. I also made the error message readable, and added model specs.
