---
layout: contribution
date: "2026-09-10"
title: "Enable Banking: TLS port fix in the open banking eIDAS broker"
nav_exclude: true
order: 4
org:
- enablebanking/open_banking_eidas_broker
repo:
- https://github.com/enablebanking/open_banking_eidas_broker
description: "Fixed the broker's nginx config and Docker instructions, which served TLS on port 80 and mapped 443 to it. Both now use 443 (merged December 2024)."
github: https://github.com/enablebanking/open_banking_eidas_broker/pull/60
prs:
- label: "PR #60"
  url: https://github.com/enablebanking/open_banking_eidas_broker/pull/60
---

Enable Banking's [open banking eIDAS broker](https://github.com/enablebanking/open_banking_eidas_broker) secures access with client TLS certificate verification, handled by nginx.

Its `nginx.conf` listened with `listen 80 ssl`, so TLS ran on port 80, and the README's `docker run` examples mapped the host's 443 to it with `-p 443:80`. I changed nginx to `listen 443 ssl`, updated both `docker run` examples to `-p 443:443`, and corrected the README note that said secured connections use port 80.

Merged on 3 December 2024 as [PR #60](https://github.com/enablebanking/open_banking_eidas_broker/pull/60).
