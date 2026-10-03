---
layout: post
title: "Setting Up asdf to Manage Node.js and Ruby on Ubuntu"
description: "Install asdf on Ubuntu and use it to manage Node.js and Ruby versions from a single CLI."
permalink: /setting-up-asdf-to-manage-nodejs-and-ruby-on-ubuntu/
---

I wanted one tool to manage both Node.js and Ruby versions on Ubuntu. [asdf](https://asdf-vm.com/) does that: a single CLI that manages versions of many languages through plugins. These are the steps I followed to install it and set up Node.js and Ruby.

## Prerequisites

First, make sure you have `curl` and `git` installed. You can install them using the following command:

```bash
sudo apt install curl git
```

## Step 1: Clone the asdf Repository

First, clone the asdf repository from GitHub into your home directory:

```bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
```

This command checks out the version 0.14.0 of asdf. Adjust the version number as needed.

## Step 2: Update Your Shell Configuration

To make asdf available in your terminal, you need to update your shell configuration. Add the following lines to your `~/.bashrc` file:

```bash
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"
```

After adding these lines, reload your `~/.bashrc` file to apply the changes:

```bash
source ~/.bashrc
```

## Step 3: Install Node.js

To install Node.js using asdf, follow these steps:

### Install Additional Dependencies

Node.js requires some additional dependencies which can be installed using the following command:

```bash
sudo apt-get install dirmngr gpg curl gawk
```

### Add the Node.js Plugin

Next, add the Node.js plugin to asdf:

```bash
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
```

### Install the Latest Version of Node.js

You can now install the latest version of Node.js:

```bash
asdf install nodejs latest
```

## Step 4: Install Ruby

To install Ruby using asdf, follow these steps:

### Add the Ruby Plugin

First, add the Ruby plugin to asdf:

```bash
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
```

### Install the Latest Version of Ruby

Now, you can install the latest version of Ruby:

```bash
asdf install ruby latest
```

## Step 5: Verify the Installation

It's important to verify that asdf has correctly installed and configured the runtime versions. You can do this by checking the output of the `type -a ruby` command.

* **Correct Output:**
    
    ```bash
    ruby is /home/username/.asdf/shims/ruby
    ruby is /usr/bin/ruby
    ```
    
* **Incorrect Output:**
    
    ```bash
    ruby is /usr/bin/ruby
    ```

If you see the correct output, it means that asdf is correctly managing the Ruby version.
