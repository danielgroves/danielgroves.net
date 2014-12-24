---
layout: blog_comment
published: true

title: Approaching Responsive Design
excerpt: "Some considorations for approaching a new responsive web design project"
---

When approaching a responsive website there are two main approaches, *mobile–first* or *desktop–first*.  Both have their advantages and disadvantages, so the method you choose should depend on your audience, browser–support requirements and how restricted you are by legacy code. 

### Mobile–first Design

The idea with mobile–first design is to approach the design for mobile devices first, as the browsers on these devices tend to have less power and capabilities at there disposal.  Once the most basic mobile design is ready you apply progressive enhancements to the site to improve and re-flow the content for larger, or desktop, devices. This essentially means starting by designing for a narrow width and then using media-queries to reflow the content for wider devices. 

When designing for mobile many people, myself included, find it easier to work to the old rule of *content is king*.  You're very limited in the amount of space you have, which forces you to think about what the user really wants. What content is the most important?  Is this *really* required?  Working to the mobile–first methodology also helps to keep file sizes small as graphics are often layered on top of the site, and smaller version of many images can be served. 

One mistake that can be made here is assuming that a mobile device has a high–resolution display. A much better approach is to serve images on a 1x scale by default, and then use a media query to progressively enhance the images, serving a 2x scaled version as necessary. As we can see by taking a look at the charts on [screensiz.es][ss] high-density screens may be common on mobile handsets, but on tablets they are less common, and less so still on desktop devices. 

One issue with working to the mobile–first methodology is how minimal the content is. Often their is additional *desired* information to be shown when space allows, or if their is enough bandwidth. In order to show this content we use JavaScript to load the content in afterwards; it's important that this is *not* used in order to load vital content, this should always be present in the default markup, only to load additional features. This could be an interactive quote form which replies on JavaScript anyway, or an additional image gallery. By loading this in afterwards to not only present the user with a working website earlier, but also save bandwidth as you can load the extra resources only when they are scrolled into view. 

Mobile—first can really help you to think about what is actually required and what is content is just extra *"fluff"*, and so not really required. Due to this mix of really putting the content first and progressive enhancement this is my favourite approach. 

### Desktop–first Design

Desktop–first based responsive design is probably the most common form on the web today. It's the easiest way for responsive design to be implemented as it allows for the use of exiting code, preventing the need for a ground-up rebuild of the site. This method is often favoured, especially on larger sites with a lot of legacy code, as it allows for a fast 'conversion'. 

The desktop–first approach tends to result in sites that are slower loading than mobile–first sites due to everything being loaded in a desktop form and then adapted down. This often means that areas of un-needed content are loaded, and then hidden, for a mobile device resulting in reduced preference due to more http requests and browsers rendering pages multiple times. 

---

When designing for the responsive web we need to be thinking about the end user. What matters the most to them?  A fast and responsive site on their mobile, or a highly-featured desktop site with good backwards compatibility?  Neither method of responsive design is well suited to every project, you need to consider the project requirements and the user base. 

If backwards compatibility is required, than it's *got* to be the desktop–first approach, but if the users simply want a minimal site which gets them information fast mobile–first is the way to go. 

[ss]: http://screensiz.es "Device screen size comparison charts"