---
layout: page
title: projects
permalink: /projects/
description: Flagship work focused on product outcomes and development process.
nav: true
nav_order: 3
horizontal: false
---

<div class="projects revamp-projects">
  <p class="project-page-intro">
    This page highlights a curated set of flagship projects. For a broader technical snapshot, visit
    <a href="{{ '/repositories/' | relative_url }}">repositories</a>.
  </p>

  {% assign featured_projects = site.projects | where: "featured", true | sort: "importance" %}
  {% if featured_projects.size > 0 %}
    {% if page.horizontal %}
      <div class="container">
        <div class="row row-cols-1 row-cols-md-2">
          {% for project in featured_projects %}
            {% include projects_horizontal.liquid %}
          {% endfor %}
        </div>
      </div>
    {% else %}
      <div class="row row-cols-1 row-cols-md-2">
        {% for project in featured_projects %}
          {% include projects.liquid %}
        {% endfor %}
      </div>
    {% endif %}
  {% else %}
    <p class="project-empty-state">
      No flagship projects are set yet. Add items in <code>_projects/</code> with <code>featured: true</code>.
    </p>
  {% endif %}
</div>
