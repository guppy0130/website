---
layout: default
title: Blog
css: blog
pagination:
    enabled: true
---

<h1>Blog</h1>

{% for post in paginator.posts %}
{% include post.html post=post %}
{% endfor %}

{% if paginator.total_pages > 1 %}
<div class="pagination">
    {% comment %}
    These are older posts. Your pagination is reversed on purpose.
    {% endcomment %}
    {% if paginator.next_page %}
    <a href="{{ paginator.next_page_path }}">&lt;&lt;</a>
    {% else %}
    <p>&nbsp;&nbsp;</p>
    {% endif %}

    <div class="separator">
        {{ paginator.page }} / {{ paginator.total_pages }}
    </div>
    {% comment %}
    These are newer posts. Your pagination is reversed on purpose.
    {% endcomment %}
    {% if paginator.previous_page %}
    <a href="{{ paginator.previous_page_path }}">&gt;&gt;</a>
    {% else %}
    <p>&nbsp;&nbsp;</p>
    {% endif %}
</div>
{% endif %}
