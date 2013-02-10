---
layout: blog
published: true
title: The Importance of Well Written Code
date: 2012-07-05 09:00:49.000000000 +01:00
excerpt: Badly documented code in now commonplace all over the web, I take a look into a few simple steps to help make code more maintainable and easier for others to understand. 
---
The topic for this post is somewhat generic, but important nonetheless. It's amazing how many developers just write code, without putting any thought into just what they're doing. They don't think about how future-proof it is, or consider others when writing code.

It doesn't matter if your working on an open source project or an internal company project, these points still apply. It's good practice, it makes your life easier, and it'll make your co-workers lives easier.

Well-written code really isn't  *that* hard to write. It requires structure and comments. If code is written in a modular fashion it is particularly easy to add to and modify at a later date. Combine this well-written code with comments that actually explain to other programmers what each function does and suddenly collaboration becomes much easier.

Let's take the following snippet of PHP for an example. 

{% highlight php %}
<?php 
	$name = $_GET['name'];
	$sentance = 'Welcome, ' . $name;
	echo $sentance;
{% endhighlight %}

Ok, so thats a pretty simple example, but we improve on this code in a few simple steps that'll make it much easier to maintain at a later date.  Lets place this into a function which could, at a later date, contribute to a library or make it much easier to modify the welcome message on multiple pages at a later date.  

{% highlight php %}
<?php 
	function welcome($name)
	{
	    $sentance = 'Welcome, ' . $name;
	    return $sentance;
	}

	echo welcome( $_GET['name'] );
{% endhighlight %}

Pretty simple, eh? By breaking your code down into smaller units like this it makes it clearer what is going on and easier to understand.  In a large application it also makes it a lot easier to find portions of code, read code and to maintain code.  Now lets take this a step further. 

{% highlight php %}
<?php 
	/**
	 * Returns standard welcome message for the user
	 * @param $name The users name
	 * @return The welcome message to the user, in the format of 'Welcome, $name'
	 */
	function welcome($name)
	{
	    $sentance = 'Welcome, ' . $name;
	    return $sentance;
	}

	echo welcome( $_GET['name'] );
{% endhighlight %}

I hope you can see at this stage how much easier this code is for someone new to a project to read now, and find out exactly whats going on.  Don't think these rules shouldn't apply to your work just because your currently the only person who works on your project.  New team members can arrive at any time, and these comments help greatly when revisiting old code. Even if you wrote it. 

The comment above was added in the style of JavaDoc. JavaDoc can be used to generate documentation for your application simply by running a parser such as [phpDoc](http://www.phpdoc.org/ "PHP Doc, A program for generating PHP documentation") on your code, generating API documentation thats easily accessible for your whole team. 

Now, lets bulk out the code one final time to see how comments can help inside a function as well in order to demonstrate how useful they are on slightly more complex algorithms.  

{% highlight php %}
<?php 
	/**
	 * Detects if the user has provided a name or not a supplies the relevant 
	 * Welcome message.  
	 * @param $name The users name
	 * @return The welcome message to the user, in the format of 'Welcome, $name'
	 * if a name was provided.  Otherwise in the format of 'Welcome, it's nice to 
	 * see you'
	 */
	function welcome($name)
	{
	    if ( $name != '' ) {
	        // If the user has provided a name
	        $sentance = 'Welcome, ' . $name;
	    } else {
	        // If the user hasn't provided with a name
	        $sentance = 'Welcome, it\'s nice to see you';
	    }

	    return $sentance;
	}

	echo welcome( $_GET['name'] );
{% endhighlight %}

In this final example you can see how, even in this simple example, commenting your code and breaking it down logically can help to make your code readable and easily maintainable to anyone, even those who have never seen it before.  

The rules don't take much longer to follow, and I hope you can now see just how easy it is to make your code accessible to everyone, even those who are relatively new to programming.  
