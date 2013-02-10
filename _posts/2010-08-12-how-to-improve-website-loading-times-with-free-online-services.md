---
layout: blog
published: true
title: How to Improve Website Loading Times with Free Online Services
date: 2010-08-12 11:54:14.000000000 +01:00
---
[<img src="http://danielgroves.net/wp-content/uploads/2010/08/3115367361_2ef6f470b2_b.jpg" alt="Photo by lrargerich" title="Photo by lrargerich" width="465" height="174" class="size-full wp-image-299" />](http://www.flickr.com/photos/lrargerich/3115367361/)

Fast loading times are vital for any website, and one of the most effective ways to speed up a website is to minimise the size of all of the files that need to be downloaded, weather they are CSS, JavaScript or images. 

Doing this really is a quick and easy process - it isn't labour intensive in the slightest.  The first thing you will want to do is take all of your CSS and JavaScript files and duplicate them.  Once you have done this add <tt>.min </tt> into the extension on all these new files, what was <tt>main.css</tt> should now read <tt>main.min.css</tt> and <tt>lightbox.js</tt> would read <tt>lightbox.min.js</tt>, for example.  Optionally, you could copy the original files into another folder for safe keeping, or you could just leave them.  

<img src="http://danielgroves.net/wp-content/uploads/2010/08/Screen-shot-2010-08-10-at-21.41.23-550x363.png" alt="My CSS Folder" title="My CSS Folder" width="550" height="363" class="size-large wp-image-267" />

Now, if you decide to watch the video where I show you how to do this, I do apologise in advance if you can here my MacBook fan in the background, but backing-up a DVD is very CPU intensive, and so the fan did start to spin up during the MP4 encoding process.  

<object width="600" height="375"><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="movie" value="http://vimeo.com/moogaloop.swf?clip_id=14085276&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=0&amp;show_portrait=0&amp;color=00ADEF&amp;fullscreen=1&amp;autoplay=0&amp;loop=0" /><embed src="http://vimeo.com/moogaloop.swf?clip_id=14085276&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=0&amp;show_portrait=0&amp;color=00ADEF&amp;fullscreen=1&amp;autoplay=0&amp;loop=0" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="600" height="375"></embed></object>

### CSS

<img src="http://danielgroves.net/wp-content/uploads/2010/08/Screen-shot-2010-08-11-at-11.07.19-550x485.png" alt="CSS-Drive CSS compressor loaded with my print.css file" title="CSS-Drive CSS compressor loaded with my print.css file" width="550" height="485" class="size-large wp-image-274" />

1) Navigate your browser to the [CSS-Drive CSS Compressor](http://cssdrive.com/index.php/main/csscompressor)
1) Set the compression mode to "Super Compact"
1) Set the Comments Handling to "Strip ALL comments"
1) Hit the "Compress-it!" Button
1) Copy and Paste the output over the top of <strong>everything</strong> in the appropriate <tt>.min.css</tt> file
1) Repeat with other CSS files

If after this you get any problem try fiddling with the settings.  It's probably just mis-interprited your CSS and so different settings may give better results. 

To give an idea of how effective this is, and what exactly it does here is my <tt>print.css</tt> file before compressing.  

{% highlight css %}
body {
	font-family: Helvetica, Vedana, Sans-serif;
	font-size: small;
	line-height: 150%;
	}

#mainNavigation, #footer, #comments form, #comments h3 {
	display: none;
}

h1 {
	padding: 10px 0 0 10px;
	font-family: "Blue Highway";
	font-size: 400%;
	letter-spacing: 1px;
	word-spacing: -0.22em;
	text-transform: lowercase;
	font-weight: normal;
	text-align: center;
	}
h1 span {
	color: #9A140F;
}

a:link {
	color: navy;
}

a:link:after {
	content:  " (" attr(href) ") ";
	font-size: small;
	color: #333;
}

a.footnote-link:link:after {
	content: "" !important;
}
{% endhighlight %}

And exactly the same file <em>after</em> compression.  

{% highlight css %}
body{font-family:Helvetica,Vedana,Sans-serif;font-size:small;line-height:150%}#mainNavigation,#footer,#comments form,#comments h3{display:none}h1{padding:10px 0 0 10px;font-family:"Blue Highway";font-size:400%;letter-spacing:1px;word-spacing:-0.22em;text-transform:lowercase;font-weight:normal;text-align:center}h1 span{color:#9A140F}a:link{color:navy}a:link:after{content: "("attr(href) ") ";font-size:small;color:#333}a.footnote-link:link:after{content:""!important}
{% endhighlight %}

As you can see the new file isn't exactly readable, which is why we keep this in a <tt>.min.css</tt> file.  This way it is easy to see which is the compressed version of the CSS for the live server and which is the un-compressed version for development.  

Once you have done this you will need to update your links on your <strong>live</strong> site to point to these new files.  

### JavaScript

Compressing JavaScript is just as easy as compressing CSS, except we have to use a different website this time.  

<img src="http://danielgroves.net/wp-content/uploads/2010/08/Screen-shot-2010-08-11-at-12.40.46-550x521.png" alt="jscompress.com loaded with some jQuery" title="jscompress.com loaded with some jQuery" width="550" height="521" class="size-large wp-image-281" />

To compress your JavaScript:

1) Open JS Compress in your browser
1) Copy and paste your JavaScript into the text area
1) Ensure you have "Minify (JSMin)" select from the drop-down
1) Hit the "Compress javaScript" button

This works very much like the CSS compressor. I put the following JavaScript through the compressor:

{% highlight js %}
(function($){


	$(document).ready(function() {
	
		
		
		$('#lastfmButton').click(function() { // Mouse Click
		
			
			$('#footer .containor').removeClass('selTwitter');
			$('#footer .containor').removeClass('selRss');
			$('#footer .containor').addClass('selLastfm');
			
			$('#footer .icons ul').removeClass();
			$('#footer .icons ul').addClass('lastfmSel');
		});
	
		$('#twitterButton').click(function() { // Mouse Click
		
			
			$('#footer .containor').removeClass('selLastfm');
			$('#footer .containor').removeClass('selRss');
			$('#footer .containor').addClass('selTwitter');
			
			$('#footer .icons ul').removeClass();
			$('#footer .icons ul').addClass('twitterSel');
		});
		
		$('#rssButton').click(function() { // Mouse Click
		
			
			$('#footer .containor').removeClass('selTwitter');
			$('#footer .containor').removeClass('selLastfm');
			$('#footer .containor').addClass('selRss');
			
			$('#footer .icons ul').removeClass();
			$('#footer .icons ul').addClass('rssSel');
		});
	
	});

})(jQuery);
{% endhighlight %}

This rather spaced and lengthly piece of JavaScript was reduced to this: 

{% highlight js %}
(function($){$(document).ready(function(){$('#lastfmButton').click(function(){$('#footer .containor').removeClass('selTwitter');$('#footer .containor').removeClass('selRss');$('#footer .containor').addClass('selLastfm');$('#footer .icons ul').removeClass();$('#footer .icons ul').addClass('lastfmSel');});$('#twitterButton').click(function(){$('#footer .containor').removeClass('selLastfm');$('#footer .containor').removeClass('selRss');$('#footer .containor').addClass('selTwitter');$('#footer .icons ul').removeClass();$('#footer .icons ul').addClass('twitterSel');});$('#rssButton').click(function(){$('#footer .containor').removeClass('selTwitter');$('#footer .containor').removeClass('selLastfm');$('#footer .containor').addClass('selRss');$('#footer .icons ul').removeClass();$('#footer .icons ul').addClass('rssSel');});});})(jQuery);
{% endhighlight %}

So, whats the difference?  Well as you can see all of the JavaScript is now on one line.  This removes characters which in turn makes the document smaller.  You may also notice that all unnecessary spaces have been removed this further reduces the file size of the document.  

Just like when we compressed your CSS you now need to copy-and-paste the output of the JavaScript compressor into your new <tt>.min.js</tt> file.  Once you have done this you will also need to update your <tt>script</tt> tags in your websites <tt>head</tt>.

### Images

Really, we should compress our images properly in the first place, in our graphics application, not not everyone knows how to do this properly, besides, why spend ages doing something in Photoshop that we can do in a few minutes online?

This is where a service by Yahoo! comes in helpful.  I think this tool is best described by the team behind it.  

<blockquote cite="http://www.smushit.com/ysmush.it/">
  <p>Smush.it uses optimization techniques specific to image format to remove unnecessary bytes from image files. It is a "lossless" tool, which means it optimizes the images without changing their look or visual quality. After Smush.it runs on a web page it reports how many bytes would be saved by optimizing the page's images and provides a downloadable zip file with the minimized image files. </p>
  <cite>~ smushit.com</cite>
</blockquote>

Basically, Smush it takes your images and uses lossless compression to make the file size smaller without sacrificing on quality.  

<img src="http://danielgroves.net/wp-content/uploads/2010/08/Screen-shot-2010-08-12-at-10.54.11-550x296.png" alt="Yahoo Smush.it!" title="Yahoo Smush.it!" width="550" height="296" class="size-large wp-image-290" />

Smush it works, as well, which is not something I expected to be able to say, and the saving on the size of images is truly amazing.  Take a look at this image.  It is 53KB, and was produced and optimised is Macromedia Fireworks CS3.  

<img src="http://danielgroves.net/wp-content/uploads/2010/08/orig_danielgroves.png" alt="" title="orig_danielgroves" width="247" height="47" class="aligncenter size-full wp-image-293" />

Now take a look at this image.  This is the output from Smush It after I uploaded the original, above.  

<img src="http://danielgroves.net/wp-content/uploads/2010/08/new_danielgroves.png" alt="" title="new_danielgroves" width="247" height="47" class="aligncenter size-full wp-image-292" />

Now take a look at these two images.  You can barely tell the difference, can you.  In fact, if they weren't side-by-side I doubt you would have noticed the difference at all.  Look at this site ((As of time of writing.  You never know, I may redesign by the time your reading this.)).  All of these images were optimised with the service, did you notice?  No.  

So, how do we use this amazing service?  Easy as pie.  

1) Navigate to [Yahoo! Smush It](http://www.smushit.com/ysmush.it/)
1) Select Uploader
1) Select "Select File and Smush"
1) Highlight all of your images and hot "Open" (or "Select" or whatever it says on your Operating System)
1) Let it work it's magic and download the results.
1) Now simply back-up your original images and over-write them with your new one

Told you it's easy.  

### Conclusion

So, that it.  Three easy ways to make your site faster using free online services.  It took me about 10 minutes to do all of the files on my website, so it really doesn't take long.  What are you top-tips for making websites faster?
