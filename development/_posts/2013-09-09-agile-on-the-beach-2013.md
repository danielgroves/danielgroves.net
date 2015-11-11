---
comments: true

published: true
title: Agile on the Beach 2013
date: 2013-09-09 13:30:00.000000000 +00:00
excerpt: "My experiences and lessons from Agile on the Beech 2013"

tags: conference aob
---

Around six months ago Kieron Marr and I were selected to attend the Agile on the Beach conference by our university course director. Having been to a few of the DigPen conferences in the past I was very keen to attend more conferences, meet more people, and learn more from the industry experts. Agile was the biggest conference I've attended and had a very different feel from the smaller grass-roots conferences I've previously attended. 

The conference proved to be an interesting and exhausting few days, but I learnt a lot about where the industry stands in regards to agile development and how industry professionals are currently working. After attending ten sessions over two days I have found myself reviewing my personal workflows to see how I can incorporate what I have learnt in order to make more workflow easier and more efficient. 

<figure>
	<img src="/assets/development/2013-09-09-agile-on-the-beach-2013/conference.jpeg" alt="A full auditorium during the day two keynote" />
	<figcaption>
		A full auditorium during the day two keynote
	</figcaption>
</figure>

The conference started with a talk by Dan North titled *Jackstones: the journey to mastery*. During his talk Dan spoke about how it had taken him so many years to master the *Jackstone*, which is a complicated piece of origami which forms a small paper stone on completion. Dan used this example to talk about what mastery of a subject is and how this applies to software development. 

> Mastery is a constantly flawless performance<br />
> Mastery is consistently playing at your best<br />
> Mastery is adapting instinctively to unfolding events<br />
> Mastery for us is producing beautiful code<br />
> Mastery for us is developing wonderful products<br />
> Mastery for us is creating business impact

He followed his explanation of what mastery is with advice on how to achieve mastery, he spoke about how you need to learn how you learn.  He recommended solving real problems, and how you should fix things, broken or not, until you are a master of your subject. His final piece of advice was to find someone who is where you want to be, and to see how they conduct their trade. 

> Find someone who does what you do; model them, stalk them. 

A common theme at Agile was how important unit testing is. Unit testing was briefly covered at university during the Java module in second year, however it wasn't the main focus of the module and so wasn't covered in depth. One thing that Agile has helped me with understanding how important unit testing is when working on larger scale software, and how it can help to prevent issues occurring once software is deployed into product by catching problems in advance. 

On its own learning about why we unit test was important, but it was made ever more useful by learning what goes into a good test and what goes into a bad test. The *Good Test, Bad Test* session held invaluable lessons which will be applied to my final year project in order to help ensure a good solid code base that will be as easy as possible to expand on in the future. 

Some of the main points covered were how tests should be fast to give immediate feedback, and how they should be incremental, testing small amounts of functionality one bit at a time to make it as fast as possible to why software is failing when it does. We were also advised that unit tests should never talk to data sources. This slows tests down, and is not unit testing; it is integration testing. 

> Things that talk to the database are not unit tests. Things that talk to the filesystem are not unit tests. Things that talk over the network are not unit tests. These tests have value; they are just not unit tests. 

While talking about testing Continuous Integration (CI) was mentioned. CI is something that I have never quite understood the point of in the past. Thanks to these talks I now understand that CI servers exist simply to run tests against code. They can be used in order to check the compatibility of new changes, or of merge-requests submitted through source control systems. 

During the *Micro Services* talk James Lewis spoke about how many systems are migrating from one large system with a single point of failure (normally the database) to multiple smaller integrated systems with multiple points of failure. This new method of working helps by decreasing the chances of any one point failing and taking an entire system down with it. During this talk the methods of building several smaller systems that talk to each other confirmed to me that my initial plans for how to construct my final year project is for the better, and that I am taking the best approach for the product. 

---

Each talk during the conference either taught me something new, or gave me fresh ideas on how to approach problems such as ensuring code modifications does not break any other functionality in my code base. The two days were intense, but taught me a lot of invaluable lessons which will not only help me to get through the final year of my degree producing the best work I am capable of, but will also ensure that all of the code I write in the future will be as clean and dependable as possible. 