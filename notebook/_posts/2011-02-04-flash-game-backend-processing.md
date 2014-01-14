---
layout: blog
published: true
title: "Flash Game: Backend Processing"
excerpt: How the PHP script worked in able to allow the flash game to communicate with an external high-scores database. 

date: 2011-02-04 21:49:34.000000000 +00:00
---
In order to set-up a high-score system I need a database and some backend processing scripts, written in PHP.  

The first thing I did was to set-up a database with the appropriate fields: ID, Name and Score.

<img src="http://daniel-groves.co.uk/wordpress/wp-content/uploads/2011/02/Screen-shot-2011-02-04-at-20.36.00-550x403.png" alt="Database in phpMyAdmin" title="Database in phpMyAdmin" width="550" height="403" class="size-large wp-image-362" />

I then used the following PHP script in order to write scores to the database (database information has been removed for security purposes.  

{% highlight php %}
<?php
	////////////////// modify this information ///////////////////////
	$host = "localhost"; //hostname is usually localhost by default
	$user = ""; //insert the name of the user here
	$pass = "";  //insert the password here
	$database = "";  //insert name of database wherein table was exported
	$table = "";  //insert the name of the table
	///////////////////////////////////////////////////////////////////////
 
	//stores the URLvariables into variables that php can use
	$one = $_POST['yourname']; 
	$five = $_POST['yourscore'];

	echo($one);
	echo($five);
 
	  // Connects to the database server
	  $dbcnx = @mysql_connect($host, $user, $pass);
	  if (!$dbcnx) {
	    echo( "<p>Unable to connect to the database server at this time.</p>" );
	    exit();
	  }
 
	  // Selects the database
	  if (! @mysql_select_db($database) ) {
	    echo( "<p>Unable to find database</p>");
	    exit();
	  }
 
	//this is the command used to write the record into the MySQL database
	$query="INSERT into {$table} (name, score) VALUES ('{$one}',{$five})";   
 
	//executes the command
	mysql_query($query) or die("Data not written.");
	echo("The data has been written to the table!");
{% endhighlight %}

This script simply takes the score and username, which are passed to it via the <tt>POST</tt> method and writes them to the database.  

This second script then reads the top five results, orders them, and renders them ready to be read by action script.  For unknown reasons this PHP will not embed properly in this page, and has therefore been [provided to view in a text document](http://daniel-groves.co.uk/wordpress/wp-content/uploads/2011/02/circuitRacerHighScores.txt).  
