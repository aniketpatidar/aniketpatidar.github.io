---
layout: page
title: Projects
permalink: /projects/
---

<link rel="stylesheet" href="/assets/css/projects.css">

Here's a collection of projects I've built, ranging from full-stack applications to AI-powered tools and learning experiments.

<div class="projects-grid">
  {% for project in site.data.projects %}
    <div class="project-card">
      <div class="project-header">
        <h3>
          <a href="{{ project.url }}">{{ project.title }}</a>
        </h3>
      </div>
      
      {% if project.images and project.images.size > 0 %}
        <div class="project-images">
          {% for image in project.images %}
            <img src="{{ image }}" alt="{{ project.title }} screenshot" class="project-image">
          {% endfor %}
        </div>
      {% elsif project.github %}
        {% assign github_path = project.github | split: "github.com/" | last %}
        <img src="https://opengraph.githubassets.com/1/{{ github_path }}" alt="{{ project.title }} preview" class="project-image project-image-og">
      {% endif %}

      <p>{{ project.description }}</p>
      <div class="project-meta">
        <div class="project-tags">
          {% for badge in project.badges %}
            <span class="project-tag">{{ badge.name }}</span>
          {% endfor %}
        </div>
        <div class="project-links">
          {% if project.live %}
            <a href="{{ project.live }}" class="project-link" target="_blank">Live</a>
          {% endif %}
          {% if project.github %}
            <a href="{{ project.github }}" class="project-link" target="_blank">GitHub</a>
          {% endif %}
          <a href="{{ project.url }}" class="project-link">View Project</a>
        </div>
      </div>
    </div>
  {% endfor %}
</div>
