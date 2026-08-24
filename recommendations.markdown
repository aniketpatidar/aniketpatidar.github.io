---
layout: page
title: Recommendations
permalink: /recommendations/
---

<link rel="stylesheet" href="{{ '/assets/css/custom.css' | relative_url }}?v={{ site.time | date: '%s' }}">

<div class="recommendations-grid">
{% for rec in site.data.recommendations %}
  <div class="recommendation-card">
    <div class="recommendation-text-wrapper">
      <blockquote class="recommendation-text expandable-text">"{{ rec.text | newline_to_br }}"</blockquote>
      <button class="read-more-btn" onclick="toggleExpand(this)" style="display: none;">Read more</button>
    </div>
    <div class="recommendation-author">
      {% if rec.image_url %}
        <img src="{{ rec.image_url }}" alt="{{ rec.name }}" class="recommendation-photo">
      {% endif %}
      <div class="recommendation-author-info">
        <h3 class="recommendation-name"><a href="{{ rec.profile_url }}" target="_blank">{{ rec.name }}</a></h3>
        <p class="recommendation-headline">{{ rec.headline }}</p>
      </div>
    </div>
  </div>
{% endfor %}
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
  const texts = document.querySelectorAll('.expandable-text');
  texts.forEach(text => {
    if (text.scrollHeight > text.clientHeight) {
      const btn = text.nextElementSibling;
      btn.style.display = 'inline-block';
    }
  });
});

function toggleExpand(btn) {
  const text = btn.previousElementSibling;
  if (text.classList.contains('expanded')) {
    text.classList.remove('expanded');
    btn.textContent = 'Read more';
  } else {
    text.classList.add('expanded');
    btn.textContent = 'Read less';
  }
}
</script>
