---
layout: contribution
title: "In-app notifications for Moneygun with the Noticed gem"
nav_exclude: true
order: 1
org:
- yshmarov/moneygun
repo:
- https://github.com/yshmarov/moneygun
description: Added a full in-app notification system to Moneygun, a white-label SaaS
  boilerplate, using the Noticed gem, including delivery logic and real-time Turbo
  Stream updates.
github: https://github.com/yshmarov/moneygun/pull/286
---

![In-app notifications added to Moneygun, screenshot one](/images/moneygun-notifications.jpg)

Added a full in-app notification system to [Moneygun](https://github.com/yshmarov/moneygun), a white-label SaaS boilerplate. This work involved integrating the latest [Noticed](https://github.com/excid3/noticed) gem, setting up delivery logic, and wiring notifications into the product's existing workflow. Do check out [Moneygun](https://github.com/yshmarov/moneygun) if you want to build your next B2B SaaS app (software as a service).

![In-app notifications added to Moneygun, screenshot two](/images/moneygun-notifications-2.jpg)

While working on this, I got stuck for a long time because Turbo Stream updates weren't appearing at all. Turns out the problem was Solid Cable. In development it doesn't broadcast across processes, so the updates never showed up.

I fixed it by giving Solid Cable its own database and updating the cable config. After that, the real-time updates finally started working.

There's a good conversation about this in the related Rails issue if you want the details: [rails/rails#53630](https://github.com/rails/rails/issues/53630).

If you want the full breakdown of what I did and what I learned along the way, I wrote about it here: [How I contributed notifications to an open-source product](/how-i-contributed-notifications-to-an-open-source-product/).

<blockquote class="shoutout">
  <p>”@aniketpatidar01 thanks for adding 🔔 notifications to Moneygun! 💪“</p>
  <footer>— <a href="https://twitter.com/yarotheslav/status/1937846273127702769">Yaroslav Shmarov</a>, maintainer of Moneygun, June 25, 2025</footer>
</blockquote>