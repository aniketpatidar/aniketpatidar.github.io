---
layout: page
title: Recommendations
permalink: /recommendations/
---

<style>
.recommendation-card {
  display: flex;
  gap: 24px;
  margin-bottom: 3rem;
  padding-bottom: 2rem;
  border-bottom: 1px solid rgba(255,255,255,0.1);
}
.recommendation-photo {
  border-radius: 50%;
  width: 72px;
  height: 72px;
  object-fit: cover;
  flex-shrink: 0;
  margin-top: 5px;
}
.recommendation-name {
  margin: 0 0 0.2rem 0 !important;
  font-size: 1.4rem;
}
.recommendation-name a {
  text-decoration: none;
}
.recommendation-headline {
  margin: 0 0 0.3rem 0;
  font-size: 0.95rem;
  opacity: 0.9;
}
.recommendation-relationship {
  margin: 0 0 1.2rem 0;
  font-size: 0.85rem;
  opacity: 0.6;
}
.recommendation-text {
  margin: 0;
  padding-left: 1rem;
  opacity: 0.85;
  font-size: 0.95rem;
  line-height: 1.6;
}
@media (max-width: 600px) {
  .recommendation-card {
    flex-direction: column;
    gap: 8px;
  }
  .recommendation-photo {
    margin-top: 0;
  }
}
</style>

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
