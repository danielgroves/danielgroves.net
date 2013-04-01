---
layout: blog
published: true

title: Version Three
excerpt: A look at some of the changes and decisions made in releasing version three of the site. 
---

A couple of weeks ago I released this site in it's current form. The old site was getting dated, and I felt Wordpress was over the top for what I was using the site for. 

Times have changed since I last redesigned the site. Last-time CSS3 media queries were only just gaining traction. Responsive sites weren't common and very little of the current CSS3 line-up was actually being used in production. Now, on the other hand, most new sites are responsive and make use of, at the very least, the more basic CSS3 properties such as gradients and border radius. 

When I was building my new site I wanted to make sure it was as fast as possible. For my target audience supporting a large history of browsers wasn't an issue, but mobile devices would be. For this reason I decided *mobile–first* design would be the best approach. 

### Mobile–first Design

Traditionally when building a responsive website you would start with a desktop site and adjust it by tweaking widths, positioning elements and hiding thing from view for lower-resolution devices using media queries. 

Mobile–first design does this the other way around; you design a mobile site, then layer on top using media queries and calling in additional (non-essential) materials using JavaScript. 

This approach holds several benefits. First of all, it means devices with low-bandwidth have less data to load before the user can use the site. It also means that browsers with lower capabilities are far easier to cater for. On mobile devices we're less likely to use advanced technologies that will go unsupported in older browsers, so supporting them becomes easier. 
<figure>
![The homepage rendered in the less capable IE9, notice the missing background gradient](/assets/images/blog/2013-03-16-version-three/home-ie9.png)
<figcaption>The homepage rendered in the less capable IE9, notice the missing background gradient</figcaption>
</figure>

The disadvantage to this approach also comes with the older browsers. They will not run the media queries which means they will be stuck with the mobile design. This does limit the design somewhat, but the important content is there. Besides, in the words of Andy Clarke:

> Supporting a browser needn't mean making a design look the same [in every browser]
> <p class="author">– Andy Clarke, [Hardboiled Web Design][1] </p>

I like Andy Clarke's point here, not all site need to be identical in every browser. As long as the experience is appropriate to what the particular browser supports, and the content is accessible, then we shouldn't worry about everything looking identical in every browser. 

### Leaving Wordpress

For the new site one of the first decisions I made was to leave Wordpress. I can't help feeling like Wordpress is suffering from feature-bloat in recent releases. Don't get me wrong, I think Wordpress is ideal for blog-format website with multiple authors, but on my personal website multiple authors isn't an issue. It's only me. 

I made the decision to move to [Jekyll][4], a Ruby static site generator. I have no need for a backend CMS or database driven website. I'm quite happy to write content using [Markdown][5] and then drop it into the relevant place once I'm happy with it. 

I'm actually using Git behind the scenes with two branches, 'develop' for unpublished things and 'master' for the live site. Anything that is merged into master and pushed to [GitLab][3] automatically gets pulled down to the server, built, and deployed. This means updating content on the site is still easy to do and doesn't require me to think about what I'm doing. 

One of my main reasons for choosing to move away from Wordpress is speed. Whatever way you cut it, a static site is going to be faster than any database driven website. 

### New Branding

It has to be around five years since I designed my old branding. That is quite a long time. I decided with this new site that I would rebrand myself as I wanted to achieve a clean and modern look which is somewhat more professional and so suited to finding more freelance work. 

The new branding was designed to present not just what I do, but also one of my main hobbies. The main shape in the design is a square, representing a *pixel*. I craft product for the web, which means I'm working with pixels on a daily basis. 
<figure>
![New logo representing both work and hobbies](/assets/images/blog/2013-03-16-version-three/logo.png)
<figcaption>New logo representing both work and hobbies</figcaption>
</figure>

Those who know me best may be able to take a guess at what the rounded cut-away section from the square represents. This is a wheel, with the small semi-circle on the far-right being a hub. One of my hobbies is mountain biking which is something I wanted to reflect in the new branding. 

The branding represents not just *what I do*, but *who I am* as well. 

### Summary

I feel like the new redesign has gone well. Feedback has been fantastic with only minor corrections being pointed out and the statistics from [Gauges][2] show that most features are supported well in all browsers that are visiting the site. 

The site itself reflects what I can do much better than the old site did and certainly fits in with the times a lot more. 

[1]: http://hardboiledwebdesign.com "Hardboiled Web Design website"
[2]: http://get.gaug.es "Gauges Analytics Tracking"
[3]: http://gitlab.org "GitLab, self-hosted Git management"
[4]: https://github.com/mojombo/jekyll "Jekyll, a Ruby static site generator"
[5]: http://daringfireball.net/projects/markdown/ "Markdown document syntax"
