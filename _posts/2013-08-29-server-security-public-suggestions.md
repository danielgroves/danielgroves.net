---
layout: blog
published: true

title: "Server Security: Public Suggestions"
date: 2013-08-29 13:00 +00:00
excerpt: "A follow-up to my previous Server Security post, featuring public suggestions"
---

A few weeks I published a blog post on [server security][security]. I promised to write a follow-up post the next week, which soon dwindled to today as various other things had to take priority. 

The post detailed what I was doing at the time to secure a new server as a whole. This provoked some level of response which is what I'll write about here, these are a few more packages that can be used, as well as a response to some discussions, that came out of the [previous post][security]. 

### Packages

After the previous post I was recommended some further packages that can easily be installed and configured in order to help with the protection on your server. Some of these will have been mentioned in the original article, but have more detail here. 

#### Unattended Upgrades

One of the first recommendations I received was to use `unattended-upgrades`.  This package automates the installation of system updates, you can configure it to only do security updates, or to do all updates. If required certain packages can be blacklisted from the upgrades. As with most packages on Ubuntu it is easy enough to install through apt. 

	sudo apt-get install unattended-upgrades

Once this is installed the package is easily configured in a text editor by editing `/etc/apt/apt.conf.d/50unattended-upgrades`. This is a relatively short configuration with good commenting so I won't explain it here, but if you do need more information [check the documentation][unattended-upgrades]. 

Once you have configured this you'll need to set the update intervals. This is done by editing `/etc/apt/apt.conf.d/10periodic`. This following example will update the packages list and downloads every day, and then install any upgrades. Once a week it will run an auto-clean to remove an dependencies that are no longer required. 

	APT::Periodic::Update-Package-Lists "1";
	APT::Periodic::Download-Upgradeable-Packages "1";
	APT::Periodic::AutocleanInterval "7";
	APT::Periodic::Unattended-Upgrade "1";

This removes a routine that otherwise you would have to do manually in order to ensure your server has all of the latest security patches installed. Once installed and configured your system will upgrade packages on your system as par your configuration, automating the update and upgrade tasks. 

#### Fail2ban

Fail2ban is a intrusion prevention framework written in Python which can help to prevent brute-force attacks by updating your firewall settings on the fly. Once installed you configure it to watch services, and then after a set amount of attempts block an IP address for a set amount of time. 

Fail2ban can be installed via `apt` and only takes a few minutes to configure with a basic setup. 

	sudo apt-get install fail2ban
	
Once installed navigate to `/etc/fail2ban` and duplicate `jail.conf` to `jail.local`. 

	cp /etc/fail2ban
	sudo cp jail.conf jail.local

Once you've done this edit the configuration file to suit your setup. Initially I'm running a very basic configuration with my own IP on the 'ignored' list, a longer blocking period (24-hours, or there about) and a shorter retry interval. This is easy to do, by tweaking the settings shown below. My IP is obscured by 'x'. 

	# "ignoreip" can be an IP address, a CIDR mask or a DNS host
	ignoreip = 127.0.0.1/8 x.x.x.x
	bantime  = 83600
	maxretry = 3

Further down you'll see another section where you should set your email address. 

	# Destination email address used solely for the interpolations in
	# jail.{conf,local} configuration files.
	destemail = you@example.com

And then further down another section to configure when fail2ban will send you an email. I have changed `action = %(action_)s` to `action = %(action_mw)s` as shown below, which means fail2ban will email with a whois lookup when it bans someone. By default it will just ban them without informing you. 

	# Choose default action.  To change, just override value of 'action' with the
	# interpolation to the chosen action shortcut (e.g.  action_mw, action_mwl, etc) in jail.local
	# globally (section [DEFAULT]) or per specific section
	action = %(action_mw)s

Although I intend to look into further options with fail2ban to further secure my server, for now all I have done is limit the amount of retries through ssh to three. 

	[ssh]
	
	enabled  = true
	port     = ssh
	filter   = sshd
	logpath  = /var/log/auth.log
	maxretry = 3

If you've already limited your server so it is only accessible via your own IP in it's firewall settings this is an unnecessary step, but for those (like me) who have a public-facing server this can help to prevent malicious attacks by simply blocking those who do attempt to gain access. For more information on fail2ban you should [check the documentation][fail2ban]. 

In the comments on the previous article [Steve Blamey][sb] pointed out that you can also rate limit with UFW. 

> UFW also provides rate limiting after 6 connection attempts within 30 seconds, providing some brute-force protection (only ipv4, though).

> To to rate limit ssh:
> `ufw limit ssh/tcp`

> For ssh on a non-standard port:
> `ufw limit 12345/tcp`

However, Fail2Ban is more powerful than UFW in that it allows you to integrate it into your Web Apps, providing an easy and secure way to block brute-force attacks on your web applications, such as [Wordpress][wordpress]. I won't cover how to do this here though, as there are plenty of good guides already available such as the [Random Bits one][rb_wp], as recommended by Fail2Ban. 

#### Other Suggestions

Other suggestions were [nmap][nmap] and [sshfp][sshfp]. I've not included details for either of these here as nmap is more of a security auditing tool, which is a whole other discussion for another time. sshfp, I think, is simply debatable as to how much it helps. If you check your SSH fingerprints anyway it is of no benefit, however it does add an element of convenience for those who otherwise wouldn't. 

### Discussions

Over on the [last post][security] [@Cycas][tw_cycas] made a few good points, which I feel are up for discussion. These mainly revolve around thinking more carefully around points I had already made in the last article. 

#### Root Accounts

Originally I recommended disabling root accounts on your VPS, but Cycas made the point that this may result in you getting additional downtime if your host requires this account for making configuration changes. 

> I had an issue with something that calls itself a cloud account [a] couple of years back, where they were doing infrastructure work at the datacentre [sic] where it lived, the account was down for several hours, according to the provider, because they were unable to log in as root to make an update until they got the root password

This makes a valid case for not changing the root password on your VPS, although personally I'd rather the company didn't have access to mine. It could be worth getting in contact with your provider before changing the password, or disabling the account, to see what they have to say on the matter. Ask them if they ever use it to make configuration changes, what the policy is for protecting the password and the usage policy of root logins.  

#### SSH on your IP only

In the last article I covered limiting SSH to one IP only, and that this should only be done if you have a static IP address. 

> It is important to note that you should only to this if your public IP is static, as a dynamic IP could change resulting in you getting locked out of your own server.

Cycas felt that this needs to be iterated on to try and enforce the point further. If you do want to limit SSH logins to only one IP address you really do need to ensure that is it static. Cycas suggests using backup ip addresses, but I would personally argue that is barely improves the situation if you're on a dynamic address still unless the backup is static. Having two dynamic addresses can still leave you in a situation where they both change, resulting in you getting locked out. 

#### Control Panel Security

The final point made was in regards to control panel security. My instincts with these is simply to avoid them, they're an unknown asset where a small security hole could easily compromise your entire server as they are often required to be run on the root account. 

If you really must use one it should be limited to ensure it is accessible by as few people as possible. You could even go as far (I would) as limiting it to your servers IP, meaning you would need to create an SSH tunnel to your server before you could access it, this way you have two stages of authentication that are required before you can use the control panel. 

---

For me the main two things I learnt to watch out for are the `unattended-upgrades` package and `fail2ban`, both of which I wasn't aware of before writing my [server security post][security]. 

The discussions in this post are all emphasising on points I have already made, but in more detail. If you have something to add then please do comment or [email][email], I'm always interested in hearing the views of others, especially those with more experience than myself. 

The main thing to learn from these posts was what else I could be doing to help protect my servers, and to help others learn in turn.  As far as I am concerned I succeeded here thanks to the feedback from others. 

[security]: http://danielgroves.net/notebook/2013/08/server-security/ "Server Security"
[unattended-upgrades]: https://help.ubuntu.com/12.04/serverguide/automatic-updates.html "Unattended Upgrades Documentation"
[fail2ban]: http://www.fail2ban.org/wiki/index.php/Main_Page "fail2ban Wiki"
[nmap]: http://nmap.org "Free securiy scanner"
[sshfp]: http://linux.die.net/man/1/sshfp "Linux manual page for sshfp"
[tw_cycas]: http://twitter.com/cycas "Cycas twitter profile"
[email]: http://danielgroves.net/contact/index.html "Contact Daniel Groves"
[sb]: http://www.adbury.net "Adbury Consulting"
[wordpress]: http://wordpress.org "Wordpress"
[rb_wp]: http://blog.shadypixel.com/spam-log-plugin/ "Integrating Wordpress with Fail2Ban"
