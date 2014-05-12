---
layout: blog
published: true
title: "Design Process: Stitching Levels Together"
date: 2012-03-28 00:11:51.000000000 +01:00
excerpt: How the levels were all integrated, allowing the user to advance in the game and for the score to carry-over between levels. 
---
This blog post was designed as a follow up to the [Level Creation](http://danielgroves.net/2012/03/level-creation/ "Level Creation") post.

Just having the levels designed and built is not enough. In order for each level to function as intended they need to record the users deaths, and the amount of time it has taken them to play.

### Death Management

The first thing that I added to each level was a behaviour that reset the level and added a death to a global variable if the user was to die.

[<img class="size-full wp-image-859" title="Death Behaviour" src="http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-27-at-23.52.30.png" alt="Death Behaviour" width="337" height="151" />](http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-27-at-23.52.30.png)

The screenshot shows the Death behaviour that I created and attached to each level. Essentially if the users Actor makes contact with any other Actor they have made contact with an 'enemy'.

When the user dies they script automatically takes the number of existing deaths and adds one to the number resulting in an increase of one death being recorded on the 'TimesFried' global variable.

Once this has been done the scene crossfades and reloads the scene.

### Proceeding to the next Level

In the game the user has to reach the right-hand side of the screen in order to proceed to the next level. During map creation I placed an invisible region down the entire right side of the screen so that on contact the user would be transported to the next level.

[<img class="size-full wp-image-861" title="Scene Switching" src="http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-27-at-23.57.27.png" alt="Scene Switching" width="382" height="126" />](http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-27-at-23.57.27.png)

This behaviour detects when the users Actor enters a specified region. On entry the behaviour will automatically crossfade the scene from the existing onto the scene that is specified to load next.

### Time Keeping

In order to record the time that the user took to complete each level another behaviour was required.

[<img class="size-full wp-image-864" title="Time Keeping Behaviour" src="http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-28-at-00.02.25.png" alt="Time Keeping Behaviour" width="215" height="124" />](http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-28-at-00.02.25.png)

This behaviour is always running, so as soon as it finishes running it runs again. Essentially it waits one second and then adds one second to the global variable 'Timer'. This allow the same timer to be shared by all levels in order to calculate how long it has taken the user to complete the game.

### Reset

It is important to wipe any old user data before letting them start a new game. In order to ensure that they do not keep any old deaths or add onto the old timers the system stats are all reset at the start of the first level.

[<img class="size-full wp-image-866" title="Reset Behaviour" src="http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-28-at-00.05.34.png" alt="Reset Behaviour" width="162" height="117" />](http://danielgroves.net/wp-content/uploads/2012/03/Screen-Shot-2012-03-28-at-00.05.34.png)

This behaviour simply takes each of the three global variables and resets them back to '0' ensuring a fair and consistent user experience.

### Conclusion

All of these simple behaviours are essential to ensuring that the game runs properly and can perform the necessary functions. Although they are all relatively simple without them the game simply could not operate.
