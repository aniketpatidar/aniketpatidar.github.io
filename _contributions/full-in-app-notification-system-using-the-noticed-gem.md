---
layout: contribution
date: "2026-09-10"
title: "In-app notifications for Moneygun with the Noticed gem"
nav_exclude: true
order: 1
org:
- yshmarov/moneygun
repo:
- https://github.com/yshmarov/moneygun
description: "Built Moneygun's notification system with the Noticed gem, including email delivery and live in-app updates through a custom Turbo Stream delivery method. Merged with controller, mailer, and model tests."
github: https://github.com/yshmarov/moneygun/pull/286
featured: true
prs:
- label: "PR #286"
  url: https://github.com/yshmarov/moneygun/pull/286
---

![In-app notifications added to Moneygun, screenshot one](/images/moneygun-notifications.jpg)

[Moneygun](https://github.com/yshmarov/moneygun) is an open-source Rails boilerplate for B2B SaaS apps. Its maintainer was looking for contributors, and I took on [issue #285](https://github.com/yshmarov/moneygun/issues/285), adding notifications for organization invitations and for accepted or rejected requests to join.

## What the pull request added

Merged as [PR #286](https://github.com/yshmarov/moneygun/pull/286): 45 files, about 540 lines.

- Three notifiers on the [Noticed](https://github.com/excid3/noticed) gem: `MembershipInvitationNotifier`, `MembershipRequestAcceptedNotifier`, and `MembershipRequestRejectedNotifier`.
- Email delivery through a `MembershipMailer`, with a template for each notification.
- A custom `DeliveryMethods::TurboStream` delivery method. It updates the unread count and adds the new notification to the list live, without a page reload.
- A notifications page, English and French translations, and tests for the controller, the mailer, and both access-request models.

![In-app notifications added to Moneygun, screenshot two](/images/moneygun-notifications-2.jpg)

## Live updates were blocked by the cable adapter, not the code

The live updates never showed up in development. Everything looked right, but nothing reached the browser.

The cause was Action Cable's `async` adapter, which Moneygun used in development. It only broadcasts within a single process. Noticed delivers notifications from background jobs, and Moneygun runs those in a separate Solid Queue worker process. So every broadcast was sent from a process the browser wasn't connected to.

The fix was to switch development to Solid Cable, backed by its own `cable` database. Then broadcasts from any process reach the browser, and the live updates started working.

There's a good conversation about this in the related Rails issue if you want the details: [rails/rails#53630](https://github.com/rails/rails/issues/53630).

If you want the full breakdown of what I did and what I learned along the way, I wrote about it here: [How I contributed notifications to an open-source product](/how-i-contributed-notifications-to-an-open-source-product/).

<blockquote class="shoutout">
  <p>”@aniketpatidar01 thanks for adding 🔔 notifications to Moneygun! 💪“</p>
  <footer><a href="https://twitter.com/yarotheslav/status/1937846273127702769">Yaroslav Shmarov</a>, maintainer of Moneygun, June 25, 2025</footer>
</blockquote>