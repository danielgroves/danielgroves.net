---
layout: blog
published: true
title: Pushing the Bounderies
excerpt: An argument for not living in the past, but pushing the current technologies of the web instead. 

date: 2010-11-13 18:29:22.000000000 +00:00
---
Pushing the boundaries is not something everyone will do on the web.  In fact most people won't even think about incase the client doesn't like it, or because what they would have to do isn't a "proven method" yet.  This is one thing though, that I think we should all be doing, as much as possible.  

One of the ways we can begin to push the boundaries is to use newer technologies like HTML5 and CSS3. Unfortunately I wasn't allowed to use HTML5 for my recent assignment, but I was given permission to use some of the new CSS3 features.  Take, for example, the following screenshot.  

<img src="http://daniel-groves.co.uk/wordpress/wp-content/uploads/2010/11/Screen-shot-2010-11-13-at-10.29.11.png" alt="A &quot;box&quot; on danielgroves.net" title="A &quot;box&quot; on danielgroves.net" width="356" height="240" class="size-full wp-image-334" />

In the days of CSS2.1 this would have been achieved by the careful use of background images.  Due to the flexibility that CSS3 brings I can now create the effects on this box using a few lines of CSS.  

{% highlight css %}
#content .section .box, #content #photo .box img {
	-webkit-border-radius: 3px;
	-webkit-box-shadow: 0 0 7px #888;
	-moz-border-radius: 3px;
	-moz-box-shadow: 0 0 7px #888;
	border-radius: 3px;
	box-shadow: 0 0 7px #888;
}
{% endhighlight %}

So, whats going on here?  <tt>-webkit-border-radius</tt>, <tt>-moz-border-radius</tt> and <tt>border-radius</tt> set the CSS3 border radius to cover webkit browsers, mozilla browsers and then the generic standard that support for is coming.  What this does is it ensures that everyone who has a browser with support will see the 3px rounded corners, and other people will fall-back to normal square corners.  

The other thing this CSS is doing is applying a <tt>box-shadow</tt>, again with webkit, mozilla and generic CSS to ensure the largest possible audience get the effects.  

### Validation

At this point you probably thinking "but surely this doesn't validate".  Well, you'd be right there.  So, stop what your doing and go and watch Elliot Jay Stocks speaking at the Front End Conference 2010, with his presentation ["Stop Worrying &amp; Get On With It"](http://www.frontend2010.com/video/elliot-jay-stocks "Elliot Jay Stocks presentation at Front End Conf, 2010").  

Watched it? Good.  

In his presentation Elliot talks about how we should worry about CSS3 features not validating, and how we should use the CSS3 features to make the experience of browsing the web better for those who use browsers that can run these latest techniques.  The fact that these CSS3 feature won't validate really doesn't matter because they are all 100% degradable for older browsers.  So why not use these new features if they work?

That is why I have used CSS3 in my project, so I hope this is reasoning enough for doing so.  
