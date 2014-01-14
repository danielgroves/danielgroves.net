---
layout: blog
published: true
title: "Design Process: Menu Screens"
date: 2012-03-28 00:48:03.000000000 +01:00

excerpt: How the menu screens were developed for the game.
---
This blog post is designed as a follow up to '[Stitching Levels Together](http://danielgroves.net/2012/03/stitching-levels-together/ "Stitching Levels Together")'.

Menu screens are vital to just about any game. They hold the game together, present information and guide the user through the game. The game I have created requires three menu screens; Main Menu, Instructions, and Score.

### Main Menu

For the game I have kept the Main Menu very simple, providing just two options to the user.

[<img class="size-full wp-image-874" title="Main Menu" src="http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-28-at-00.13.20.png" alt="Main Menu" width="641" height="479" />](http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-28-at-00.13.20.png)

The Main Menu simply allows the user to start playing the game or to proceed to the instructions screen in order to find out how to play.

### Instructions Screen

The instructions screen contains details on how to play the game and what to look out for.

[<img class="size-full wp-image-872" title="Instructions Screen" src="http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-28-at-00.14.09.png" alt="Instructions Screen" width="643" height="481" />](http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-28-at-00.14.09.png)

The paragraphs of text explaining the game are helped by the visual cues provided below so the user will recognise the enemies.

### Score Screen

The final screen in the game is the score screen.

[<img class="size-full wp-image-873" title="Score Screen" src="http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-28-at-00.13.39.png" alt="Score Screen" width="642" height="480" />](http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-28-at-00.13.39.png)

Although viewing the 'scene' in stencil works this screen will calculate the users score by the user of a behaviour. This is looked at in more detail later on but it essentially calculates the deaths plus one and then divides the users time by the amount of deaths.

### Associated Behaviours

This functionality does not come by simply placing the right elements on a new scene. In order to power this functionality some behaviours were required.

#### Change Scene Via a Button

In order to change the scene via a button press a custom behaviour was required.

[<img class="size-full wp-image-877" title="Changing Scene with a Button" src="http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-28-at-00.30.37.png" alt="Changing Scene with a Button" width="387" height="195" />](http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-28-at-00.30.37.png)

In order to change scene when a button was pressed I turned each of the buttons into an 'actor'. Once these buttons were created as an actor it was a simple case of adding a click event to each of them in order to load the corresponding scene.

#### Score calculation and drawing

The score calculation one of the more advanced parts of the custom behaviour coding.

[<img class="size-large wp-image-878" title="Score Calculation and Drawing" src="http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-28-at-00.30.25-710x128.png" alt="Score Calculation and Drawing" width="710" height="128" />](http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-28-at-00.30.25.png)

This behaviour calculates the users score on the scenes creation, using the following algorithm.

{% highlight actionscript %}
Timer / (TimesFried + 1)
{% endhighlight %}

Once this has been done the behaviour draws the users score while the rest of the scene is being drawn. This involves generating the text in the correct font, rounding the score to the nearest whole integer and then displaying it at the correct co-ordinates.

### Conclusion

This document shows the depth of thought that has gone in tot he generation of the games menus and scoring system. It demonstrates that all of the recorded information throughout the game has been recorded for a reason and shows some of the techniques that have been applied behind the game.
