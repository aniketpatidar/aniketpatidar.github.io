---
layout: page
title: Contributions
permalink: /contributions/
---

<link rel="stylesheet" href="{{ '/assets/css/contributions.css' | relative_url }}">

{% assign contribs = site.contributions | sort: "order" %}
{% assign featured = contribs | where: "featured", true %}
{% assign minor = contribs | where_exp: "c", "c.featured != true" %}

<section class="contrib-plates" aria-label="Featured open-source contributions">
  {% for contribution in featured %}
  <article class="contrib-plate">
    <h2 class="contrib-plate-title">
      <a href="{{ contribution.url }}">{{ contribution.org | join: " & " }}</a>
    </h2>
    <p class="contrib-plate-desc">{{ contribution.description }}</p>
    <div class="contrib-plate-links">
      <a class="contrib-plate-link" href="{{ contribution.url }}">The full story</a>
      {% if contribution.prs %}{% for pr in contribution.prs %}
      <a class="contrib-plate-link" href="{{ pr.url }}" target="_blank" rel="noopener">{{ pr.label }}</a>
      {% endfor %}{% else %}{% for repo in contribution.repo %}
      <a class="contrib-plate-link" href="{{ repo }}" target="_blank" rel="noopener">{{ contribution.org[forloop.index0] | split: "/" | last }}</a>
      {% endfor %}{% endif %}
    </div>
  </article>
  {% endfor %}
</section>

<h2 class="contrib-minor-heading">Smaller fixes</h2>
<ul class="contrib-minor">
  {% for contribution in minor %}
  <li>
    <a href="{{ contribution.url }}">{{ contribution.org | join: " & " }}</a>: {{ contribution.description }}
    {% if contribution.prs %}{% for pr in contribution.prs %}<a href="{{ pr.url }}" target="_blank" rel="noopener">{{ pr.label }}</a>{% unless forloop.last %}, {% endunless %}{% endfor %}{% else %}{% for repo in contribution.repo %}<a href="{{ repo }}" target="_blank" rel="noopener">{{ contribution.org[forloop.index0] | split: "/" | last }}</a>{% unless forloop.last %}, {% endunless %}{% endfor %}{% endif %}
  </li>
  {% endfor %}
</ul>
