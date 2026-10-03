---
layout: post
title: "Integrating Yapily into an open banking Rails app"
description: "Adding Yapily to Kreditz's Rails app next to Klarna and Enable Banking: fetching data was the easy part, and consent and bank-specific limits were the hard part."
permalink: /integrating-yapily-into-a-multi-provider-open-banking-app/
tags: ruby-on-rails, open-banking, api-integration
---

In August 2023 I started integrating [Yapily](https://www.yapily.com/), an open banking API, into [Kreditz](https://kreditz.com)'s Rails app, next to the Klarna and Enable Banking integrations it already had. I expected the work to be in fetching accounts and transactions. That part took a few weeks. Over the following two years, most of the Yapily problems I fixed were about consent: getting it, knowing whether it was still valid, and handling banks that wanted something different. Most of the rest came from the gap between what Yapily's sandbox accepted and what real banks enforced.

*Versions: Rails 6.1 at the time, Yapily's REST API in sandbox and live.*

## Where a provider fits

Kreditz lenders send a customer through a flow that ends in a credit report built from the customer's bank transactions. Every provider in the app plugs into the same sequence:

1. Show a list of banks.
2. Show a consent page.
3. Send the customer to their bank.
4. Handle the callback.
5. Fetch the data and store it.

For Yapily, the first four steps meant syncing Yapily's institutions by country into the bank list, creating a consent and redirecting to its authorization URL, and exchanging the code on the callback for an access token. The fifth meant turning Yapily's responses into the same customer, account, and transaction records the other providers produce. That shared shape is what made a new provider feasible at all. The report, the PDF, and the lender webhooks read those records and don't care where they came from.

By the end of August, manual requests in Sweden worked end to end. Then the edge cases started, and almost all of them were about consent.

## Consent was the real work

**The second bank.** Lenders can ask a customer to connect several banks in one request. With Yapily, starting consent for the second bank failed, and some multi-bank requests broke later, while the bank data was being processed. Each case needed tracking down separately.

**Banks that need more before consent.** Some corporate banks require the user's PSU ID before they'll authorize. A single consent page couldn't serve every bank, so when a customer picks one of those banks, the flow now shows a form for the PSU ID first. Banks that don't need it go straight to the consent page.

**Is the consent still valid?** Lenders can refetch a customer's transactions on a schedule, long after the first connection. In 2024 I made the refetch worker fetch the consent and check it's authorized before asking for any transactions.

That check behaved differently by market. I first read the status through the consent auth code, which worked for Swedish banks and returned errors for UK ones. Listing consents instead, filtered by institution ID and by application user ID, worked. I used the request's case ID as the application user ID, which ties every consent to the request that created it. With that lookup, the worker could retrieve and validate the consent status.

## The sandbox said yes, the banks said no

Some transaction fetches failed on an invalid date field. I couldn't reproduce it in the sandbox. NatWest's sandbox returned 200 even for dates beyond the allowed period, and for dates in 2026. The real error was an `institutionError`, which Yapily passes through from the bank itself. Each bank validates the date range on its own terms, and Nationwide's documentation, for example, says it returns 400 for periods longer than 15 months.

So the sandbox couldn't tell me anything about a live bank's limits. Handling them means knowing each bank's documented limits, not trusting a sandbox that accepts everything.

Real data also differed from the sandbox in smaller ways. Some accounts came back with no account identification, so I added support for saving an account without an account number.

## Fitting into a codebase built for other providers

The app had been built around Klarna and Enable Banking, and Yapily had to fit in without disturbing them.

Early on it didn't. I'd named some Yapily methods the same way the Klarna and Enable Banking code named theirs. Each provider worked on its own, and on the shared staging server the clashing names broke requests for the other two. Renaming fixed it. Namespacing every provider's code from the start would have prevented it.

In mid-2024 the app moved to a multi-provider model, where one organization can have several providers enabled, and Yapily had to move with it. I read its settings from `ServiceProvider` records and routed its authorization URL through the existing `generate_auth` flow instead of a new endpoint. It also stopped needing its own consent page: it uses the same one as Enable Banking. Admins also gained an endpoint for refetching a Yapily request from the admin portal.

## Still open

Two problems I investigated but didn't close. One is a set of duplicate requests and missing redirects after authentication, where at least one case traced back to an Action Cable message that never arrived. The other is two requests in the same multi-bank flow showing the same accounts. I asked for production data to check it.

## What I'd change

**Model consent as its own thing.** Consent was spread across the flow: created in one place, checked in a worker, looked up differently by market. A small consent record per request, with its status and expiry, checked in one place before every fetch, would have made each of the bugs above easier to find.

**Keep a list of each bank's limits.** The sandbox accepts things live banks reject. A short table of each bank's documented limits, like Nationwide's 15 months, would have caught the date errors earlier.

**Namespace provider code from the first commit.** It's cheap, and it would have saved a broken staging deploy.
