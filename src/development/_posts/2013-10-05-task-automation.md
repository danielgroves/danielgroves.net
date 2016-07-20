---
comments: true

published: true
title: Task Automation
date: 2013-10-05 15:00 +01:00
excerpt: "Using cron for Jekyll site builds and automated server backups"
permalink: /notebook/2013/10/task-automation

tags: development
---

Doing a task manually for a while is fine, but us humans are somewhat unreliable when it comes to remembering to do small tasks everyday. You always have that brief thought of "*I'll do it in a bit*", and then proceed to forget about the task entirely. There is also the risk that you won't be in a position to complete the task at all, that you won't have access to the resources that you need, whether you're just in a meeting or on leave.

Again, this is fine for some tasks, but not for everything. For this reason I've recently been looking to automate a few tasks, some of which I've been meaning to get around to for some time, others I've only just considered automating.

## Server Backups

Don't panic, these have been automated for a while, but it hasn't been a solution I've been happy with. Initially I had to manually download everything, after this I had Rsync running on a cron job loading everything onto a local filesystem. The first approach took far to much time and effort to keep the backups, and the second lost some important information such as file permissions. My new solution retains file permissions and creates a collection of archives.

I wanted to start storing previous backups to reduce risks of data loss over time. Let me give you an example, say I go away for two weeks and a file is deleted by another user. I can't restore it until I get back, but without archives that file is lost forever when the next rsync job runs, overwriting the old backup. Archives make recovering from this easy.

Backups are now scheduled on a daily cron job, I may increase this in time if I feel the need, but for now this solution is fine. This cron-job runs on a [RaspberryPi][rpi], which has access to 3TB of redundant storage from my NAS (Network Attached Storage). The NAS has a filesystem for each server mounted as a loopback filesystem on the RaspberryPi. These filesystems are all formatted identically to the remote filesystem, allowing full permissions to be retained during the Rsync job.

Once the latest data has been downloaded by Rsync the files are compressed as a `.tar.gz`, which is archived on another drive.

{% highlight bash %}
#!/bin/bash

# Download Data
rsync -a --delete --exclude=/dev --exclude=/sys --exclude=/proc --exclude=/tmp odinson.danielgroves.net:/ /media/odinson

# .tar.gz data and archive
DATE=`date +"%Y-%m-%d"`
tar -zcvf /media/archive/odinson/${DATE}.tar.gz /media/odinson
{% endhighlight %}

This works fine, but there are a few more tweaks I would like to make when I get the time. I would like this script to store the last 30-days of backups, the last backup of each month for the last year and then the last backup of each year, much like Apple's [Time Machine][tm] does. I should be able to do this with another shell script, which parses the date of each tar and calculates it's age, deciding whether to keep it or bin it.

## Site Deploys

This website (as of writing) runs on [Jekyll][jekyll], which is a ruby-based static site generator. I've wanted to automate the deployment of this sites latest changes for some time, but have always had issues getting something working.

The entire site is committed into a git repository which I push up to my GitLab install. With this I wanted a post-receive hook which could hit a URL, which would pull the latest changes and build the site.

However, this is somewhat more difficult than it sounds. After some research is turns out that PHPs `shell_exec` function cannot run ruby gems, which I require in order to issue the `jekyll build` command. As a result this approach doesn't work, I considered writing something in Ruby to deal with it, but decided the time to how to deploy a Ruby script is time I don't have at the moment.

The solution I've settled with instead is a cron job running a shell script every few minutes, which *can* access my ruby gems. My site [is open-source][os-site], so anybody can go and browse the source for it. However, do I keep a private repository for it as well, as I like the ability to push changes that only I can access while I experiment with ideas.

The version of the site you see on GitHub is a clone of what runs on production. To save me having to manually push the latest changes to GitHub I decided to take advantage of this script to do that for me. Everything in the repositories *master* branch is production, and deployed as what you see here. As this script is already pulling the master branch and building the site I decided to make it automatically push changes to the master branch up to GitHub as well, removing another manual job for me.

{% highlight bash %}
#!/bin/sh

# Pull the latest changes
git pull origin master

# Build the site into the htdocs directory, so it's live straight away
/usr/local/bin/jekyll build -d htdocs

# Sync up with GitHub open-source copy
git push github master
{% endhighlight %}

Making changes to the site is now effortless, commit the changes and push them to the server. As soon as the next hour comes around the cron-job fires which runs the shell script, pulling in the changes and deploying them for me. Before this I was having to manually ssh into the server, pull the changes and build them myself.

---

Automating both of these tasks took under an hour, and saves me as much time every week, as well as taking yet another task off my mind. The main reason I've shared this here is with the hope of helping save someone else time, or gaining feedback which could save me trouble further down the line, or teach me something new.

[rpi]: http://www.raspberrypi.org "RaspberryPi $25 computer"
[tm]: http://support.apple.com/kb/HT1427?viewlocale=en_US&locale=en_US "Time Machine Mac backup utility"
[jekyll]: http://jekyllrb.com "Jekyll static site generator"
[os-site]: https://github.com/danielgroves/danielgroves.net "Open-source versions of this site"
