---
layout: blog
published: true
title: AFP Goodness between OS X Lion and Ubuntu 11.10
excerpt: The process behind making Ubuntu share files with Mac OS Lion using the AFP protocol. 

date: 2012-01-19 23:33:11.000000000 +00:00
---
I've been working on assembling a private media and backup server for use with my Mac.  In order to do this I needed to have AFP working between OS X and Ubuntu, as this is the protocol required by Time Machine for network backup servers. 

In order to set everything up I was [following a guide](http://www.kremalicious.com/2008/06/ubuntu-as-mac-file-server-and-time-machine-volume/ "Make Ubuntu A Perfect Mac File Server And Time Machine Volume") by [Matthias Kretschmann](http://www.kremalicious.com/ "Matthias Kretschmann").  This guide seemed like the complete package, accept Apple have changed a few things in the AFP package in OS X for Lion.  The result of these changes is that everything breaks for Lion, but after a little doffing around the net I appear to have a working fix.  

This first error I encountered was "The version of the server you are trying to connect to is not supported".  I quick bit of digging around revealed that the login protocol has been changed, but there is a quick fix for this.  The login protocol used before was DHX, and the new is DHX2.  So, in order to fix this we simply need to edit the afpd.conf file, to do this run the following command in your Ubuntu Terminal.  

{% highlight bash %}
sudo nano /etc/netatalk/afpd.conf
{% endhighlight %}

In order to fix the issue you now need to find your uncommented line for configuring the system, mine was at the bottom of the file and read as follows. 

{% highlight bash %}
- -transall -uamlist uams_randnum.so,uams_dhx.so -nosavepassword -advertise_ssh
{% endhighlight %}

The issue is easily fixed by changing this line so that it is as follows (note the change in bold): 

{% highlight bash %}
- -transall -uamlist uams_randnum.so,<strong>uams_dhx2.so</strong> -nosavepassword -advertise_ssh
{% endhighlight %}

So, whatever your configuration line reads I imaging as long as you change the bit that reads <tt>uams_dhx.so</tt> to <tt>uams_dhx2.so</tt> it should work.

Now just restart the service (see terminal command below) and get ready for the second error.

{% highlight bash %}
sudo /etc/init.d/netatalk restart
{% endhighlight %}

The second error was encountered after I connected to the server, so go ahead a connect (use your ubuntu login as a username and password), and wait.  After a second or two this error should appear:

<img src="http://danielgroves.net/wp-content/uploads/2012/01/Screen-Shot-2012-01-19-at-22.25.09.png" alt="Server Error" title="Server Error" width="534" height="275" class="size-full wp-image-627" />

This is also a quick fix, although the answer resides in a different file.  It turns out the the value that the guide tells us to use for <tt>cnidscheme</tt> is actually invalid, and so the server sends us this message every time we interact with it.  In order to get around this we need to change this to a valid value.  

Firstly, open the AppleVolumes.default file as follows: 

{% highlight bash %}
sudo nano /etc/netatalk/AppleVolumes.default
{% endhighlight %}

Now look find one of your network volume configuration lines, foe example i have this one which means that I can log in and access my user directory.  

{% highlight bash %}
~/ "$u" allow:danielgroves cnidscheme:cdb
{% endhighlight %}

The part reading <tt>cnidscheme:cdb</tt> is what is causing the error, so we change this to <tt>cnidscheme:dbd</tt> to fix the error, meaning the line would now read like this:

{% highlight bash %}
~/ "$u" allow:danielgroves cnidscheme:dbd
{% endhighlight %}

Once you have made this change to each directory configuration that requires it, simple save you changes and restart the services. 

{% highlight bash %}
sudo /etc/init.d/netatalk restart
sudo /etc/init.d/avahi-daemon restart
{% endhighlight %}

With a bit of luck, this post will help you to get round the issues that I have had.  If you hit any issues at all <a href="http://danielgroves.net/contact/" title="Contact">drop me a line</a> and I'll try to help as far as I can.  
