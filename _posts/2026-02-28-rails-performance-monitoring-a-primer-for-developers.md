---
layout: post
title: "Rails Performance Monitoring: A Primer for Developers"
description: "A top-down approach to finding and fixing slow Rails apps: APM metrics, profiling and benchmarking, and common performance killers like N+1 queries, synchronous external calls, third-party timeouts, and missing database indexes."
featured: true
---

"Rails is slow." 

It’s a phrase I’ve heard many times. I don’t think Rails itself is usually the problem. Apps get slow because of expensive mistakes in our own code, and because we can’t see where those mistakes are. This is the order I’d work in to find and fix them, starting from the top.

## 1. Start with data, not guesses

To fix performance, you first need data. Application performance monitoring (APM) tools like New Relic, Datadog, or Scout APM provide vital "telemetry" data to monitor the health of your app.

### Key Metrics to Watch

- **Request queuing:** how long a request waits before a server process picks it up. Keep it low, ideally in the low tens of milliseconds. If it stays high, requests are waiting for free capacity and your servers are overloaded. If it sits near zero all day, you may have more capacity than you need.
- **Top transactions:** don't guess what's slow. Look at your most frequent and slowest endpoints to find where a fix will pay off most.
- **Object allocation:** high memory usage often comes from creating too many Ruby objects. For example, iterating over `Product.all.each` on a large table loads every record into memory at once. Use `find_each` to load records in batches instead.

## 2. Find the exact line, then prove the fix

Once you know which page is slow, you need to find the specific line of code responsible.

- **Profiling:** tools like [rack-mini-profiler](https://github.com/MiniProfiler/rack-mini-profiler) show, right in your browser, how much time a request spends on SQL queries versus rendering. They include a backtrace for each query, so you can trace a slow query to the exact file and line in your Rails app.
- **Benchmarking:** if you think a change will make things faster, prove it. The [benchmark-ips](https://github.com/evanphx/benchmark-ips) gem (iterations per second) compares the before and after of a change and reports whether the difference is statistically meaningful.

## 3. Most slowness comes from a few repeat offenders

Most Rails bottlenecks fall into a few predictable categories. Avoid these common mistakes:

### I. N+1 queries hide in views
We often miss N+1 queries in complex views. Watch out for:

- **The count trap:** calling `.count` on an association runs a `COUNT` query every time, even if the records are already loaded. Use `.size`, which counts the loaded records when the association is loaded, and only queries when it isn't.
- **The filter trap:** calling `.where` on an eager-loaded association ignores the loaded records and runs a new query. Filter the loaded records in Ruby instead, with a block: `post.comments.select { |c| c.approved? }` or `post.comments.find { |c| c.author_id == user.id }`. Without a block, `.find(id)` and `.select(:column)` go back to the database.

### II. Users shouldn’t wait on third parties
Never make a user wait while your app talks to a third party. Tasks like sending an email, an SMS, or a WhatsApp message should always be moved to a Background Job. This keeps the user experience snappy and the server free to handle the next request.

### III. Default timeouts are far too long
If you rely on an external API, never use the default timeout (which is often 60 seconds). If that service slows down, your entire app will hang. Set strict timeouts, usually around 2 seconds, to fail fast and stay in control of your app's responsiveness.

### IV. A missing index means scanning every row
A missing index forces the database to scan every single row in a table (a Sequential Scan). Adding a simple index can reduce query costs from thousands to nearly zero. Use the `EXPLAIN` command to see how the database plans to run your query and identify where indexes are missing.

## Summary
Scaling Rails is about a disciplined, top-down approach:
1.  Monitor with APM to find the bottleneck.
2.  Profile to find the specific line of code.
3.  Benchmark to prove your fix works.
4.  Optimize by fixing N+1s, moving tasks to background jobs, and adding database indexes.