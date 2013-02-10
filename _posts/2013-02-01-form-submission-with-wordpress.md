---
layout: blog
published: true

title: Form Submission with WordPress
excerpt: How I dealt with a form $_POST issue at work. 
---

Those of you who work with WordPress frequently may or may not have experienced this "bug". Mind, I'm calling this a bug without being too sure if I'm just doing something stupid, or if this really is a bug.

I don't recall ever experiencing this before though, and I've worked with WordPress for quite a few years. WordPress has a lot of form creation and processing plugins, but I've never been happy with any of them and for that reason I tend to manually implement forms as and when I need them. Even if there was a half-decent plugin for creating forms it wouldn't have helped with this particular issue; the form needed to be integrated with a 3rd party text-messaging API.

This particular issue was a problem with submitting the form to the same page as the form was originally on. At the top of these page I included a function which would take care of processing the form; if need be it could also show errors.

Initially the form written in the logical way, I passed the page permalink into the action attribute. After some experimentation it appeared that the form wasn't POSTing properly. Noticing this wasn't working I proceeded to try it with GET instead. Again, I had the same problem and couldn't access this data.

At this point I tried a few different ways of phrasing the action. I went from the full URL (http://example.com/contact) to just the page (/contact) and then eventually I tried leaving it blank.

When I left the field blank it worked immediately. Currently I'm not too sure why this is the case, I haven't had any time to investigate in full. But, if you get the same issue as me, it could be worth giving this a quick try.