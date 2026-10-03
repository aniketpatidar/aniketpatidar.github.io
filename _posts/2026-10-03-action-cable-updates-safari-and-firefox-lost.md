---
layout: post
title: "The Action Cable updates Safari and Firefox lost"
description: "Two bugs in the same live-update flow: Safari on iOS 17.5 dropped the socket during bank login, and Firefox missed broadcasts sent before it subscribed."
permalink: /action-cable-updates-safari-and-firefox-lost/
tags: ruby-on-rails, action-cable, websockets, debugging
---

The same Action Cable channel broke twice, a year apart, in two browsers. In 2024, Safari on iOS 17.5 dropped the socket while users were away logging in to their bank. In 2025, Firefox subscribed too late to catch the broadcast. Neither raised an error. The server sent its message both times, and the only symptom was a spinner that never stopped.

*Versions: Rails 6.1 and the Action Cable JavaScript client in 2024, Safari on iOS 17.5.*

## The flow

[Kreditz](https://kreditz.com) lets lenders check a customer's finances through open banking. The customer picks their bank in Kreditz's page, often embedded in the lender's site as an iframe, and leaves to log in with the bank. When they come back, the page shows a spinner and waits on an Action Cable channel. Once the bank data has arrived, the backend broadcasts the request's status, and the page shows the result or sends a `postMessage` to the lender's site so it can move on.

I built that channel in 2023, as client work at CodeNote. For a year it worked.

## Safari on iOS 17.5

In May 2024 the result page stopped rendering on iPhone Safari after a bank login. Customers were stuck on the spinner, and the lender's site never heard that they had finished.

The timing pointed at the iOS update from 17.4 to 17.5. Reproducing it showed what changed: when the customer navigated away from the page to authenticate with the bank, the WebSocket stream stopped, and the connection wasn't established again. The backend broadcast the status on time. Nothing was listening.

I spent a few days on approaches that didn't work, including overriding the browser's WebSocket `close` event. Along the way I found a second problem. Opening the flow in a new tab opened another WebSocket connection, and that disconnected the main one. So the fix had to survive more than a trip to the bank. It also had to survive tabs opening and the page going in and out of view.

What worked was stopping the Action Cable client from closing the connection while the page was waiting. I replaced `ActionCable.Connection.prototype.close` with a version that ignores the close, and put the original back as soon as the status arrived:

```javascript
// Simplified; channel and function names are illustrative
const originalClose = ActionCable.Connection.prototype.close;

ActionCable.Connection.prototype.close = function () {
  // keep the socket open while we wait for the bank result
};

consumer.subscriptions.create({ channel: "RequestStatusChannel", id: requestId }, {
  received(data) {
    ActionCable.Connection.prototype.close = originalClose;
    handleStatus(data);
  },
});
```

This is a workaround, and it has costs. A connection that can't close can leak, so I handled `beforeunload` to close the connection when the page really goes away, and open a new one if the customer comes back. It also patches the internals of the Action Cable client, so upgrading `@rails/actioncable` means checking that `Connection.prototype.close` still behaves the way the patch assumes.

## Firefox, a year later

In September 2025 a different problem showed up. In Firefox, some `postMessage` events from the iframe never reached the lender's site.

This time the socket was fine. The problem was ordering. The backend broadcast the status before the page had finished subscribing to the channel. Action Cable doesn't keep messages for subscribers that haven't joined yet, so the broadcast went to nobody.

I delayed the broadcast so it goes out after the subscription is set up. On the dynamic form page, Turbo was also conflicting with Action Cable, so I turned Turbo off there.

## What the two bugs share

Both were silent. In both cases the server did its job, and the message was lost between the broadcast and the browser. There was no server-side error to find. Each bug was found from a user-facing symptom and reproduced by hand.

They also share a design flaw. The page relied on catching a single broadcast at the right moment, with no way to recover if it missed it.

## What I'd change

**Ask for the state when subscribing.** A delayed broadcast closes the race in practice, but it's still a timing bet. A sturdier version has the page ask for the current status in Action Cable's `connected()` callback, once its subscription is confirmed. Then it doesn't matter whether the broadcast came first.

**Keep a plain HTTP fallback.** If the page also checked the request's status over a normal request after a timeout, both bugs would have cost a few seconds instead of a stuck customer. The socket would make the page fast, and the fallback would make it correct.

**Log the client side.** A log line when the subscription is confirmed, and another when the status arrives, would have shown the gap within minutes instead of days.
