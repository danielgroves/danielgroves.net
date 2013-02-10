---
layout: blog
published: true
title: WordPress Server Migrations
date: 2012-07-01 12:43:37.000000000 +01:00
excerpt: After moving to a new server over the last few months I walk through a "bullet-proof" set of steps to migrate WordPress installations between servers with minimal downtime. 
---
Recently I have been finishing the migration of websites from my old server to the new [VPS I recently wrote about](http://danielgroves.net/2012/06/starting-out-with-a-vps/). Having learnt a lot during this process about the better ways of doing things I figured it best to build a checklist to follow before forgetting all that I've learnt in the last few weeks.

This checklist assumes that you are migrating a WordPress install, although the steps should be similar for migrating any website.

### Migrating a site

Initially I always lock down the site. I'm not going to reference any particular plugin to do the job here, there are plenty to choose from, but essentially you want to stop users commenting and members from posting. Your aiming to stop people from writing to the database to ensure it integrity during the transfer process.

Once you have locked down the database transfer the files to your new server and download a copy of your database. Create your new database on your new server and import your data. Once your files have been transferred update any database settings that need changing such as usernames or passwords.

Once this is done its time to update the DNS for your domain. Ensure the server is ready to receive traffic for the domain by configuring your server, for example in Apache you would need to create a new file in the sites-availiable directory. Once this is done point your domain to the new server.

Now it time to play the waiting game. Wait until your able to access the site through the domain on the new server and navigate to your settings and then permalink structure, don't change anything just hit 'Save Changes'. This will make sure that your .htaccess file is present and correctly set-up as this is often missed when transferring the site between servers. Now remove your lock down to allow the sites users to resume activity like normal.

### Summery

So, to summarise in a few short steps:

1) Enable a website lockdown
1) Transfer files
1) Transfer database
1) Update database settings
1) Configure server for domain
1) Update DNS settings
1) Save Changes on permalinks to regenerate .htaccess
1) Remove lockdown

If these instruction are followed carefully their shouldn't be any issues after the transfer. It should all go smoothly and the users shouldn't notice any significant downtime.
