---
layout: default
title: Camera Roll
excerpt: Adventures and dabbling with Digital Photography

nav-weight: 5
nav-name: Camera Roll
---

{% for post in site.categories.camera-roll %}
<article class="photo">
	<hgroup>
		<h3><a href="{{ site.base_url }}{{ post.url }}">{{ post.title }}</a></h3>
		<span class="date">{{ post.date | date: "%d/%m/%Y" }}</span>
	</hgroup>
</article>
{% endfor %}