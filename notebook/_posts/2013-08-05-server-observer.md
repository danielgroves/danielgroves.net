---
layout: default
comments: true

published: true

title: Server Observer
date: 2013-08-05 17:00 +00:00
excerpt: "Some details on my new project I am embarking on for my final year project, <em>Server Observer</em>"
---

Recently I registered a new domain name, [serverapp.io][so]. This has been registered for an upcoming project which I will be completing as part of my final year project at university, but I'm also hoping for it to become *more* than just a final year project. You see, I'm yet to write a single line of code for it, but I have a lot of ideas for what I want to do and how to make it better than the competition. 

The idea for the service is to provide up–to–date information about one or more servers, and allow the user to trigger alerts when certain thresholds are met by the server resources. So, for example, you could say when the RAM hits 90% or more capacity then send an email to the account holder to let them know. 

<figure>
	<img src="/assets/images/blog/2013-08-05-server-observer/so-banner.png" alt="Server Observer Banner" />
	<figcaption>
		<em>Server Observer</em> — Simple and Reliable Server Monitoring
	</figcaption>
</figure>

Taking advice from others I know who have already completed final year projects in the past, I intending on keeping this simple until I graduate. I don't want to set the bar too high and end up getting too stressed about hitting it. Because of this, my current plan is to aim to incorporate the following features into the initial version of the product:

- Resource Usage; CPU, Memory, Disk-space, Bandwidth (Network I/O), and Uptime
- Custom Alerts; triggered based on user-defined terms
- Alerts; SMS and Email

So, a pretty limited initial feature set. However, I'm hoping to build a solid, fast and stable foundation on which to continue developing the product. In the long term, I am hoping to take the feature list a lot further, providing a stable and extensible platform. Long terms features I currently have in mind include:

- Individual process data
- Twitter DM and App.net DM alerts
- URL statuses based on returned content, and document headers (such as 200, 404 and 500)
- Teams
- [Webhooks][webhooks] support

At this stage implementing the right features to allow me to pass my [degree][degree] is the priority, and allowing for it to easily to adapted into a business model is a second priority. My aim is to release a *fairly priced* product which is both easy to use and reliable. At this time I don't have any plans to monitor in-application performance, but only to look at the bigger picture of monitoring servers as a whole. 

Over the next year I will be looking for private Beta testers as various stages, which will provide completely free access to the service during the beta phase to test the functionality and stability of the service. I will (initially at least) only be providing access to those I know in person, if you're interested in getting on this list of people come and introduce yourself. I will be at [Agile on the Beech][AoB] in September and the [DigPen][dp] conferences over the next year; if you're at either of these and want to meet just give me a shout by [email][email], [Twitter][tw] or [App.net][adn]. 

I'd also appricaite it if you would take a moment to follow the project on [Twitter][so-tw], 'Like' it on [Facebook][so-fb] or [suscribe to the Email list][so]. 

[so]: http://serverapp.io "Server Observer; Reliable and Simple Server Monitoring"
[so-tw]: https://twitter.com/ServerObserver "Server Observer on Twitter"
[so-fb]: https://www.facebook.com/ServerObserver "Like Server Observer on Facebook"
[aob]: http://agileonthebeach.com "Agile Development conference in Setember"
[dp]: http://digpen.com "Grassroots community for makers of digital stuff in South-West England"
[email]: http://danielgroves.net/contact/ "Email via contact page"
[tw]: https://twitter.com/danielsgroves "Myself on Twitter"
[adn]: https://alpha.app.net/danielsgroves "Myself on App.net"
[degree]: http://danielgroves.net/notebook/2010/09/web-application-development/ "Web Applications Development at Plymouth University"
[webhooks]: http://www.webhooks.org "Webhooks documentation site"