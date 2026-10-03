---
layout: project
date: '2026-08-14'
title: AI Thumbnail Generator
nav_exclude: true
owner: aniketpatidar
repo: ai-thumbnail-generator
branch: main
github: https://github.com/aniketpatidar/ai-thumbnail-generator
live: https://ai-thumbnail-generator-ashen.vercel.app
description: Turns a photo and a prompt into YouTube thumbnails in 16:9 and 9:16.
  Users bring their own Gemini API key, which stays in their browser and passes through
  a Vercel function that never stores it, so generation runs on each user's own quota.
badges:
- name: TypeScript
- name: React
- name: Vite
- name: Gemini API
- name: Supabase
images:
- "/assets/images/ai-thumbnail-generator/Screenshot 2025-11-16 at 12-12-28 Aniket
  Patidar (@aniketpatidar01) _ X.png"
order: 2
role: Personal project
---

## How it works

Users sign in with Google through Supabase Auth and add their own Gemini API key. The key stays in their browser and is cleared when they log out. When they generate a thumbnail, a Vercel function checks their session, validates the request, and calls Gemini with their key without storing it.

I built it this way so there's no shared key to leak or pay for. When Gemini returns a free-tier or rate-limit error, the app explains it instead of failing silently.

## Repository README

<!-- README_START -->



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

<p>Users sign in with their Google account, handled by <a href="https://supabase.com/docs/guides/auth">Supabase Auth</a>, then add their own Gemini API key from <a href="https://aistudio.google.com/apikey">Google AI Studio</a>. The key is saved only in their browser and removed on logout. The Vercel function under <code>api/</code> uses it to call Gemini for signed-in users and never stores it, so generation runs on each user’s own quota.</p>

<table>
  <thead>
    <tr>
      <th>Variable</th>
      <th>Purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>VITE_SUPABASE_URL</code></td>
      <td>Supabase project URL. Public.</td>
    </tr>
    <tr>
      <td><code>VITE_SUPABASE_PUBLISHABLE_KEY</code></td>
      <td>Supabase publishable key (<code>sb_publishable_...</code>). Public.</td>
    </tr>
  </tbody>
</table>

<p><strong>Production:</strong> set both in Vercel under Project → Settings → Environment Variables.</p>

<p><strong>Local:</strong> copy the example file and fill it in:</p>

<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nb">cp</span> .env.example .env
</code></pre></div></div>

<h3 id="supabase-setup">Supabase setup</h3>

<ol>
  <li>Create a project at <a href="https://supabase.com">supabase.com</a>, then copy the project URL and publishable key from Project Settings → API Keys.</li>
  <li>Under Authentication → URL Configuration, set <strong>Site URL</strong> to your production URL and add <code>http://localhost:3000</code> to <strong>Redirect URLs</strong>. Google sign-in sends users back here.</li>
</ol>

<h3 id="google-sign-in">Google sign-in</h3>

<ol>
  <li>In <a href="https://console.cloud.google.com/auth/clients/create">Google Cloud Console</a>, create an OAuth client of type <strong>Web application</strong>.
    <ul>
      <li>
<strong>Authorized JavaScript origins:</strong> your production URL and <code>http://localhost:3000</code>.</li>
      <li>
<strong>Authorized redirect URIs:</strong> the callback URL shown in Supabase under Authentication → Sign In / Providers → Google. It looks like <code>https://&lt;project-ref&gt;.supabase.co/auth/v1/callback</code>.</li>
    </ul>
  </li>
  <li>On the Google Auth Platform consent screen, add the <code>openid</code>, <code>userinfo.email</code> and <code>userinfo.profile</code> scopes, and set the app name and logo users will see.</li>
  <li>In Supabase under Authentication → Sign In / Providers → Google, enable the provider and paste the client ID and client secret.</li>
</ol>

<h2 id="running">Running</h2>

<p>Local development uses the <a href="https://vercel.com/docs/cli">Vercel CLI</a>, which serves the frontend and the <code>api/</code> functions together, as in production:</p>

<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code>npm <span class="nb">install</span> <span class="nt">-g</span> vercel
</code></pre></div></div>

<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code>vercel <span class="nb">link</span>
</code></pre></div></div>

<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code>vercel dev
</code></pre></div></div>

<p>Open http://localhost:3000</p>

<h2 id="build">Build</h2>

<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code>npm run build
</code></pre></div></div>
