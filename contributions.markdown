---
layout: page
title: Contributions
permalink: /contributions/
---

### Implement notifications system with Noticed gem [ #286](https://github.com/yshmarov/moneygun/pull/286)
![](https://pbs.twimg.com/media/GuSaGgfX0AAwWZk?format=jpg&name=4096x4096)

Added a full in-app notification system to [Moneygun](https://github.com/yshmarov/moneygun), a white-label SaaS boilerplate. This work involved integrating the latest [Noticed](https://github.com/excid3/noticed) gem, setting up delivery logic, and wiring notifications into the product’s existing workflow. Do check out [Moneygun](https://github.com/yshmarov/moneygun) if you want to build your next B2B SaaS app (software as a service)

![](https://pbs.twimg.com/media/GuSc0v1XQAA7FQj?format=jpg&name=large)

While working on this, I got stuck for a long time because Turbo Stream updates weren’t appearing at all. Turns out the problem was Solid Cable. In development it doesn’t broadcast across processes, so the updates never showed up.

I fixed it by giving Solid Cable its own database and updating the cable config. After that, the real-time updates finally started working.

There’s a good conversation about this in the related Rails issue if you want the details: [rails/rails#53630](https://github.com/rails/rails/issues/53630)

If you want the full breakdown of what I did and what I learned along the way, I wrote about it here: [How I contributed notifications to an open-source product](https://aniketpatidar.github.io/how-i-contributed-notifications-to-an-open-source-product/)

<blockquote class="twitter-tweet"><p lang="en" dir="ltr"><a href="https://twitter.com/aniketpatidar01?ref_src=twsrc%5Etfw">@aniketpatidar01</a> thanks for adding 🔔 notifications to Moneygun! 💪 <a href="https://t.co/zdaUXxRF6C">https://t.co/zdaUXxRF6C</a> <a href="https://t.co/NcfW0WpG1g">pic.twitter.com/NcfW0WpG1g</a></p>&mdash; Yaroslav Shmarov (@yarotheslav) <a href="https://twitter.com/yarotheslav/status/1937846273127702769?ref_src=twsrc%5Etfw">June 25, 2025</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 
