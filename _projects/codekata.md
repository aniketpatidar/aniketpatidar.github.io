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

<blockquote>
  <p>[!NOTE]<br>
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

<blockquote>
  <p>[!IMPORTANT]<br>
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

<h2 id="configuration-options">Configuration Options</h2>

<p>CodeKata uses environment variables for settings. You can find these in the <code>.env</code> file. Common options include:</p>

<ul>
  <li>Database settings for PostgreSQL.</li>
  <li>Redis settings for live updates.</li>
  <li>Judge0 API keys to run code.</li>
</ul>

<blockquote>
  <p>[!TIP]<br>
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

<blockquote>
  <p>[!WARNING]<br>
You must run the tests before you share your changes. Also, you must run Redis on your computer so the tests can pass.</p>
</blockquote>

<h2 id="license">License</h2>

<p>MIT</p>
