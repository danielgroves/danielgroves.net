---
layout: blog
published: true
title: "Flash Game: The Game"
excerpt: An explanation about the ActionScript that powered the Flash Game. 

date: 2011-02-04 20:19:22.000000000 +00:00
---

This blog post explains the ActionScript in frame two.  Frame two was where the game itself existed, along with the ending screen which shows the user the score they achieved as well as giving them the option to submit it to the high scores tables.  

{% highlight actionscript %}
import flash.events.Event;
import flash.utils.Timer;
import flash.events.TimerEvent;

import flash.events.*;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
{% endhighlight %}

This first block of code imports the necessary class files for the actions script on this frame.  

{% highlight actionscript %}
stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
stage.addEventListener(Event.ENTER_FRAME, userCarControler);
stage.addEventListener(Event.ENTER_FRAME, computerCarControler);
stage.addEventListener(Event.ENTER_FRAME, userWins);
submitScore.addEventListener(MouseEvent.CLICK, scoreSubmited); 
mainMenuLink.addEventListener(MouseEvent.CLICK, mainMneu);
{% endhighlight %}

This second block of code listens for the necessary events, such as activating functions on every frame refresh or detecting menu item clicks.  

{% highlight actionscript %}
var raceTimer:Timer=new Timer(1000,0);
raceTimer.addEventListener(TimerEvent.TIMER, stopWatch);
raceTimer.start();
var raceTimerValue:Number = 0;
function stopWatch(event:TimerEvent):void
{
	raceTimerValue++;
	txtTimer.text = raceTimerValue + " Seconds";
}
{% endhighlight %}

This block of code times the race so that the user can be scored based on how quickly they complete the laps.  

{% highlight actionscript %}
var computerCarSpeed:Number = 6;
{% endhighlight %}

This line sets the speed which the computer car can move at.  This variable means I can stop the computer car from being able to move when the user wins the game.

{% highlight actionscript %}
var userCar_up:Boolean = false
var userCar_down:Boolean = false
var userCar_left:Boolean = false
var userCar_right:Boolean = false
{% endhighlight %}

In order to achieve the smooth movement of the users car I create four variables.  Each of these booleans is activated on holding the corresponding arrow key down, and then deactivates on releasing the key.  This menas that the animation is either on or off, rather than turning on and off quickly and so smooth animation is achieved.  

{% highlight actionscript %}
var userCarHits:Number = 0;
var userCompleteLaps:Number = 0;
var userNoCheat:Number = 0;
var finalScore:Number = 0;
{% endhighlight %}

These are variables that need to be accessible by all functions.  These are used for logging the number of times the user has hit the CPU car, to detect is the user is cheating or not by not going all the way around the track, and to store the score that the user achieves.  

{% highlight actionscript %}
userName.visible = false;
nameBackground.visible = false;
nameLabel.visible = false;
yourScore.visible = false;
submitScore.visible = false;
mainMenuLink.visible = false;
gameTitle.visible = false;
mcGameEndBg.visible = false;
{% endhighlight %}

This small block of code is used to hide all of the instances of objects that are required to inform the user that they have finished the game and allow them to submit their high score and navigate away from the high-score page.  

{% highlight actionscript %}
function keyDownHandler(e:KeyboardEvent):void
{
	// Detect if "up" arrow is held down
	if(e.keyCode == 38)
	{
		userCar_up = true;
	}
	
	// Detect if "down" arrow is held down
	if(e.keyCode == 40)
	{
		userCar_down = true;
	}
	
	// Detect if "right" arrow is held down
	if(e.keyCode == 39)
	{
		userCar_right = true;
	}
	
	// Detect if "left" arrow is held down
	if(e.keyCode == 37)
	{
		userCar_left = true;
	}
}
{% endhighlight %}

This section of called via any key being pressed on the keyboard. When the key is held down, it sets the arrow keys corresponding <tt>boolean</tt> to <tt>true</tt>.  

{% highlight actionscript %}
function keyUpHandler (e:KeyboardEvent):void
{
	
	// Detect if "up" arrow has been released
	if(e.keyCode == 38)
	{
		userCar_up = false;
	}
	
	// Detect if "down" arrow has been released
	if(e.keyCode == 40)
	{
		userCar_down = false;
	}
	
	// Detect if "right" arrow has been released
	if(e.keyCode == 39)
	{
		userCar_right = false;
	}
	
	// Detect if "left" arrow has been released
	if(e.keyCode == 37)
	{
		userCar_left = false;
	}
	
}
{% endhighlight %}

This function sets the booleans that contorl which way the car moves gto false once the user releases the corresponding arrow key.  

{% highlight actionscript %}
function userCarControler(event:Event)
{

	if (userCar.hitTestPoint(computerCar.x, computerCar.y))
	{
		userCarHits = userCarHits + 1;
	}
	
    if (grass1.hitTestObject(userCar) || grass2.hitTestObject(userCar))
	{
		userCar.x = 171.2;
		userCar.y = 365.55;
		
		trace("hit grass");
		
	}
	
	var carSpeed:Number = 7;
	
	if(userCar_up)
	{
		userCar.rotation = 270;
		userCar.y -= carSpeed;
	}
	
	if(userCar_down)
	{
		userCar.rotation = 90;
		userCar.y += carSpeed;
	}
	
	if(userCar_right)
	{
		userCar.rotation = 0;
		userCar.x += carSpeed;
	}
	
	if(userCar_left)
	{
		userCar.rotation = 180;
		userCar.x -= carSpeed;
	}
	
	if (mcMk5.hitTestObject(userCar))
	{
		userNoCheat++;
	}
	
	if (userNoCheat > 0 && userCar.hitTestObject(mcStartLine))
	{
		
		userCompleteLaps++;
		userNoCheat = 0;
		
	}
	
	txtLap.text = String(userCompleteLaps) + "/5 Laps";
}
{% endhighlight %}

This function is run on entering the frame.  As a result it continually can adapter what the users car can do and when.  

The first <tt>if</tt> statement is used to detect if the suers car has hit the computers car.  When it hits the computers car it adds one on the varible <tt>userCarHits</tt> so that the ActionScript can keep a record of how many times the user car has hit the comuters car.  This si used for the scoring later on.  

The next if statement is used to detect if the user is cheating by trying to drive accross the grass. If the user does try to drive across the grass their car is automaticly be reset back to the start line as a punishment for attempting to cheat. To do this I used the <tt>userCar.x</tt> and <tt>userCar.y</tt> properties.  

The next varible declared is <tt>carSpeed</tt>. This is used to set the speed at which the user car can move.  

After this there are another four <tt>if</tt> statements.  These <tt>if</tt> statements are used in order to detects which way the users car is meant to be going, based on weather the previously discussed <tt>booleans</tt> are <tt>true</tt> or <tt>false</tt>, and then set the car speed accordingly.  

The second to last <tt>if</tt> statement then records if the users car has reached the checkpoint part way round the circuit, in order to establish if they are completeing the track or just going back and forth over the start line.  

The final <tt>if</tt> statement will then detect if the user has gone all the way around the track, going over the checkpoint, or if the user has simple gone back and forht over the start line.  The lap then gets logged if it was genuine.  

{% highlight actionscript %}
function computerCarControler(event:Event)
{
	
	var direction:String = "";
	
	if (mcMk1.hitTestObject(computerCar))
	{
		direction = "right";
	} 
	else if (mcMk2.hitTestObject(computerCar))
	{
		direction = "up";
	}
	else if (mcMk3.hitTestObject(computerCar))
	{
		direction = "left";
	}
	else if (mcMk4.hitTestObject(computerCar))
	{
		direction = "up";
	}
	else if (mcMk5.hitTestObject(computerCar))
	{
		direction = "left";
	}
	else if (mcMk6.hitTestObject(computerCar))
	{
		direction = "down";
	}
	
	if (direction == "right")
	{
		
		computerCar.x += computerCarSpeed;
		computerCar.y += 0;
		computerCar.rotation = 0;
		
	}
	else if (direction == "up")
	{
		
		computerCar.x += 0;
		computerCar.y -= computerCarSpeed;
		computerCar.rotation = 270;
		
	}
	else if (direction == "left")
	{
		
		computerCar.x -= computerCarSpeed;
		computerCar.y += 0;
		computerCar.rotation = 180;
		
	}
	else if (direction == "down")
	{
		
		computerCar.x += 0;
		computerCar.y += computerCarSpeed;
		computerCar.rotation = 90;
		
	}
	
}
{% endhighlight %}

This function is used in order to contorl the CPU based car.  The direction of the car is determin based on what area of the track the car is on, which is established by running <tt>.hitTestObject</tt> on the computers car and the different areas of the track.  

Once this has been established the varible <tt>direction</tt> is set and then the the following <tt>if</tt> statement set the car in the right direction and rotate it to face in the correct direction.  

{% highlight actionscript %}
function userWins(event:Event):void
{
	
	if (userCompleteLaps == 5)
	{
		raceTimer.stop();
		
		finalScore = raceTimerValue + (userCarHits * 5);
		
		yourScore.text = "You Scored: " + finalScore;
		
		userName.visible = true;
		nameBackground.visible = true;
		nameLabel.visible = true;
		yourScore.visible = true;
		submitScore.visible = true;
		mainMenuLink.visible = true;
		gameTitle.visible = true;
		mcGameEndBg.visible = true;
		
	}
	
}
{% endhighlight %}

Once the user has completed five laps, this function takes over.  It stop the timer and then calculates the final score by taking the timer value and then adding on the amount of times the computer car has been hit and multiplys it by five.  This score is then displayed.  

This is followed by the the selecting of all the instances that make up the post-game screen and setting the property <tt>.visible</tt> to <tt>true</tt> which means that they can show over the top of the other content.  

{% highlight actionscript %}
function scoreSubmited(event:Event):void
{
	var phpVars:URLVariables = new URLVariables();
	var phpFileRequest:URLRequest = new URLRequest("http://files.danielgroves.net/circuitRacerWrite.php");
	phpFileRequest.method = URLRequestMethod.POST
	phpFileRequest.data = phpVars;
	
	var phpLoader:URLLoader = new URLLoader();
	phpLoader.dataFormat = URLLoaderDataFormat.TEXT;
	
	phpVars.yourname = userName.text;
	phpVars.yourscore = finalScore;
	
	phpLoader.load(phpFileRequest);
}
{% endhighlight %}

This function is called when the user clicks the button to submit their score.  It then send the score and the users name to and external PHP script to be processed and added to the MySQL database.  

{% highlight actionscript %}
function mainMneu(event:Event):void
{
	trace("gotoframe1");
	
	userName.visible = false;
	nameBackground.visible = false;
	nameLabel.visible = false;
	yourScore.visible = false;
	submitScore.visible = false;
	mainMenuLink.visible = false;
	gameTitle.visible = false;
	mcGameEndBg.visible = false;
	
	// Reset car locations
	userCar.x = 171.2;
	userCar.y = 364.55;
	computerCar.x = 171.2;
	computerCar.y = 338.55;
	computerCarSpeed = 0;
	
	gotoAndStop(1);
	
}
{% endhighlight %}

This final function is triggered when the user clicks the button to go back to the main menu.  This hides all of the non-game elements again, resets and the coputer and users car locations and stop the computer car from moving.  It then take the user back to frame one where the main menu is.  
