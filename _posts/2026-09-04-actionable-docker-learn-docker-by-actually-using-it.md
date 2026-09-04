---
layout: post
title: "Actionable Docker: Learn Docker by Actually Using It"
date: 2026-09-04 18:48:19 +0530
categories: docker devops
---

Docker can feel complicated when you start with concepts like images, containers, registries, volumes, networks, and Dockerfiles.

Let's skip most of that for now.

The goal of this guide is simple: get Docker installed, understand what it is actually useful for, and start running real services with it.

## 1. Install Docker.

There are two main ways you'll interact with Docker:

*   **Docker Desktop**: A GUI application that also includes the Docker CLI. It's available for Windows, macOS, and Linux.
*   **Docker CLI**: The command-line interface you'll use to interact with Docker.
    
If you're on Linux and prefer the terminal, you can install Docker Engine and use the CLI directly.

Once Docker is installed, don't move forward until this works:

```shell
docker --version
```

You should see something similar to:

```text
Docker version 29.x.x
```

Now let's actually test the installation.

```shell
docker run hello-world
```

If everything is working, Docker will print:

```text
Hello from Docker!
```

That's your first Docker container.

If `docker` isn't found or the command fails, stop here and fix the installation first. There is no point continuing until Docker itself is working.

---

## 2. So, what are we using Docker for?

This is probably the most important question. Docker lets you run applications and services inside isolated containers. Think of a container as a small, isolated environment running on your machine.

It has its own:
*   Filesystem
*   Network environment
*   Processes
*   Environment variables
*   CPU and memory limits, when configured

It isn't a full virtual machine. Containers share the host operating system's kernel, which makes them much lighter and faster to start than traditional virtual machines.

The important part is isolation. For example, instead of installing MongoDB directly on your laptop, you can run MongoDB inside a Docker container.

Instead of:
> Download MongoDB → install it → configure it → start it → remember how you installed it

You can eventually get to:

```shell
docker run mongo
```

One command, and MongoDB is running. That's where Docker starts becoming really useful.

---

## 3. Why is this useful?

Imagine you're working on a project that requires:
*   PostgreSQL
*   Redis
*   MongoDB
*   Elasticsearch

Installing all of these directly on your machine can become annoying. Different projects may also require different versions. Docker gives you another option:

Run each service in its own container.

For example:

```text
Your Machine
│
├── Your application
│
├── PostgreSQL container
│
├── Redis container
│
└── MongoDB container
```

You don't necessarily need to install PostgreSQL, Redis, or MongoDB directly on your operating system. You can start the services when you need them and remove them when you're done.

---

## 4. Where do Docker images come from?

Before we run MongoDB, we need to understand one term:

**Image.**

A Docker image is a packaged filesystem containing everything needed to create a container, such as application code, dependencies, configuration, and the required runtime.

A container is a running instance of an image. You can create multiple containers from the same image.

Where do these images come from?

Just like developers push source code to GitHub or GitLab, Docker images can be pushed to and pulled from container registries.

The most popular one is Docker Hub. Other registries include:
*   Amazon ECR
*   Google Artifact Registry
*   GitHub Container Registry
*   Azure Container Registry

For example, the official MongoDB image is available on Docker Hub:
[https://hub.docker.com/_/mongo](https://hub.docker.com/_/mongo)

When you run:

```bash
docker run mongo
```

Docker looks for the `mongo` image locally. If it doesn't have it, Docker pulls the image from a configured registry, such as Docker Hub, and then creates a container from it.

---

## 5. Your first real container

Let's run MongoDB.

```bash
docker run mongo
```

Docker will download the MongoDB image if you don't already have it and start a container.

But there's a problem. MongoDB runs on port `27017` inside the container. That port isn't automatically exposed to your host machine.

We can map the container's port to our machine using `-p`.

```bash
docker run -p 27017:27017 mongo
```

The syntax is:

```text
-p HOST_PORT:CONTAINER_PORT
```

So:

```bash
-p 27017:27017
```

means:
> When something connects to port `27017` on my machine, send that traffic to port `27017` inside the container.

Now your application running on your machine can connect to MongoDB at:

```text
localhost:27017
```

---

## 6. Run it in the background.

By default, `docker run` attaches your terminal to the container. That's not very convenient for a database.

We can run the container in **detached mode** using `-d`.

```bash
docker run -d -p 27017:27017 mongo
```

Now Docker starts MongoDB in the background and gives you a container ID.

Your terminal is free again.

---

## 7. See your running containers.

To see containers that are currently running:

```bash
docker ps
```

You'll see information such as:

```text
CONTAINER ID   IMAGE   COMMAND       STATUS        PORTS
abc123         mongo   ...           Up 10 seconds 0.0.0.0:27017->27017/tcp
```

The container ID is particularly useful because you'll use it to interact with a specific container.

---

## 8. Stop a container

If you want to stop a running container:

```bash
docker stop <container-id>
```

For example:

```bash
docker stop abc123
```

You can also use the container name if Docker assigned one. Despite the command being commonly used in quick examples, `docker kill` is not usually what you want for normal shutdowns. `docker stop` gives the process a chance to shut down gracefully.

---

## 9. Passing environment variables

Docker containers can also receive environment variables.

You do this with the `-e` flag:

```bash
-e KEY=value
```

For example, when creating a MongoDB container with authentication enabled:

```bash
docker run \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=mystrongpassword \
  -d \
  -p 27017:27017 \
  mongo
```

Now the MongoDB container is initialized with a root username and password.

-e means:
> Pass an environment variable into the container.

Different Docker images define different environment variables. Always check the image documentation to see which ones are supported.

---

## 10. The Docker mental model

At this point, you only need a few concepts.

```text
Docker Registry
      │
      │ pull
      ▼
    Image
      │
      │ docker run
      ▼
  Container
      │
      │ -p
      ▼
Your Machine
```

And the commands we've used so far:

```bash
# Check Docker
docker --version

# Test Docker
docker run hello-world

# Run MongoDB
docker run mongo

# Run MongoDB with a port mapping
docker run -p 27017:27017 mongo

# Run it in the background
docker run -d -p 27017:27017 mongo

# See running containers
docker ps

# Stop a container
docker stop <container-id>
```

That's already enough to start using Docker in your development workflow. You don't need to memorize every Docker command before building something.

Start with one problem:
> I need PostgreSQL.

Then use Docker to solve exactly that problem.

Once that becomes comfortable, learn the next piece: volumes, Docker Compose, Dockerfiles, networks, and building your own images.
