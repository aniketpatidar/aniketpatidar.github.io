---
layout: page
title: Recommendations
permalink: /recommendations/
---

<link rel="stylesheet" href="{{ '/assets/css/custom.css' | relative_url }}?v={{ site.time | date: '%s' }}">

{% for rec in site.data.recommendations %}
  <div class="recommendation-card">
    {% if rec.image_url %}
      <img src="{{ rec.image_url }}" alt="{{ rec.name }}" class="recommendation-photo">
    {% endif %}
    <div class="recommendation-content">
      <h3 class="recommendation-name"><a href="{{ rec.profile_url }}" target="_blank">{{ rec.name }}</a></h3>
      <p class="recommendation-headline">{{ rec.headline }}</p>
      <p class="recommendation-relationship">{{ rec.relationship }}</p>
      <blockquote class="recommendation-text">{{ rec.text | newline_to_br }}</blockquote>
    </div>
  </div>
{% endfor %}
