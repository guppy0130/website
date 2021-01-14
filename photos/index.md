---
layout: no-margin
nav: true
title: Photos
css: photos
---

{% assign pieces = site.static_files | where: "portfolio", true %}
{% assign pieces = pieces | reverse %}

<div class="content">
{% for piece in pieces %}
{% if piece.img %}
{% responsive_image_block %}
  path: {{ piece.path | slice: 1,piece.path.size }}
{% endresponsive_image_block %}
{% endif %}
{% if piece.vid %}
  <video autoplay loop muted>
    <source src="{{ piece.path | replace: 'mp4', 'webm' }}" type="video/webm">
    <source src="{{ piece.path }}" type="video/mp4">
  </video>
{% endif %}
{% endfor %}
</div>
