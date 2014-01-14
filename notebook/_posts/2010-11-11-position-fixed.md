---
layout: blog
published: true
title: "position: fixed;"
date: 2010-11-11 18:57:33.000000000 +00:00
---
```position: fixed``` is one of the CSS attributes that is rarely used, it is one of those properties that few designers truly realise the power of.  For my IDAT102 website I have come up for a use for this particular property that was inspired by the store on the Apple website.  

[<img src="http://daniel-groves.co.uk/wordpress/wp-content/uploads/2010/11/Screen-shot-2010-11-10-at-23.38.14-550x355.png" alt="Apple Store Website" title="Apple Store Website" width="550" height="355" class="aligncenter size-large wp-image-325" />](http://store.apple.com/uk/configure/MC504B/A?mco=MTk0MjIzODk "Apple Store")

As highlighted in the screenshot above on the Apple store website page for configuring Mac products there is a summery box present on the right-hand side.  This box follows the user up and down that page as they scroll in order to allows the customer to easily see what the spec the chosen product is and the additional costs that they have added by increasing the spec of the computer.  

When using this I began to think, why don't more websites use this type of system.  Why not apply this same technique to the navigation on my website so that the user can easily move around the site without have to do pointless scrolling to return to the top of the page.  

### Applying ```position: fixed```

Generally when you position elements using CSS on the web you position them relatively to other elements on the page.  For example you could use ```position: absolute``` which allows you to position elements on a webpage in relation to the elements container.  This means that I could centre a ```div``` on a web page and then position my navigation and content in relation to the corners of this div.  

When using ```position: fixed``` you are no longer working in relation to the parent of the element, but relatively to the browser viewport itself.  What this means is I can make something such as a ```div```, or in the case of my project the website navigation, stay with the user as they move around the page.  

### Code Explanation

When looking at my [project website](http://danielgroves.net) you can see that the sidebar follows the user up and down the page that they are browsing.  

[<img src="http://daniel-groves.co.uk/wordpress/wp-content/uploads/2010/11/Screen-shot-2010-11-11-at-00.03.28-550x355.png" alt="danielgroves.net" title="danielgroves.net" width="550" height="355" class="size-large wp-image-326" />](http://danielgroves.net)

Below is the HTML taken directly from my project site that creates this sidebar.  

{% highlight html %}
<div id="sidebar">

    <div id="header">
    
        <h1>Daniel Groves</h1>
    
    </div><!-- #header -->

    <div id="navigation">
        <ul>
            <li class="selected"><a href="index.html" title="Home">Home</a></li>
            <li><a href="gallery.html" title="Photo Gallery">Gallery</a></li>
            <li><a href="contact.html" title="Contact Me">Contact</a></li>
        </ul>
        <h2>Other Sites</h2>
        <ul>
            <li><a href="http://daniel-groves.co.uk" title="Portfolio Website">Portfolio</a></li>
            <li><a href="http://appflow.co.uk" title="AppFlow">AppFlow</a></li>
        </ul>
    </div><!-- #navigation -->           
</div><!-- #sidebar -->
{% endhighlight %}

This on it's own obviously won't create a sidebar on it's own, we need a bit of CSS to go alongside it.  

The first thing I had to do with the sidebar was to position it within the wrap ```div``` so that it sits in the correct position. In order to do this I had to set the width, taking into account the size of the background image I had to apply, and position it on the left hand side.  The width I choose was 186px and the I decided to control my layout using float so i have floated the sidebar ```div``` onto the left side of the page.  

{% highlight css %}
#sidebar {	
	width: 186px;
	float: left;
}
{% endhighlight %}

Now the sidebar is positioned I can start to worry about how I am going to make the header and navigation follow the users up and down the page.  In order to do this I applied ```position: fixed``` and didn't specify a ```top``` value so that it stays at the top of the browser window as it scrolls down.  

{% highlight css %}
#header {
	width: 183px;	
	position: fixed;
}
{% endhighlight %}

The next thing I did was to use a CSS text-replacement method in order to place my logo graphic in the place of the heading one text.  In order to do this I applied a ```text-indent``` of -99999px in order to remove the text from the screen and overlaid it with the background image.  

{% highlight css %}
#header h1 {
	text-align: center;
	padding: 20px 0;
	text-indent: -99999px;
	background: url('../imgs/logo.png') center center no-repeat;
}
{% endhighlight %}

The next thing I had to do was to position the navigation section below the header, also using ```position: fixed``` so that is would scroll with the header.  In order to place it so that it is alway below the header I gave ```top``` a value of 70px.  

{% highlight css %}
#navigation {
	top: 70px;
	position: fixed;
	list-style: none;
}
{% endhighlight %}

The next thing that I had to do was format the navigation links.  I removed all of the margin from the top right and bottom of al the bullet points that form the structure for the navigation links.  This removed all unnecessary spacing from around them, before I applied a margin on the right-hand side in order move the bullet point into the area covered by the main area of the background image for the selected page or any being hovered over.  From here I then applied 5px of padding all the way around each bullet point in order to create some space around them, but removed it on the right-hand side so the links have more space if need be.  The final change I then made was to up the font-size to 15px.  

In order to make it as easy as possible I have set the font-size to 62.5% in the body.  As a result of the this 0.1em = 1px.  This allows me to have accessible, scalable text while still being able to be precise about the size.  In order set my text to 15px I had to set it to 1.5em.  

{% highlight css %}
#navigation li {
	margin: 0 0 0 10px;
	padding: 5px 0 5px 5px;
	font-size: 1.5em;
}
{% endhighlight %}

The next item in the sidebar is the "Other Sites" title part way down that creates a division between the main navigation area that the links to other websites that I have built.  I used standard CSS in order to format this so it sites subtly in the sidebar while still being noticeable enough that people will see the divider between the links. 

I have used methods that have been discussed above in order to do this, but with a few new CSS attributes.  Firstly I have applied ```text-transform: uppercase``` to this line.  This simply forces the text to be uppercase.  I also used ```letter-spacing: 1px``` to add an extra pixel of space between each letter.  

{% highlight css %}
#navigation h2 {
	color: #999;
	text-transform: uppercase;
	font-size: 1.1em;
	letter-spacing: 1px;
	padding: 20px 0 1px 15px ;
}
{% endhighlight %}

One of the important things to me when designing my navigation was to remove the browser-standerd bullet-points as these don't fit with my design and are not required.  In order to do this I had to set the ```list-style``` to none so that they are removed.  

{% highlight css %}
#navigation ul {	list-style: none;	}
{% endhighlight %}

The next thing I did was to format the navigation links so that they do not use the browser default and fit with the design of the website.  In order to do this I changed the colour to white, applied ```text-decoration: none``` which removes the underlining, applied some padding and removed any default borders.  

{% highlight css %}
#navigation a, #navigation a:active {
	color: #fff;
	text-decoration: none;
	padding: 5px 10px;
	border: none;
}
{% endhighlight %}

I then set up hover-states for the links.  To do this I removed the underlining that appeared on hover by default due to the settings I am using on the rest of the site for links and I applied a background image to appear that indicates that you are hovering over the particular link.  

{% highlight css %}
#navigation a:hover {
	border: none;
	background: url('../imgs/navBullet.gif') center left no-repeat;
}
{% endhighlight %}

Finally in order to allow people to see what page they are on easily I have set the same background image to appear when the bullet-point has a class of selected, which moves from link to link depending on which page the user is on.  

{% highlight css %}
#navigation li.selected a {
	background: url('../imgs/navBullet.gif') center left no-repeat;
}
{% endhighlight %}

What all of this code together results in is the simple and elegant sidebar that I am using on [my project site](http://danielgroves.net).  I found this sidebar surprisingly easy to develop, despite the initial reaction that you would have in thinking it would have to be done using JavaScript.  

CSS is one of those language that you can do amazing things with, but you just have to know which properties to use, when.  