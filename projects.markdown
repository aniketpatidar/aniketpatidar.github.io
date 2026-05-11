---
layout: page
title: Projects
permalink: /projects/
---

<link rel="stylesheet" href="/assets/css/projects.css">

<div class="projects-grid">
  {% for project in site.data.projects %}
    <div class="project-card">
      <a href="{{ project.url }}">
        {% if project.images and project.images.size > 0 %}
          <img src="{{ project.images.first }}" alt="{{ project.title }}" class="project-card-image">
        {% elsif project.github %}
          {% assign github_path = project.github | split: "github.com/" | last %}
          <img src="https://opengraph.githubassets.com/1/{{ github_path }}" alt="{{ project.title }}" class="project-card-image">
        {% endif %}
      </a>

      <div class="project-card-body">
        <h3>
          <a href="{{ project.url }}">{{ project.title }}</a>
        </h3>

        <p>{{ project.description }}</p>

        <div class="project-tags">
          {% for badge in project.badges %}
            <span class="project-tag" data-tag="{{ badge.name }}">{{ badge.name }}</span>
          {% endfor %}
        </div>

        <div class="project-links">
          {% if project.live %}
            <a href="{{ project.live }}" class="project-link" target="_blank">Live</a>
          {% endif %}
          {% if project.github %}
            <a href="{{ project.github }}" class="project-link project-link-github" target="_blank">GitHub</a>
          {% endif %}
          <a href="{{ project.url }}" class="project-link">Details</a>
        </div>
      </div>
    </div>
  {% endfor %}
</div>
