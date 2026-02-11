---
layout: page
permalink: /repositories/
title: repositories
description: Projects I am building and maintaining.
nav: true
nav_order: 4
---

<div class="revamp-repositories">
  {% if site.data.repositories.profile and site.data.repositories.profile.username %}
    {% include repository/repo_intro_strip.liquid %}
  {% endif %}

  <section class="repo-projects-section" aria-label="Repository projects">
    <h2>Projects</h2>
    <p class="repo-projects-subtitle">A curated set of repositories with practical impact and technical depth.</p>

    {% assign sorted_repos = site.data.repositories.repositories | sort: "priority" %}
    {% if sorted_repos and sorted_repos.size > 0 %}
      <div class="repo-card-grid">
        {% for repo in sorted_repos %}
          {% include repository/repo_card.liquid repository=repo %}
        {% endfor %}
      </div>
    {% endif %}
  </section>
</div>
