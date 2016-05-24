---
comments: true

published: true

title: Experiences with Nginx
excerpt: "Documenting some of my experiences and problems that arroused when I made the decision to switch from Apache to Nginx"
permalink: /notebook/2013/06/experiences-with-nginx
---

I've used Apache in production and development environments for about as long as I can remember, but when I recently switched to [Digital Ocean][do] I also made the decision to switch to [Nginx][ng].

<em><strong>Disclaimer:</strong> This post doesn't contain any information with hard facts or evidence behind it. Although I may occasionally link to evidence compiled by someone else there is plenty of this online already. My sole focus is on my experiences with Nginx.</em>

The first thing I noticed after installing and configuring Nginx was the sheer speed of it. Unlike Apache which will load PHP into memory for every request whether it is required or not, Nginx passes requests for PHP off to a separate server (more on this later). This means Nginx has a pretty small footprint on your server as it doesn't load any additional resources to serve static content such as an image or a plain-text file.

When it comes to running PHP with Nginx the most common choice is to run php-fpm, this essentially acts as a separate server, which you can then pass your PHP files onto. For example, this is how Nginx might be configured to handle PHP for a WordPress install.

```
location ~ \.php$ {
	try_files $uri =404;
	fastcgi_pass 127.0.0.1:9000;
	fastcgi_index index.php;
	include fastcgi_params;
}
```

This essentially takes any requests for a file ending in `.php` and sends them to the PHP server, in this case running on port 9000. Now, this doesn't work with rewrites as you may have guessed, and as Nginx doesn't read `.htaccess` files the WordPress default configuration won't help here either. It is however easy enough to add these rewrites.

```
location / {
	try_files $uri $uri/ /index.php?q=$uri&$args;
}
```

So in only a couple of lines we now have working rewrites with Nginx for a WordPress install. As an extra security precaution I also decided to block access to any dot files, php files in the uploads directories (I've not configured the server to run other formats, so they aren't an issue) and not to log any issues with media files. I've also set the expiry time to the maximum on the media files.

```
location ~ /\. {
	deny all;
}

location ~* /(?:uploads|files)/.*\.php$ {
	deny all;
}

location ~* ^.+\.(ogg|ogv|svg|svgz|eot|otf|woff|mp4|ttf|rss|atom|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|ppt|tar|mid|midi|wav|bmp|rtf)$ {
	access_log off;
	log_not_found off;
	expires max;
}
```

That's all there is to it really, a full WordPress configuration file could something like this.

```
server {
	root /path/to/exmaple.com
	index index.php index.html index.htm;
	server_name example.com www.example.com

	location ~ /\. {
		deny all;
	}

	location ~* /(?:uploads|files)/.*\.php$ {
		deny all;
	}

	location ~* ^.+\.(ogg|ogv|svg|svgz|eot|otf|woff|mp4|ttf|rss|atom|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|ppt|tar|mid|midi|wav|bmp|rtf)$ {
 		access_log off;
		log_not_found off;
		expires max;
	}

	location / {
		try_files $uri $uri/ /index.php?q=$uri&$args;
	}

	location ~ \.php$ {
		try_files $uri =404;
		fastcgi_pass 127.0.0.1:9000;
		fastcgi_index index.php;
		include fastcgi_params;
	}
}
```

The official WordPress documentation now has an [official guide][wpng] on setting up WordPress with complete support for features such as multi-site support. At this time the documentation is incomplete and somewhat difficult to work with, but is also improving.

WordPress isn't the only system to document Nginx support now either, other systems, like [PyroCMS][pyro], are also documenting how to get their system working in order to tap into the superior speed and performance gains that Nginx can offer. This move being made is highly beneficial to those who are building sites that need to scale up to the tens of thousands of clients, down to those who are just trying to keep costs down by using the smallest server they can get away with.

The performance increase for the resources used between Nginx and Apache is very noticeable. I didn't record any differences when switching, but there really isn't any need for me to, as [other][r1] [people][r2] [have][r3] [already][r4] done plenty of research into the performance gains that can be expected from Nginx.

---

Moving from Apache to Nginx wasn't all bells and whistles, though. The move bought a selection of it's own problems along with it, each needing to be solved before the new server could be used in production. For me, one of the biggest issues was simply the lack of familiarity. There was a certain workflow I was used to using with Apache which simple is not transferable to Nginx as it is not configured in the same way as Apache was.

Once I got used to working with Nginx, however, I stopped missing things like the `.htaccess` files for doing directory–specific settings. It *is* a little more faff to have to configure these settings in the main site configuration file, but it is actually a lot tidier (not to mention faster) to keep everything together and saves hunting around for the particular file that is causing an issue, knowing everything is together.

My other issue I've found is having to write rewrite rules manually for some applications, but this is only due to the current lack of support for Nginx from some web apps. This is, however, improving as more applications are being provided with support for configuring Nginx for them, and looks to keep growing over the next few years.

---

I don't regret moving to Nginx; it's far faster than Apache, which is the main thing for me. I'm looking foreward to seeing more applications supporting Nginx in the future as it will make life easier when configuring them, but for the most-part if you search online you'll find someone who has already setup the application on Nginx and has shared the configuration they have used.

So, Nginx is faster, but lacks the support that Apache has at the moment. For me, the speed of it outweighs these disadvantages; as the support for it improves I suspect it'll start to become a lot more common-place for people to default to Nginx over Apache.

[do]:https://www.digitalocean.com/?refcode=d0820e126448 "Digital Ocean Referral Link"
[ng]:http://wiki.nginx.org/Main "Nginx open-source http-server"
[wpng]:http://codex.wordpress.org/Nginx "WordPress documentation for configuring Nginx"
[pyro]:http://docs.pyrocms.com/2.1/manual/setup/nginx-with-php-fpm "PyroCMS Nginx Settings"

[r1]:http://joeandmotorboat.com/2008/02/28/apache-vs-nginx-web-server-performance-deathmatch/
[r2]:http://systemsarchitect.net/apache2-vs-nginx-for-php-application/
[r3]:http://www.wikivs.com/wiki/Apache_vs_nginx
[r4]:http://blog.celingest.com/en/2013/02/25/nginx-vs-apache-in-aws/
