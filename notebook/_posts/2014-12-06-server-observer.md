---
layout: blog
published: true
title: "Shutting Down Server Observer"
excerpt: The reasoning behind why I am shutting down the Server Observer service, and what's coming next for it.

date: 2014-12-06 10:10
---

When I started working on Server Observer I was excited at the prospect of a new project; it was by far the most complex I had embarked on to-date and bought with it an interesting set of challenges and a steep learning curve. It was fun, however time has come to turn it off and move on.

This isn't a move that I really *want* to make; it's coming from necessity. There is little point in running a service I simply don't have time to work on and progress in the right direction.

The problem with the project in its current state is the lack of ability to make use of the data being stored. This isn't through lack of vision, or lack of implementation abilities. I simply don't have the time to work on implementing the new features. Further to this I want to optimise the backend code. It needs to be more efficient, which is a significant rewrite of the code which will take a *lot* of time. Despite this being well underway I do not feel that I have the time to finish this within a reasonable timeframe; I also wish I'd taken more time to think through the current set of changes. I feel like I may have gone down the wrong path with them.

Despite all of this the project has been a success. It's done everything I asked of it when I started working on it. It made the perfect final-year project where I managed to implement a large system for the three-months of coding time I had to build it whilst working on other university work at the same time.

As it stands the system has 16 test-users who have helped me throughout the last year. The system is currently holding about 7GB of data for these users, which translates to roughly 35, 779, 500 rows of data.

### What next?

Fistly, I'm going to turn-off the current hosted service at the end of the month. Do not expect to see anything open-source appear before this date.

Secondly, I don't want Server Observer to disappear into a graveyard never to be seen again. For this reason I'm going to work to cleanup the system into a state where it can be released as open-source software on GitHub in the coming months. I will release it as I submitted it at the end of my final year which will allow a fresh start on the changes than need to be made form the backend.

I do hope that others may consider helping build-up an open-source server monitoring utility that actually provides a nice user experience unlike the other offerings I have seen.

Before this happens I will take time to migrate any issues that need resolving from my current GitLab instance into GitHub so others can see what problems I know about which need resolving. I will also ensure all sensitive data is removed form the projects entire history and make the vagrant-based development environment available as part of the project.

With luck, the hosted and closed-source service may disappear but the years work that has gone into designing and building the product will not go to waste.
