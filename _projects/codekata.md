---
layout: project
date: '2026-08-14'
title: CodeKata
nav_exclude: true
owner: aniketpatidar
repo: codekata
branch: main
github: https://github.com/aniketpatidar/codekata
description: Head-to-head Ruby coding games built with Rails. Two players race through
  rounds while Action Cable keeps their editors in sync, and Judge0 runs each submission
  in a sandbox.
badges:
- name: Rails
- name: Hotwire
- name: Action Cable
- name: PostgreSQL
- name: Judge0
images: []
order: 1
role: Personal project, built solo
---

## How it works

A challenger picks 1, 3, or 5 rounds and a difficulty. Each round gets a random challenge, and whoever passes every test first wins it. Three Action Cable channels keep the shared editor, the game state, and the list of who's online up to date.

Submissions go through `CodeEvaluation` to [Judge0](https://judge0.com/), which runs them in a sandbox and checks the output against the challenge's tests. The executor is injected, so the test suite swaps Judge0 out. When a game ends, a `GameScorer` service works out each player's score change. Winners earn more for beating higher-scored opponents, and losers keep the rounds they won.

The domain vocabulary (Challenge, Game, Round, Mock) is written down in the repo's `CONTEXT.md`, so the code and the conversations use the same words. CI runs the tests, RuboCop, and Brakeman on every pull request.

## Next on the list

- Move code evaluation into a background job and use Judge0's batch submissions, so a request doesn't wait on the sandbox.
- Upgrade the app from Rails 7.1 to Rails 8.

## Repository README

<!-- README_START -->



<blockquote class="readme-alert readme-alert-note">
<p class="readme-alert-title">Note</p>
  <p>
CodeKata is a coding platform for Ruby developers.</p>
</blockquote>

<p>This project helps you improve your Ruby skills. You can solve coding challenges and play games against friends. You can also write code together in real-time and talk about answers in the forum. It makes coding practice fun.</p>

<h2 id="features">Features</h2>

<ul>
  <li>Real-time code editor (CodeMirror 6)</li>
  <li>Live updates and web sockets via ActionCable</li>
  <li>Code evaluation against Judge0 API</li>
</ul>

<h2 id="installation">Installation</h2>

<p>Follow these steps to install CodeKata.</p>

<blockquote class="readme-alert readme-alert-important">
<p class="readme-alert-title">Important</p>
  <p>
You must install Ruby 3.2.2, PostgreSQL, Redis, and Node.js first.</p>
</blockquote>

<ol>
  <li>Get the code:
    <div class="language-bash highlighter-rouge">
<div class="highlight"><pre class="highlight"><code>git clone https://github.com/aniketpatidar/codekata.git
<span class="nb">cd </span>codekata
</code></pre></div>    </div>
  </li>
  <li>Set up your settings:
    <div class="language-bash highlighter-rouge">
<div class="highlight"><pre class="highlight"><code><span class="nb">cp</span> .env.example .env
</code></pre></div>    </div>
  </li>
  <li>Run the setup script:
    <div class="language-bash highlighter-rouge">
<div class="highlight"><pre class="highlight"><code>bin/setup
</code></pre></div>    </div>
  </li>
</ol>

<h2 id="usage">Usage</h2>

<p>Start the server to use CodeKata locally:</p>
<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>bin/rails server
</code></pre></div></div>
<p>Then, open <code>http://localhost:3000</code> in your web browser.</p>

<h3 id="docker-alternative">Docker (alternative)</h3>

<p><code>docker-compose.yml</code> runs the app, Postgres, and Redis as containers:</p>

<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code>docker compose up <span class="nt">-d</span>
</code></pre></div></div>

<p>Postgres and Redis publish to <code>localhost:5432</code> and <code>localhost:6379</code>, so commands run on the host (<code>bin/rails test</code>, <code>bin/rails console</code>, etc.) can point <code>DATABASE_URL</code>/<code>REDIS_URL</code> at <code>localhost</code> rather than a container IP — container IPs are assigned dynamically and change on every restart.</p>

<h2 id="configuration-options">Configuration Options</h2>

<p>CodeKata uses environment variables for settings. You can find these in the <code>.env</code> file. Common options include:</p>

<ul>
  <li>Database settings for PostgreSQL.</li>
  <li>Redis settings for live updates.</li>
  <li>Judge0 API keys to run code.</li>
</ul>

<blockquote class="readme-alert readme-alert-tip">
<p class="readme-alert-title">Tip</p>
  <p>
Look at the <code>.env.example</code> file. It shows all the settings you can use.</p>
</blockquote>

<h2 id="source-code-guide">Source Code Guide</h2>

<p>CodeKata is a normal Ruby on Rails 7 app. These folders will help you understand the code:</p>

<ul>
  <li>
<code>app/javascript/</code>: Holds the code editor files (CodeMirror 6).</li>
  <li>
<code>app/channels/</code>: Manages live updates and web sockets (ActionCable).</li>
  <li>
<code>lib/</code>: Contains the code that sends tests to Judge0.</li>
</ul>

<h2 id="contributing">Contributing</h2>

<p>We want your help! Please read <code>CONTRIBUTING.md</code> to learn how to add code.</p>

<blockquote class="readme-alert readme-alert-warning">
<p class="readme-alert-title">Warning</p>
  <p>
You must run the tests before you share your changes. Also, you must run Redis on your computer so the tests can pass.</p>
</blockquote>

<h2 id="license">License</h2>

<p>MIT</p>
