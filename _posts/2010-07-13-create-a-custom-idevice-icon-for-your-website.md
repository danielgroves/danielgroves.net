---
layout: blog
published: true
title: Create a custom iDevice icon for your website
date: 2010-07-13 17:15:04.000000000 +01:00
---
This is something that has had me baffled for a little while now.  I have, and have had for a long time, a [favicon](http://www.w3.org/2005/10/howto-favicon) for this website, but what I was unable to figure why the icon was not being applied to the bookmark icon on my iPod Touch homescreen.

<img class="size-large wp-image-98 " title="iPod Home-Screen Icons" src="http://danielgroves.net/wp-content/uploads/2010/07/photo-590x456.png" alt="iPod Home-Screen Icons" width="413" height="319" />

Despite what I first thought, it turns out that the favicon is not what is used to create these icons on your iDevice.  Now, before going any further, I would like to make it clear that their is absolutely no reason what-so-ever that this will not work for any Apple touch-screen device.  These are, at this time, the [iPod Touch](http://www.apple.com/ipodtouch/), the [iPhone](http://www.apple.com/iphone/) and the [iPad](http://apple.com/ipad).  

In order to make one of these icons you will need a high quality icon that you have made for you website. In order to prevent confusion I would recommend that you use a higher quality version of you favicon.  Save your icon as a <strong>45px by 45px</strong> file called "<strong>apple-touch-icon.png</strong>".  Once you have done this save it in the root directory of your website [very much like I have](http://daniel-groves.co.uk/apple-touch-icon.png).  

For those who like to be particularly tidy, their is another way that allows you to file your icon away where it is nice a tidy.  In order to do this save your icon as a <strong>45px by 45px</strong> file called "<strong>apple-touch-icon.png</strong>", as with the last method, but this time save it wherever you like.  Then add the following line between the <tt>head</tt> tags on your website.  

{% highlight html %}
<link rel="apple-touch-icon" href="/path/to/file/apple-touch-icon.png" />
{% endhighlight %}

Thinking about it, with this second method their is no real reason to even bother with the file name I have suggested.  Go mad, call it whatever you like, just don't forget to update the mark-up accordingly.

### Adding a site to your Home-screen

For those who do not know how to add bookmarks to their home-screen on their iDevice simply go to the page in safari and then follow these steps:

1) Press the little "+" symbol (centre bottom)
1) Click "Add to Home Screen"
1) Name it as you like, and <strong>wait a moment to ensure any icons that are present download</strong>
1) Click Add (top right)
1) Done! Your Icon will have been added in the first empty space

Thats all there is to it, and it is one thing I would encourage everyone to do just to help keep people sane when they bookmark your site on their iDevice.
