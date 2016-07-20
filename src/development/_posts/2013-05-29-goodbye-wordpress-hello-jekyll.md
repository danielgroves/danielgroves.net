---
comments: true

published: true

title: Goodbye WordPress, Hello Jekyll
excerpt: "Experiences migrating to Jekyll; why I did it, and why I love it. "
permalink: /notebook/2013/05/goodbye-wordpress-hello-jekyll
---

This site ran on WordPress for more years than I can actually remember now. As I said in my blog post *[Version Three][v3]* I simply felt WordPress was somewhat bloated, over-the-top if you will, for what I actually *need*.

> I can't help feeling like Wordpress is suffering from feature-bloat in recent releases. Don't get me wrong, I think Wordpress is ideal for blog-format websites with multiple authors, but on my personal website multiple authors isn't an issue. It's only me.

For this site what I really needed was a simple system for publishing a few, infrequently updated, pages and a blog. For the last few years I've been doing most of my writing in [Markdown][mdown], writing in the fantastic [iA Writer][iawriter], and exporting to HTML to throw into WordPress.

When I decided to redesign my site I concluded that I wanted to use a static site generator almost immediately. Once of the main things I wanted to improve was the speed of the site, something you can't beat static files for. In the end I chose [Jekyll][docs] over the alternatives simply due to its popularity; popular products build their reputations for a reason, and tend to have a better community behind them.

As I've already mentioned, for the last few years I've primarily been writing in Markdown. It seemed pointless to continue writing in Markdown and manually converting it to HTML to publish. Jekyll comes with native support for quite a few Markdown engines, and was easily configured to use RedCarpet with just a couple of lines in my ```_config.yml``` file.

{% highlight yaml %}
redcarpet:
	extensions: []
{% endhighlight %}

I decided against using a framework with Jekyll as it, in my experience, limits the learning curve. I wanted to learn how Jekyll works, what it can do natively, and how to extend it. I felt like using a framework would be much more limiting in how much it would allow me to learn.

Once thing I *was* going to say at this point as how incomplete the documentation for Jekyll felt, however this has changed since I last checked as a [documentation site][docs] has been developed.

## Exporting from WordPress

One of the first things I did after committing to using Jekyll was to [export my posts from WordPress][wpexport]; this proved to be the biggest headache of the migration.

The initial export went well, the necessary metadata was copied across as expected. I striped out the tags and categories as I simply didn't want these at this stage and was left with something like this for each of the posts:

{% highlight yaml %}
layout: default
comments: true

published: true
title: AlfredApp Custum Colour Scheme

date: 2011-01-05 22:36:23.000000000 +00:00
{% endhighlight %}

I proceeded to add an excerpt for most of the posts and then generate the site for the first time.

*Ka–boom*.

When I exported from Wordpress it turned out quite a few things had gone wrong. The main issues were that some characters weren't encoded properly, and shortcuts hadn't been executed. This was a pain in the arse, but not the end of the world. It was a painfully slow process of finding a corrupt character, finding out what it should be, and then running a find-and-replace to deal with them all. Yes, I could probably have written a script to deal with all of this for me, but I simply couldn't be-bothered.

Once characters had been dealt with I used a similar technique to deal with short-codes.

## Navigation

The navigation is one thing I am yet to perfect. Just to be clear, I'm not talking about the [post listing][post-list] here, but the page navigation. This is one of the areas of Jekyll that I found to be less-well documented and one area which I intend to revisit as soon as time allows.

Look at any of the links in the navigation at the top of this page, and you'll notice they all end in `index.html`; this bugs me. Each page has its own directory, so I really don't want the `index.html` appended to the end. By all means append the file-name if a directory contains a file which is not the index file, but this is completely unnecessary when the directory *does* contain an index file.

This isn't really a major problem though, but I do intend to come back and fix it in the future.

## Harder, Better, Faster, Stronger

Since moving to Jekyll I've been writing more, something I'm putting this down to a workflow which suits me better. In all honesty, I've never been a huge fan of the WordPress content editor; it's distracing and misses important features in full-screen mode. Markdown provides me with all the features I need as I write, without the distraction.

I can sit-down and write in my favourite Markdown editor and simply focus on getting the words out. There's no thoughts about presentation crossing my mind like before, the two processes have been separated. I write the words, then deal with the presentation. Not everyone likes working like this, but that doesn't matter for this site. It's about what suits *me*.

Moving to Jekyll hasn't lost me any *useful* features that I had with WordPress. I can still specify custom page templates, tags and categories or change the publish-date on a post. The only really difference is in *how* this is now done, with the use of [front-matter][fmatter].

Jekyll is actually easier to extend with the use of custom meta-data than other systems. There's no configuration to declare a new meta-tag, you just add it then integrate it into your templates in whatever way you want. For example this post has the following custom meta-tag:

{% highlight yaml %}
excerpt: "Details on making the move from WordPress to Jekyll, and the problems faced. "
{% endhighlight %}

Now this has been declared (which really is as simple as adding it to the front-matter), you can easily call it in any template.

{% highlight html %}
<p class="blog">{{ "{{ page.excerpt" }} }}</p>
{% endhighlight %}

That's it.

## Summary

I love how easy it is to just add anything I like into tempaltes without having to 'declare' a feature to some content managment system. For me, it's got everything I need and nothing I don't need. I can write in Markdown, commit everything into one Git repository, and publish the whole site in a couple of commands.

I guess what I'm trying to get at here is that [Jekyll][docs] isn't the perfect solution for everyone, but it's suit me down to the 't'.

[v3]: http://danielgroves.net/notebook/2013/03/version-three/ "The changes that came with Version Three of my personal site"
[mdown]: http://daringfireball.net/projects/Markdown/ "Markdown on Daring Fireball"
[iawriter]: http://www.iawriter.com "iA Writer Markdown editor for Mac and iOS"
[docs]: http://jekyllrb.com "Jekyll documentation site"
[wpexport]: https://github.com/mojombo/jekyll/wiki/Blog-Migrations "Migrations in the Jekyll Wiki"
[post-list]: /notebook "Posting listing on danielgroves.net"
[fmatter]: http://jekyllrb.com/docs/frontmatter/ "YAML Front Matter with Jekyll"
