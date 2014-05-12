---
layout: blog
published: true
title: Starting Out with a VPS
date: 2012-06-01 16:16:24.000000000 +01:00
excerpt: A look into why I decided to make the move from a grid hosting package to a VPS and some of the challenges I faced. 
---
It's both a good and a bad day when you need to upgrade your web hosting. It's bad due to the cost increase, but it's good because your websites are doing well enough to justify the new hosting. For me the jump from a [grid service with JustHost](http://justhost.com/ "JustHost") to a VPS was essential.

JustHost are cheap, yes. Thats rather appealing when you first start out, but you soon outgrow it. If I'm honest I should have upgraded about a year ago, but I just didn't have the confidence to run a VPS. When April came around this year I decided I just couldn't wait any longer so I jumped ship into a rather steep learning curve.

Now, don't get me wrong, as a web developer I have played around with Apache, PHP and MySQL many times before, but always on higher spec dedicated machines (at least 1GB RAM), not a 256MB RAM VPS. Setting up a server for the sake of experimentation is very different when it has plenty of system resources and next to know traffic, somewhat different to a production server.

I chose to go with [Prgmr](http://prgmr.com/xen/ "Prgmr Xen VPS Hosting") on a [friends](http://nickcharlton.net/ "Nick Charlton's Personal Website") recommendation, opting for the 256MB package, after this I went for Ubuntu Server 10.04 LTS for the operating system. The server had now been running since the start of April, and stably since the start of May.

### Setup

The initial set-up was easy enough, install SSH, turn the firewall on, open the needed ports and install a LAMP (Linux, Apache, MySQL, PHP) stack. I then proceeded to configure several virtual hosts so that I could run multiple sites off the same server.

Setting up virtual hosts is done easily enough by setting up a site configuration file in ```/etc/apache2/sites-available```. Once this is done it's simply case of running ```sudo a2ensite``` followed by the name of the site in question, for example danielgroves.net.

After reloading apache the virtual host was then ready to accept incoming traffic for the domain.

### sudo su root

Logging into the server as root to save typing 'sudo' repeatedly was a bad idea. When sorting the directory permissions ready for the first site migration I missed the dot when I meant to run ```chmod 775 -R ./*```, meaning I ran ```chmod 775 -R /*``` instead. By the time I realised what I had done it was too late, the command was already munching it's way through the server changing the permissions on everything.

Thats a lesson learned and mistake that I will not be making again. After this I proceeded to do a reinstall of Ubuntu Server from scratch, I figured that I didn't know how extensive the damage was and giving how little set-up was actually done and that no sites had yet been migrated I decided this was the best option.

### Site migrations

The first site to see the trip through hyperspace onto the new server was danielgroves.net, this site, my personal portfolio. Initially I proceeded to disable all caching plugins, knowing that potentially they could cause issues further down the line, and then I transferred the Wordpress installation files across to the new server.

While the files were transferring I made myself busy by creating a new MySQL database on the server under a user with local access only for the site. From here I did an SQL dump of the database on the old server and imported this into the new database on the new server. Once this was complete it was just a case of waiting somewhat for the files to finish transferring from the old server to the new, this took some time due to the appalling download speeds from the old server.

Once completed I updated the WordPress wp-config.php file to match the new database settings I proceeded to set-up the domain. This was simply a case of pointing it to the new DNS server, then setting it to point to the new server and then configuring the MX records with the Google Apps settings.

A few hours later it was clear that all went to plan. The site was working, and working well, on the new server and mail was being sent and received properly. After re-enabling WP Super Cache I only wished I had made the time to do the transfer earlier. I don't remember ever getting these kind of speeds when I was with JustHost.

All of the sites that I am currently running on the site are all Wordpress based, and so I simply repeated this process for each of the other sites that I was migrating. At this point the server had two additional sites running on it, AppFlow, Writhlington Orchid Project and this one.
### Fighting with memory
At this point the server was starting to get alarmingly slow. All of the sites running are cached but the server was starting to cruel none-the-less. A quick investigation of the memory by running ```free -m``` showed that I was completely out of RAM and SWAP space, I dropped prgmr.com an email at his point asking them to bump me up to 512MB of memory.

Once this was done it was an improvement. Previously the server was needing to be reset once an hour to keep it running enough to even be able to SSH into it, but it was still slow. At this point I was still resetting it once a day, something which I obviously shouldn't have had to do. I soon found that Apache was hogging, at best, 70-80% of the servers memory. After some quick research I managed to get this level down to around 30%, a much more acceptable level. As would be expected it still hogs more memory with the more traffic that hits the server.

Since making these changes I haven't had to reset the server at all, it's now been up for about two weeks with an average of ~150MB of memory free. It's not urgent now so I'm not going to make this an immediate priority but I do intend to find a way to strip down the amount of memory that is in use further by stripping out unused packages and refining the settings to suite my server further.
### A Wordpress war
Every time I am reasonably happy with the server, something else seems to crop up. Currently the main thing I am trying to fix are Wordpress specific issues. Once this issue is fixed I will be hosting client projects on the server, and for these I need the Wordpress auto-update feature to be working.

The Wordpress installs currently have the permissions that are advised by the Wordpress website, and all of the files are owned by www-data (the apache user), but the auto-update feature still asks for FTP details when run. If anybody has any suggestions please do leave a comment or [drop me an email](http://danielgroves.net/contact/ "Contact Me").
