---
layout: page
title: Contributions
permalink: /contributions/
---

<link rel="stylesheet" href="{{ '/assets/css/contributions.css' | relative_url }}">

{% assign contribs = site.contributions | sort: "order" %}
<section class="contrib-plates" aria-label="Open-source contributions">
  {% for contribution in contribs %}
  <article class="contrib-plate">
    <h2 class="contrib-plate-title">
      <a href="{{ contribution.url }}">{{ contribution.org | join: " & " }}</a>
    </h2>
    <p class="contrib-plate-desc">{{ contribution.description }}</p>
    <div class="contrib-plate-links">
      {% for repo in contribution.repo %}
      <a class="contrib-plate-link" href="{{ repo }}" target="_blank" rel="noopener" aria-label="{{ contribution.org[forloop.index0] }}">{{ contribution.org[forloop.index0] | split: "/" | last }}</a>
      {% endfor %}
    </div>
  </article>
  {% endfor %}
</section>