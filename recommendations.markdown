---
layout: page
title: Recommendations
permalink: /recommendations/
---

<div class="rec-plates">
{% for rec in site.data.recommendations %}
  <article class="rec-plate">
    <blockquote class="rec-text expandable-text">{{ rec.text | newline_to_br }}</blockquote>
    <button class="read-more-btn" onclick="toggleExpand(this)" style="display: none;">Read more</button>

    <div class="rec-author">
      {% if rec.image_url %}
        <img src="{{ rec.image_url }}" alt="{{ rec.name }}" class="rec-photo" loading="lazy">
      {% endif %}
      <div class="rec-author-info">
        <h2 class="rec-name"><a href="{{ rec.profile_url }}" target="_blank" rel="noopener">{{ rec.name }}</a></h2>
        <p class="rec-headline">{{ rec.headline }}</p>
        {% if rec.relationship %}
        <p class="rec-meta">{{ rec.relationship }}</p>
        {% endif %}
      </div>
    </div>
  </article>
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