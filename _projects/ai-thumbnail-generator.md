---
layout: project
title: AI Thumbnail Generator
nav_exclude: true
owner: aniketpatidar
repo: ai-thumbnail-generator
branch: main
github: https://github.com/aniketpatidar/ai-thumbnail-generator
live: https://ai-thumbnail-generator-ashen.vercel.app
description: Generate eye-catching thumbnails in seconds. Upload a photo, add context,
  and get AI-crafted results instantly.
badges:
- name: TypeScript
- name: Next.js
- name: Google Nano Banana
images:
- "/assets/images/ai-thumbnail-generator/Screenshot 2025-11-16 at 12-12-28 Aniket
  Patidar (@aniketpatidar01) _ X.png"
---

<!-- README_START -->

<h1 id="ai-thumbnail-generator">AI Thumbnail Generator</h1>

<p>Generate YouTube thumbnails instantly using AI. Upload a photo, add context, and get AI-crafted results in both 16:9 and 9:16 aspect ratios.</p>

<h2 id="screenshots">Screenshots</h2>

<h3 id="sign-in">Sign In</h3>
<p><img src="https://raw.githubusercontent.com/aniketpatidar/ai-thumbnail-generator/main/images/1.png" alt="Login Interface"></p>

<h3 id="set-your-preferences">Set Your Preferences</h3>
<p><img src="https://raw.githubusercontent.com/aniketpatidar/ai-thumbnail-generator/main/images/2.png" alt="Settings Panel"></p>

<h3 id="generate-thumbnail">Generate Thumbnail</h3>
<p><img src="https://raw.githubusercontent.com/aniketpatidar/ai-thumbnail-generator/main/images/3.png" alt="Progress Tracking"></p>

<h3 id="preview">Preview</h3>
<p><img src="https://raw.githubusercontent.com/aniketpatidar/ai-thumbnail-generator/main/images/4.png" alt="Generated Thumbnails"></p>

<h3 id="final-results">Final Results</h3>
<p><img src="https://raw.githubusercontent.com/aniketpatidar/ai-thumbnail-generator/main/images/5.png" alt="Download &amp; Export"></p>

<h2 id="installation">Installation</h2>

<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code>npm <span class="nb">install</span>
</code></pre></div></div>

<h2 id="configuration">Configuration</h2>

<p>Copy <code>.env</code> file:</p>

<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nb">cp </span>env.example .env
</code></pre></div></div>

<p>Set required variables in <code>.env</code>:</p>

<pre><code class="language-env">GEMINI_API_KEY=''

# Required: Demo Credentials (for reviewer access only)
DEMO_USERNAME=''
DEMO_PASSWORD=''

</code></pre>

<h2 id="running">Running</h2>

<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code>npm run dev
</code></pre></div></div>

<p>Open http://localhost:5173</p>

<h2 id="build">Build</h2>

<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code>npm run build
</code></pre></div></div>
