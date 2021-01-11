---
layout: default
nav: true
title: Projects
css: projects
---

<section>
{% for project in site.projects %}
<article>
<h1>{{ project.title }}: <span class="start-date">{{ project.start | date_to_string }}</span> - <span class="end-date">{{ project.end | date_to_string }}</span></h1>

{{ project.content | markdownify | smartify }}
</article>
{% endfor %}
</section>
