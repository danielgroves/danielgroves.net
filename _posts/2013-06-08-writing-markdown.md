---
layout: blog
published: true

title: Writing Markdown
excerpt: "Moving from iA Writer to Byword 2, for a more complete and better experience writing Markdown in a distraction-free environment"
---

I've used [iA Writer][ia] for as long as I can remember on both Mac and iOS for writing markdown now.  It's a nice, simple, minimalist editor and it's fairly priced too. I've always liked that it has a iOS counterpart, with full dropbox integration so moving from my Mac to my iPad is pretty much seamless. 

Today, I spotted the announcement for [Byword 2][byword] though, and thought I'd take a look. It only took a couple of minutes of flicking through screenshots for me to decide I wanted to give it a go. I downloaded it onto my iPad and flicked through a few existing Markdown documents in dropbox quickly noting how elegant it is – and it truly is elegant. 

Generally, I don't want many features when writing markdown. I want a minimal editor which does away with all of the menus and any other clutter; I want to focus on writing. This is was always exactly why I chose to write in iA Writer, it did just this and nothing else. It was, however, far from perfect. 

### The Problems

The problem with iA Writer, in the end, is the *lack* of features. Never thought I'd be saying that when it comes to a Markdown writer. Let me explain. 

Everything starts off fine, you start writing and then you notice the font is actually really quite ugly and then you'd rather choose your own from the system. After all, if the type is constantly bugging you (and it's the only thing on the screen) then you really aren't going to get much work done. Ah, you can't change it; just have to live with that one then. 

Now everything is fine for a while. One-day you decide to try out 'Focus Mode', hit the keyboard shortcut to turn it on and continue writing. Later you flick it back off to proof–read your work, and some of the text is still faded out. That's annoying. Now some of your document is black and some grey. 

As you continue to progress further still with your knowledge of markdown you decide to stop using 'traditional' links and use the more advanced 'reference' links. These make more sense as they help to remove clutter from the document, and place the list of long URLs all together at the end (or wherever you decide to put them).  Now you type one of these in and fire up preview mode, where iA Writer doesn't support them leaving your work broken and unreadable. 

This isn't the only unsupported feature either. I've yet to get images or code blocks working yet either. These, however, weren't the most irritating issue. For me, one of the most irritating issues was how broken the basic link handling was. Take the following, for example. 

```
[iA Writer](http://iawriter.com "iA Writer Website")
```

This snippet should render something like this in HTML:

{% highlight html %}
<a href="http://iawriter.com" title="iA Writer Website">iA Writer</a>
{% endhighlight %}

Yet in reality, I was getting this:

{% highlight html %}
<a href="http://iawriter.com iA Writer Website">iA Writer</a>
{% endhighlight %}

I'm sorry, but for such as basic feature as converting markdown to HTML, I'd expect that to work flawlessly. Every-time. 

### Trailing Byword

My experiment so far shows Byword 2 to be a much more stable, reliable, editor; it doesn't seem to suffer from the same issues as iA Writer.  Unlike iA Writer, Byword comes with a very basic preferences panel. This has all the customisations you may want, without adding any feature bloat. 

<figure>
	<img src="/assets/images/blog/2013-06-08-writing-markdown/BywordPreferences.png" alt="Byword 2 Preferences" />
	<figcaption>
		Byword 2 Preferences
	</figcaption>
</figure>

As the screenshot shows Byword makes it easy to change the font (not that you'll find yourself wanting to) as well as activating a dark theme for writing at night (perfect for students doing the last–minute all–nighter) and tweaking the column width to your liking. Excellent start. 

Focus mode can also be fine-tuned to your personal taste in Byword. It allows two options, both of which can be activated using simple keyboard shortcuts. The first is *line focus* which highlights the current line (my personal preference) and the other is *paragraph focus*, which highlights the whole paragraph. Unlike iA Writer, as you turn these on and off in Byword the text highlighting is set properly without any bugs leaving you with weird patterns of highlighting. 

<figure>
	<img src="/assets/images/blog/2013-06-08-writing-markdown/BywordFocus.png" alt="Byword 2 Focus Modes" />
	<figcaption>
		Byword 2 Focus Modes
	</figcaption>
</figure>

Bywords has no issues using references links, or exporting links to clean and semantic HTML either. This means that, for me, Byword pretty much ticks all of the boxes. 

### iOS

Both iA Writer and Byword have iOS counterparts, each of them integrates with Dropbox and iCloud to make it easy to pickup working where you left off on your Mac. 

Byword features a clean interface which is easily of the same quality of it's desktop application. It features a shortcut bar above the iOS keyboard, which can be swiped across as access a well thought-out selection of characters and shortcuts to help you write Markdown more productively. 

<figure>
	<img src="/assets/images/blog/2013-06-08-writing-markdown/BywordIpad.png" alt="Byword for iOS is about as slick as they come" />
	<figcaption>
		Byword for iOS is about as slick as they come
	</figcaption>
</figure>

iA Writer on iPad is pretty much identical to it's Mac version. It suffers from the same fallbacks, and the same interface-woes. It also features a shortcut toolbar, but for me it was always missing the two or three characters I used the most. 

<figure>
	<img src="/assets/images/blog/2013-06-08-writing-markdown/IaWriterIpad.png" alt="iA Writer on iPad, much like on Mac, could be a lot slicker" />
	<figcaption>
		iA Writer on iPad, much like on Mac, could be a lot slicker
	</figcaption>
</figure>

---

To me [iA Writer][ia] always felt like the shadow of something that could be a lot better. It did what I needed it to do, just about. The main attraction to it for me was always distraction free writing, which it did well, but it has always felt more like a *beta* product than something ready for market. 

On the other hand, [Byword][byword] is exactly what iA Writer should be. It's slick, it has all the features you need and none that you don't. The features it has also **work properly**, something which cannot be said for iA Writer. This article no–doubt sounds very biased to anyone reading it, this isn't simply because I prefer Byword over iA Writer, it's simply because Byword is so much *better* than iA Writer. 

Perhaps seeing Byword will show the iA team how much better their product *could* be; maybe I'll find myself switching back in a years time. 

[ia]: http://www.iawriter.com/ "iA Writer markdown editor for Mac and iOS"
[byword]: http://bywordapp.com "Byword 2, Markdown editor for Mac and iOS"