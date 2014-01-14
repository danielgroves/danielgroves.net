---
layout: blog
published: true
title: "Flash Game: Main Menu"
excerpt: A breakdown of the ActionScript that was used for the games menu.

date: 2011-02-04 16:12:17.000000000 +00:00
---
The main menu is one of the more important parts of a game.  It gives you a method through which you can navigate the game and provide the user with instructions. 

Below I have worked through the AS3 from the first frame, explaining it line by line

{% highlight actionscript %}
stop();
{% endhighlight %}

This first line simply stop the animation from moving on to frame two, meaning the the menu stays on screen and the following ActonScript can be run at the appropriate moments.  

{% highlight actionscript %}
import flash.events.MouseEvent;
{% endhighlight %}

This second line of action script now imports the <tt>MouseEvent</tt> class files so that I can call the events in order to detect what the suer is doing with his or her mouse.  

{% highlight actionscript %}
playGame.addEventListener(MouseEvent.CLICK, playGameLink);
playGame.addEventListener(MouseEvent.MOUSE_OVER, playGameOver);
playGame.addEventListener(MouseEvent.MOUSE_OUT, playGameOut);
highScores.addEventListener(MouseEvent.CLICK, highScoresLink);
{% endhighlight %}

This block of code simply add event listeners which listen to each of the buttons and activates their corresponding function.  This provides click listeners in order to change onto the right frame for other parts of the game and mouse over/out listeners for sound.

{% highlight actionscript %}
var carStart:Sound = new Sound(); 
carStart.load(new URLRequest("carStart.mp3"));
var carStartChannel:SoundChannel = new SoundChannel();

function playGameOver(event:MouseEvent):void
{
	carStartChannel = carStart.play();
}

function playGameOut(event:MouseEvent):void
{
	carStartChannel.stop();
}
{% endhighlight %}

This block of code actives the sound.  When the user hovers the mouse of the "play" button it will activate a sound effect to make them aware that they are about to enter the game.  When the mouse is no longer over this button the sound is stopped.  

{% highlight actionscript %}
function playGameLink(event:MouseEvent):void 
{
	gotoAndStop(2); // go to frame 2 where the game is
}

function highScoresLink(event:MouseEvent):void
{
	gotoAndStop(4);  // go to frame 4 where the high scores are shown
}
{% endhighlight %}

These final two lines of make the buttons change the frame.  One taking the user to the game itself, and the other to the High Scores.  
