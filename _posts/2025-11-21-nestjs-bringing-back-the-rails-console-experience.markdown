---
layout: post
title: "NestJS REPL: Bringing Back the Rails Console Experience"
description: "Missing the Rails console in NestJS? A small REPL script around the Prisma client gives you a console for exploring and changing data."
permalink: /bringing-back-the-rails-console-feeling-in-a-nestjs-prisma-world/
featured: true
---

Moving from Rails to NestJS, I missed the Rails console: a prompt where I can load models, try a query, or fix a record. NestJS has had a built-in REPL since version 9, but it boots the whole application. For poking at data, I wanted something lighter, so I put together a small REPL around the Prisma client.

Prisma's client is self-contained, so it drops straight into a REPL. Here's the script:

```ts
import { PrismaClient } from '@prisma/client';

async function main() {
  const prisma = new PrismaClient();
  const repl = require('repl').start('> ');
  repl.context.prisma = prisma;
}

main();
```

Place this script in a file like `src/repl.ts` and execute it:

```plaintext
npx ts-node src/repl.ts
```

Now, you can perform similar tasks as you would in a Rails console:

```bash
> await prisma.user.findMany()
```

While it doesn't load the full Rails environment, it serves its purpose.

## And yes, Prisma Studio exists

Before diving into building a custom REPL, consider that Prisma comes with **Prisma Studio**:

```bash
npx prisma studio
```

Prisma Studio provides a clean interface for viewing and editing tables. It's excellent for browsing data but doesn't quite capture the "let me try this query right now" feel of the Rails console. This is where the REPL comes in handy.

## When the REPL is the Right Choice

* Testing a query before integrating it into a service
    

For trying a query or checking some data, a small REPL is enough. I don't need to boot the whole application.
