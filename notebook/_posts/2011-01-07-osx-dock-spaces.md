---
layout: blog
published: true
title: OS X Dock Spaces
excerpt: A quick video which explains how to add a blank space into your OS X dock. 

date: 2011-01-07 00:42:12.000000000 +00:00
---
A few people recently have been asking how I achieved the spaces in my dock, see the video below for details.  The commands follow so you can copy &amp; paste them.  

<img src="http://daniel-groves.co.uk/wordpress/wp-content/uploads/2011/01/Screen-shot-2011-01-05-at-20.40.281.png" alt="Dock Spaces" title="Dock Spaces" width="454" height="41" class="size-full wp-image-351" />

<iframe src="http://player.vimeo.com/video/18476877?portrait=0" width="440" height="275" frameborder="0"></iframe>

Do this once for every space you want: <tt>defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'</tt>

Followed by this to make them appear: <tt>killall Dock</tt>

