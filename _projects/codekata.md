---
layout: project
title: CodeKata
nav_exclude: true
owner: aniketpatidar
repo: codekata
branch: main
github: https://github.com/aniketpatidar/codekata
description: A competitive coding platform for Ruby developers. Solve challenges,
  compete in multi-round games against friends, collaborate in real-time, and discuss
  solutions in the community forum.
badges:
- name: Rails
- name: Hotwire
- name: PostgreSQL
images: []
---

<!-- README_START -->

<h1 id="codekata">CodeKata</h1>

<p>A competitive coding platform for Ruby developers. Solve challenges, compete in multi-round games against friends, collaborate in real-time, and discuss solutions in the community forum.</p>

<h2 id="stack">Stack</h2>

<ul>
  <li>Ruby on Rails 7, PostgreSQL</li>
  <li>Hotwire (Turbo + Stimulus), ActionCable</li>
  <li>CodeMirror 6, Judge0</li>
</ul>

<h2 id="setup">Setup</h2>

<p><strong>Requirements:</strong> Ruby 3.2.2, PostgreSQL, Redis, Node.js</p>

<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code>git clone https://github.com/aniketpatidar/codekata
</code></pre></div></div>
<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nb">cd </span>codekata
</code></pre></div></div>
<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nb">cp</span> .env.example .env
</code></pre></div></div>
<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code>bin/setup
</code></pre></div></div>

<p>Open <code>http://localhost:3000</code>.</p>

<h2 id="license">License</h2>

<p>MIT</p>
