---
layout: default
title: Notebook
nav-weight: 4
nav-name: Notebook
---

Essentially my blog

<ol>
	{% for post in site.posts %}
		{% if forloop.index > 0 %}
			<li><a href="{{ site.base_url }}{{ post.url }}">{{post.title}}</a> <span>{{ post.date | date: "%d/%m/%Y" }}</span></li>
		{% endif %}
	{% endfor %}
</ol>