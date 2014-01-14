---
layout: blog
published: true
title: "Flash Game: High Scores Page"
excerpt: How the high-scores were laoded by combining ActionScript with a server-side PHP script.

date: 2011-02-04 21:07:44.000000000 +00:00
---
This post looks at exactly how I extracted the high-scores form the database via PHP script.  

{% highlight actionscript %}
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.events.Event;
{% endhighlight %}

This first section loads the nessesery class files.  

{% highlight actionscript %}
stop();
{% endhighlight %}

Followed by the <tt>stop</tt> function to stop the flash file moving back to frame one.  

{% highlight actionscript %}
backToMenu.addEventListener(MouseEvent.CLICK, menuLoad);
{% endhighlight %}

This line listens for a click event on the back to main menu button and then activates thr function <tt>menuLoad</tt> which takes the user back to the nenu on frame one.  

{% highlight actionscript %}
function textLoadComplete(event:Event):void
{
        txtBox.htmlText = textLoader.data;
		trace(textLoader.data);
}
{% endhighlight %}

This function is called by the event listener (below) in order to display the high-scores which are loaded from a server-side PHP script.  

{% highlight actionscript %}
var textLoader:URLLoader = new URLLoader();
var textReq:URLRequest = new URLRequest("http://files.danielgroves.net/circuitRacerScores.php");

textLoader.load(textReq);
textLoader.addEventListener(Event.COMPLETE, textLoadComplete);
{% endhighlight %}

This is the section of action script that fetches the PHP files that fetches the high scores, and then returns the results to the document.  

{% highlight actionscript %}
function menuLoad(event:Event):void
{
	
	gotoAndStop(1);
	
}
{% endhighlight %}

The final function that takes the user back to the main menu when activated.  
