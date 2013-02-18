---
layout: default
title: Notebook
excerpt: The Thoughts, Problems and Solutions of a Web Developer

nav-weight: 4
nav-name: Notebook
---

<div class="post-list">
	<ol>
		{% for post in site.posts %}
			{% if forloop.index > 0 %}
				<li><a href="{{ site.base_url }}{{ post.url }}"><strong>{{post.title}}</strong></a> <span class="date">{{ post.date | date: "%d/%m/%Y" }}</span><br />
				<span class="excerpt">{{post.excerpt}}</span></li>
			{% endif %}
		{% endfor %}
	</ol>
</div>