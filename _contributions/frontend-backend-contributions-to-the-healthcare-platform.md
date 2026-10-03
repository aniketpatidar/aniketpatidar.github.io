---
layout: contribution
date: "2026-09-10"
title: "KlinicCon: data models, a shared Input component, and contributor docs"
nav_exclude: true
order: 3
org:
- rt4914/KlinicCon-Frontend
- rt4914/KlinicCon-Backend
repo:
- https://github.com/rt4914/KlinicCon-Frontend
- https://github.com/rt4914/KlinicCon-Backend
description: "Added four data models to KlinicCon's Rails backend (Institute, Specialization, Establishment, and DoctorEstablishment), built its reusable React Input component, and wrote the contribution guide and pull-request template."
featured: true
---

[KlinicCon](https://github.com/rt4914/KlinicCon-Backend) is an open-source healthcare platform with a Rails 7.1 backend and a React frontend. Between August and September 2024 I worked on both sides, plus the docs that help other contributors get started.

## Four tables for where doctors practise

In [KlinicCon-Backend](https://github.com/rt4914/KlinicCon-Backend) I added four tables, each with its migration and model:

- `Institute` and `Specialization`, each a named list with a unique index on the name.
- `Establishment`, with a name, an address, and latitude and longitude. Its `maps_location` started as a decimal, and I changed it to a string.
- `DoctorEstablishment`, which joins doctor profiles to establishments. My first version wrote `belongs_to :doctor_id`, naming the column instead of the association, and I fixed it to `belongs_to :doctor_profile` and `belongs_to :establishment`.

## One Input component for the whole frontend

In [KlinicCon-Frontend](https://github.com/rt4914/KlinicCon-Frontend) (React 18 and Vite) I built a shared `Input` component. A `Variant` enum maps three looks (default, secondary, and small) to their Tailwind classes, so the styles are defined once, and prop-type validation warns in development when a prop is wrong.

## Docs for the next contributor

- A `CONTRIBUTING.md` guide, later moved into `.github/`.
- A README covering KlinicCon's features, design, and setup, with the contributors listed alphabetically.
- A pull-request template with a checklist and test steps, tweaked so the template's example issue number doesn't accidentally link to a real issue.
