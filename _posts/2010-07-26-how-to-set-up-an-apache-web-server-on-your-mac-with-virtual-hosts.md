---
layout: blog
published: true
title: How to set-up and Apache Web Server on your Mac with Virtual Hosts
date: 2010-07-26 13:49:56.000000000 +01:00
---
As a web designer <em>and</em> a web developer I am always looking for ways to improve the way I work when using a local test environment to make it more realistic as well as easier to use.  Because of this, I decided to take the plunge and configure my MacBook so it runs Apache, PHP and MySQL natively, in the background rather than as a 3rd party app like before.  

Since getting my MacBook I have always run MAMP (Mac, Apache, MySQL and PHP) in order to do all of my local development, but now I have set-up everything up properly from scratch I decided to record here how I did it, in the hope that it might help someone else, but also on the off chance that I have to re-do this again in the future.  

This is a set-up step guide on the full-works.  Installing Apache, PHP and MySQL natively as well as setting up virtual hosts on Mac OS X so you can access an array of sites locally by visiting URL's such as example.local or fried.egg.  These will only work on your computer, but it is still worth doing in order to create a better testing environment.  

### Installing Apache

The first step here is to install Apache to your system.  Well, this bit is easy.  Because it is already sat there on your system, all you need to do is turn it on, which takes about 30 seconds.  Open up System Preferences and then go to "Sharing".  Here select the make sure the panel is unlocked by clicking the padlock in the lower-left corner and typing in your password.  Now tick the box labeled "Web Sharing".  

<img src="http://danielgroves.net/wp-content/uploads/2010/07/Screen-shot-2010-07-26-at-14.40.45-550x461.png" alt="System Preferences Sharing Panel" title="System Preferences Sharing Panel" width="550" height="461" class="size-large wp-image-237" />

OK, so that's it - Apache is up and running.  That was easy, wasn't it?

### Installing PHP

The next stage isn't an install either, getting PHP up and running is simply a case of configuring Apache.  In order to do this you will need a text editor that allows you to save as a super-user.  There are plenty of free text editors available, but I would suggest using <a href="http://www.fraiseapp.com/" target="_blank">Fraise</a> ((Does anyone know what exactly a Fraise is?  Is it just a kinda strawberry?)), more on why I suggest Fraise later.  

Open a Finder window and then go to Go:Go To Folder or press Cmd+Shift+G.  Once you have done this a drop-down box will appear, in which you need to type <tt>/etc/apache2</tt> and hit enter.  

<img src="http://danielgroves.net/wp-content/uploads/2010/07/Screen-shot-2010-07-26-at-09.45.13.png" alt="Finder Go To" title="Finder Go To" width="443" height="141" class="size-full wp-image-194" />

In this folder you should see a file called <tt>httpd.conf</tt>.  Double-click it and OS X will ask you to choose an application to open it in as there is no application assigned to a <tt>.conf</tt> file yet.  Select Fraise, or whatever other editor you would like to use, and open the file.  Now go to line 115 which should read <tt>#LoadModule php5_module        libexec/apache2/libphp5.so</tt>.  If not, do a search for this line (Cmd+F).  

The hash (#) at the start of this line is there to comment out the line, meaning that Apache ignore that line, and moves on.  We don't want Apache to do this as this is the line that initiates PHP, so simply delete the hash at the start of the line and hit save.  At this point Fraise will ask you if you would like to Authenticate, click Authenticate and type in your password so that Fraise can write to the file.  

Fraise asks you to authenticate as the file we were editing is located in among the computers system files which require administrator privileges to edit.  

<img src="http://danielgroves.net/wp-content/uploads/2010/07/Screen-shot-2010-07-26-at-09.54.57-590x486.png" alt="Editing httpd.conf in Fraise" title="Editing httpd.conf in Fraise" width="550" class="size-large wp-image-195" />

### Installing MySQL

Next we need to install MySQL, and this time we really do have to install it.  Go to the <a href="http://dev.mysql.com/downloads/mysql/" target="_blank">MySQL download page</a> and select the appropriate download for you computer - for example I am running Snow Leopard on a 64-bit MacBook, so I downloaded "Mac OS X ver. 10.6 (x86, 64-bit), DMG Archive".  It doesn't really matter which archive type you choose, but I decided on a DMG just because they are easy to work with.  

Installing MySQL really is easy.  Once your chosen archive has downloaded open it and you should find three files inside.  Install each of these in order, the first item is the MySQL software itself.  The second is a preferences pane ((To install these just double click on them.  Easy as pie.  )) that allows you to start and stop MySQL.  Finally the package MySQLStartupItem allows MySQL Server to launch when you turn your computer on.  

<img src="http://danielgroves.net/wp-content/uploads/2010/07/Screen-shot-2010-07-26-at-10.05.14-570x262.png" alt="MySQL Install files" title="MySQL Install files" width="550" class="size-large wp-image-222" />

Once installed go to System Preferences and you should see a new pane called "MySQL".  Open is a click the button "Start MySQL Server".  This will start the MySQL server, but that's not everything.  Most people, at some stage, will want to add more databases so they can use it for multiple things, rather than just using the default "test" database.  We also need to set-up a username and password for MySQL so web applications can use it.  

<img src="http://danielgroves.net/wp-content/uploads/2010/07/Screen-shot-2010-07-26-at-10.10.04-570x331.png" alt="MySQL Preferences Pane" title="MySQL Preferences Pane" width="550" height="319" class="size-large wp-image-223" />

Although it may seem a little daunting to begin with, using a terminal really is not that bad at all, and that is exactly what we need next.  Up another Finder window and go to Applications:Utilities:Terminal.  Now type <tt>ls -a</tt>.  What you just did was show the content of your home directory with hidden files showing, now look through tthat list of files and folder that appeared after you hit enter and look for a file called .profile.  If you can see a file called .profile type <tt>Open /Applications/Fraise.app .profile</tt>, and if you cannot see it open a blank document and save it in your home directory as .profile.  Now type <tt>export PATH=”/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH”</tt> at the end of the document and save it.  What you have just done is make it possible to just type <tt>mysql</tt> or <tt>mysqladmin</tt> in terminal when you need access to MySQL to perform tasks such as adding databases.  

Now, in terminal again we are going to run a quick command in order to set a password on our root account so we can logon to MySQL in the future.  In terminal type <tt>mysqladmin -u root password 'password'</tt>.  You can change the password to read whatever you like.  

### Adjoining PHP and MySQL

In order to make PHP and MySQL work seamlessly together we need to edit the PHP configuration file called <tt>php.ini</tt>.  To do this open a Finder window, press Cmd+Shift+G and then type <tt>/etc/</tt>.  Now look for a file called <tt>php.ini</tt> and open it.  

If you can't find <tt>php.ini</tt> there should be a file called <tt>php.ini.default</tt>  If this is the case go to terminal and type <tt>sudo cp /etc/php.ini.default /etc/php.ini</tt> then hit enter and type your password when prompted.  All this terminal command does is duplicate the file as <tt>php.ini</tt>.  Now open this file in Fraise.  

Around line 962 you should find a line that says <tt>;extension=php_mysql.dll</tt>.  Like with the Apache configuration file a semicolon acts as a comment, making PHP skip over that line.  Deleted the semi-colon and then look for <tt>;extension=php_pdo_mysql.dll</tt> around line 969 and delete the semi-colon again.  

Now, scroll down and look for a line that starts like this <tt>mysql.default_port = </tt> arounf line 1211 and make sure it reads in full <tt>mysql.default_port = 3306</tt> then look for <tt>mysql.default_socket = </tt> a few line sbelow and make sure their is nothing after the equals sign.  This forces PHP to loads the MySQL default.  Save the changes to this file and you are done configuring MySQL and PHP.  

<img src="http://danielgroves.net/wp-content/uploads/2010/07/Screen-shot-2010-07-26-at-14.12.18-550x453.png" alt="Editing php.ini in Fraise" title="Editing php.ini in Fraise" width="550" height="453" class="size-large wp-image-225" />

Now we have to complete one final step, and this one is really easy.  We need to restart Apache and MySQL for our changes to take effect.  So go to the "MySQL" pane in System Preferences and hit the stop button.  Then go to the "Sharing" pane, unlock it again if you closed system preferences and un-tick "Web Sharing" again.  Once Web Sharing has finished turning off turn it back on by re-ticking the box and then go back to the "MySQL" pane and start MySQL again.  

Thats it, you have set-up, from scratch a fully functioning Apache web server for local testing.  That wasn't that bad, was it?  Read on to find out how to set-up VirtualHosts so you can have a different local domain for each site (these are really quick and easy to set-up!).  

### Setting up Virtual Hosts for Apache

For those who don't know a Virtual Host is a seperate <strong>local</strong> domain name that can be used for development.  It is useful to have multiple domains for multiple websites that you work on.  Setting up Virtual Hosts really is quite simple, you make two simple alterations to two files and thats it.  Job done.  

Before we begin it is important that you have decided two things, firstly where you want to store your virtual host and secondly what you would like it to be called.  For example I have one called portfolio.local which I store in <tt>/Users/danielgroves/Sites/portfolio/</tt>.  This is the site I will use for this example.  

Firstly you need to open your hosts file.  Open a Finder window, press Cmd+Shift+G and the type in <tt>/etc/</tt> then find and open in Fraise a file called <tt>hosts</tt>.  Now scroll down to the bottom and add the following: 

{% highlight apacheconf %}
# Custom edits for virtual hosts #
127.0.0.1	portfolio.local
# Custom edits for virtual hosts #
{% endhighlight %}

You can freely change <tt>portfolio.local</tt> to whatever you like, but I would advise not using extensions such as .com or .co.uk as these are commonly found online and so you may find yourself unable to access various websites.  

<img src="http://danielgroves.net/wp-content/uploads/2010/07/Screen-shot-2010-07-26-at-14.18.20-550x354.png" alt="Editing the &quot;hosts&quot; file in Fraise" title="Editing the &quot;hosts&quot; file in Fraise" width="550" height="354" class="size-large wp-image-227" />

Next press Cmd+Shift+G in finder again and go to <tt>/etc/apache2/</tt> and open httpd.conf in Fraise.  Scroll down to line 464 and look for a line nearby that reads <tt># Virtual hosts</tt> then remove the hash from the line below so that it reads <tt>Include /private/etc/apache2/extra/httpd-vhosts.conf</tt>.  Now save this file and close it.  

<img src="http://danielgroves.net/wp-content/uploads/2010/07/Screen-shot-2010-07-26-at-14.21.25-550x465.png" alt="Editing &quot;httpd.conf&quot; in Fraise" title="Editing &quot;httpd.conf&quot; in Fraise" width="550" height="465" class="size-large wp-image-228" />

In finder now press Cmd+Shift+G for the last time and type in <tt>/etc/apache2/extra/</tt> and then open <tt>httpd-vhosts.conf</tt> in Fraise.  By default lines 27 to 42 will say:-

{% highlight apacheconf %}
<VirtualHost *:80>
    ServerAdmin webmaster@dummy-host.example.com
    DocumentRoot "/usr/docs/dummy-host.example.com"
    ServerName dummy-host.example.com
    ServerAlias www.dummy-host.example.com
    ErrorLog "/private/var/log/apache2/dummy-host.example.com-error_log"
    CustomLog "/private/var/log/apache2/dummy-host.example.com-access_log" common
</VirtualHost>

<VirtualHost *:80>
    ServerAdmin webmaster@dummy-host2.example.com
    DocumentRoot "/usr/docs/dummy-host2.example.com"
    ServerName dummy-host2.example.com
    ErrorLog "/private/var/log/apache2/dummy-host2.example.com-error_log"
    CustomLog "/private/var/log/apache2/dummy-host2.example.com-access_log" common
</VirtualHost>
{% endhighlight %}

You can safely delete these lines, but leave the rest.  Personally I decided to comment them all out by placing a hash (#) at the start of each line incase I needed them for future reference.  Next add the following to to document.  

{% highlight apacheconf %}
<VirtualHost *:80>
	DocumentRoot "/Library/WebServer/Documents"
	ServerName	localhost
</VirtualHost>
{% endhighlight %}

You can change the <tt>DocumentRoot</tt> if you like so it points anywhere on your system.  What this does is load the files located in <tt>/Library/WebServer/Documents</tt> when you type localhost into your browser.  Next we need to configure our custom Virtual host.  To do this duplicate the lins above and change them to your needs. For example this is what I added to the end of <tt>httpd-vhosts.conf</tt> for my vhost <tt>portfolio.local</tt> stored in <tt>/Users/danielgroves/Sites/portfolio/</tt>

{% highlight apacheconf %}
<VirtualHost *:80>
	DocumentRoot "/Users/danielgroves/Sites/portfolio"
	ServerName	portfolio.local
</VirtualHost>
{% endhighlight %}

<img src="http://danielgroves.net/wp-content/uploads/2010/07/Screen-shot-2010-07-26-at-14.22.48-550x453.png" alt="Editing &quot;httpd-vhosts.conf&quot; in Fraise" title="Editing &quot;httpd-vhosts.conf&quot; in Fraise" width="550" height="453" class="size-large wp-image-229" />

Now you need to restart Apache one last time.  So go to the "MySQL" pane in System Preferences and hit the stop button.  Then go to the "Sharing" pane, unlock it again if you closed system preferences and un-tick "Web Sharing" again.  Once Web Sharing has finished turning off turn it back on by re-ticking the box and then go back to the "MySQL" pane and start MySQL again.  

Thats it, you have set-up your first Virtual Host in Apache on your Mac.  Go on, stick some files in your Document root (mine was <tt>/Users/danielgroves/Sites/portfolio/</tt>) and type the address of your Virtual Host into your browser.  Good isn't it?  

<img src="http://danielgroves.net/wp-content/uploads/2010/07/Screen-shot-2010-07-26-at-14.26.30-550x361.png" alt="portfolio.local" title="portfolio.local" width="550" height="361" class="size-large wp-image-230" />

### The reasoning behind using Fraise

If you remember, back at the start of this article I said I would explain alter on why I suggested that you use Fraise.  The reason is that Fraise has something called "Projects" built in, this means you can save a project on your computer and when you double click it all of your project files will open in Fraise.  

Whenever you want to add or delete a VirtualHost you can to edit two files, <tt>/etc/hosts</tt> and <tt>/etc/apache2/extra/httpd-vhost.conf</tt>.  These two files are hidden away deep with your system and so it is much easier to store a project file somewhere on your system (I keep mine in my Sites folder) which makes it quick to open these two file for editing.  That is why I suggested using Fraise earlier on in the tutorial.  For those who are interested in how to create a project in Fraise follow these instructions:

1) Close all files in Fraise
1) Open the files you want to turn into a project in Fraise (<tt>/etc/hosts</tt> and <tt>/etc/apache2/extra/httpd-vhost.conf</tt>)
1) Select File:Save Documents As Project

### Conclusion

That's it.  Your now finished with this tutorial, but please don't just close the window.  I want to hear what you think, so I am asking you as nicely as possible to leave me a comment below.  What did you think of this tutorial?  What did you like and not like?  How has this benefitted you?  And if you have any problems, leave me a comment and I will see what I can do to help you.  
