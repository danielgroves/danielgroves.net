---
layout: default
title: Notebook
excerpt: The Thoughts, Problems and Solutions of a Student and Web Developer

nav-weight: 4
nav-name: Notebook
---

<div class="columns-2 post-list-excerpt">
	<h3>Recent Entries</h3>
	
	<div class="col">
		<ol>
			{% for post in site.posts %}
				{% if forloop.index <= 5 %}
					<li>
						<a href="{{ site.base_url }}{{ post.url }}"><strong>{{post.title}}</strong></a> <span class="date">{{ post.date | date: "%d/%m/%Y" }}</span><br />
						<span class="excerpt">{{post.excerpt}}</span>
					</li>
				{% endif %}
			{% endfor %}
		</ol>
	</div>
	
	<div class="col">
		<ol start="6">
			{% for post in site.posts %}
				{% if forloop.index > 5 %}
					{% if forloop.index <= 10 %}
						<li>
							<a href="{{ site.base_url }}{{ post.url }}"><strong>{{post.title}}</strong></a> <span class="date">{{ post.date | date: "%d/%m/%Y" }}</span><br />
							<span class="excerpt">{{post.excerpt}}</span>
						</li>
					{% endif %}
				{% endif %}
			{% endfor %}
		</ol>
	</div>
	
</div>

<h3>All Entries</h3>
<div class="full post-list">
	<ol>
		{% for post in site.posts %}
			{% if forloop.index > 0 %}
				<li>
					<a href="{{ site.base_url }}{{ post.url }}"><strong>{{post.title}}</strong></a> <span class="date">{{ post.date | date: "%d/%m/%Y" }}</span>
				</li>
			{% endif %}
		{% endfor %}
	</ol>
</div>