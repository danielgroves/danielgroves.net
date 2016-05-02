---
published: true
title: "Serving Images Dynamically with on-the-fly Rendering"
excerpt: Using Imgix to dynamically render responsive images on the fly.

date: 2016-05-01 08:30

tags: images development responsive
---

A problem I've been looking for a solution to for a little while now is how to approach serving images on this website. Many of the posts, particularly in the _[adventures and photography][adventures_photography]_ section, have lots of high-resolution images. These images are around 1500px wide but many devices have screens significantly smaller than this, so a lot of loading time and bandwidth is wasted. The solution is to use responsive images.

## Choosing the right method

Before we can choose the right method to serve the images, we need to understand exactly what the requirements are. In my case I had a criteria I wanted to get as close to as possible:

* I wanted a single source for all instances of an image (not a directory per post as before). This increases the likelihood of there being a hit on the CDN and speeds up serving the image.
* I wanted to step image sizes to the nearest 100px, once again the increase the likelihood of a CDN hit, whilst minimising wasted data.
* I wanted to remove all master images from the repository my website lives in. It was starting to get a bit too big for my liking, and this would increase my options in the future.
* Ideally I wanted to serve [WebP images][webp_images] to browsers with support to take advantages of the vastly more efficient compression.

There's currently three different primary methods to serve responsive images, each with their own advantages and disadvantages. Let's take a look:

### srcset

Use of the `srcset` attribute allows you, the developer, to provide additional images for a browser to choose from. The idea here is that you provide a range of images of different resolution and the browser will pick the best one to display. Being an extra attribute on the normal `img` tag probably means this would be the easiest to integrate into a legacy site.

The HTML in the page would look something like this:

{% highlight html %}
<img src="image-one-small.jpg" srcset="image-one-medium.jpg 700w, image-one-large.jpg 1000w" alt="Image One">
{% endhighlight %}

You can add as many different `srcset` options as you like, however each of these images would have to be pre-generated. This is something I wanted to avoid, but we'll look at different approaches to generating images later.

### picture/source

Using `picture` and `source` together is slightly more complex than `srcset`, however it is far more flexible. As shown in the example below is allows you to add media queries into the mix, and still allows you to provide a standard fallback image which will always display in a worst case scenario.

{% highlight html %}
<picture>
  <source media="(min-width: 40em)" srcset="big.jpg 1x, big-hd.jpg 2x">
  <source srcset="small.jpg 1x, small-hd.jpg 2x">
  <img src="fallback.jpg" alt="">
</picture>
{% endhighlight %}

In my situation, the pitfalls here are essentially the same as with `srcset`: I have to generate a lot of images up-front, and it's difficult to serve different images formats to different browsers.

### data-src

Using the `data-src` attribute (you can call this whatever you like, actually) is by far the most flexible approach. You essentially have a normal image but replace the `src` with a `data-src` attribute instead. You then use JavaScript to inject the real `src` attribute when you've programatically decided it's the right time to do so, and what you'd like to load.

We can still support fallback images with ease as well, thanks to the html `noscript` tag.

{% highlight html %}
<img data-src="image1.jpg" alt="Image 1">
<noscript>
  <img src="image1.jpg" alt="Image 1" />
</noscript>
{% endhighlight %}

I like this approach more than the others thanks to the additional flexibility. As the `src` is set dynamically at runtime I can inject additional information which could be interpreted by a remote service such as a width and height. The final `img` tag might end up looking something like this:

{% highlight html %}
<img src="image1.jpg?width=1500&height=800&format=webp" data-src="image1.jpg" alt="Image 1">
{% endhighlight %}

This opens up the world of producing renders on-the-fly using a server-side service based on the given URL parameters.

## Optimus

I've already mentioned that I didn't want to generate all of the possible image combinations at build time. I did experiment with this pretty early-on, however I found that even with what was, at the time, a pretty minimal image set I was waiting 10-minute for the image task, even on a dedicated build server. This was always going to grow directly with the number of images I add. I'm regularly adding new posts with a significant number of images, so realistically this was never going to be a future-proof option.

Having ruled out pre-generated images entirely I decided to look into dynamically rendering images on-the-fly. The idea here would be to have a "bucket" of master images which would be used as the source, and for image requests to have a width and height appended. I'd then be able to resize the image to these dimensions, cache the rendered image on my Cloudfront CDN and serve this to future clients with the same screen properties.

I wrote a Rack application called _Optimus_ to generate these images. As I suspected at the start the performance simply wasn't there, and the best way to speed this up was going to be doing the renders on a GPU, however cloud GPU instances are _expensive_. Unfortunately, this site does not pay the bills (it doesn't actually pay me _anything_ right now) so spending $100+ on a GPU instance is not realistic.

## Introducing Imgix

After some digging around a friend eventually recommended looking into Imgix. Imgix essentially does what I wanted to achieve with Optimus, only on dedicated hardware and as a service. It's cheap too, with plans starting from $10/mo. After having a look around to see what their query-string based API was capable of I decided to integrate and see how it performed.

At this point I re-exported every single image from Lightroom into a single directory with a naming convention (`year-month-web-original_name.jpg`) which I then synchronised with an Amazon S3 bucket using Transmit. I created a read-only user for Imgix, which can use an S3 bucket as an origin source.

Imgix also provides a lightweight JavaScript library to handle client-side images. This couldn't be simpler to work with as it simply requires a `data-src` attribute and a class for it to hook into. The markup on my site around images is generated through a plugin I wrote for Jekyll, so it was simply a case of adding this class in the output HTML and adding the configuration for Imgix to the page.

{% highlight javascript %}
imgix.onready(function() {
  imgix.fluid({
    lazyLoad: true,
    lazyLoadOffsetVertical: 500,
    pixelStep: 100,
    debounce: 200,
    updateOnResize: true,
    updateOnResizeDown: false,
    updateOnPinchZoom: false,
  });
});
{% endhighlight %}

The Imgix library provides built in lazy loading and image reloading if required. I have configured both of these, and my configuration is easily explained:

* `lazyLoad: true`: Lazy load images os they not downloaded until the user is close to them on the page.
* `lazyLoadOffsetVertical: 500`: Load images when the user is 500px away from them in vertical scrolling.
* `pixelStep: 100`: Round the size of images up to the nearest 100px.
* `debounce: 200`: Wait for the user to pause for 200ms before requesting resized images.
* `updateOnResize: true`: Request new images if the user reloads their browser window.
* `updateOnResizeDown: false`: Don't request new images if the user makes their window _smaller_.
* `updateOnPinchZoom: false`: Don't request new images if they use pinch zoom (such as on an iPhone or iPad).

Lazy loading the images like this brings in the advantage of saving further bandwidth for any users that don't scroll all the way to the bottom of a pieces of content. This also provides a much faster initial load time as the browser will not wait for images to complete downloading.

One limitation of the Imgix library is that it will not submit the height of an image when it requests it, only the width. This resulted in post list thumbnails looking awkward as the 4:3 image ratio doesn't suit the layout of these pages. This is easily handled as the library allows us to modify the request parameters before they go out. This is simply done by creating a callback function:

{% highlight javascript %}
imgix.onready(function() {
  imgix.fluid({
    lazyLoad: true,
    lazyLoadOffsetVertical: 500,
    pixelStep: 100,
    debounce: 200,
    updateOnResize: true,
    updateOnResizeDown: false,
    updateOnPinchZoom: false,
    onChangeParamOverride: function(width, height, options, element) {
      var optionsHeight = element.attributes.height === undefined ? null : element.attributes.height.value;

      if (optionsHeight !== null)
        options.h = parseInt(optionsHeight)

      return options;
    }
  });
});
{% endhighlight %}

This callback simply grabs the node for the image currently being handled and pulls the height from it if it has been set. It then sets the query parameter `h` to it's value, which is what the Imgix API requires if you wish to set the height on the image.

While we're modifying the image request parameters we can set the `auto: format` parameter which tells Imgix to detect the best image format for the current browser and serve the images in that format. In reality these means you will get WebP images in Chrome and Opera, but otherwise you will get progressive JPEG images.

{% highlight javascript %}
imgix.onready(function() {
  imgix.fluid({
    lazyLoad: true,
    lazyLoadOffsetVertical: 500,
    pixelStep: 100,
    debounce: 200,
    updateOnResize: true,
    updateOnResizeDown: false,
    updateOnPinchZoom: false,
    onChangeParamOverride: function(width, height, options, element) {
      var optionsHeight = element.attributes.height === undefined ? null : element.attributes.height.value;

      if (optionsHeight !== null)
        options.h = parseInt(optionsHeight)

      options.auto = 'format';
      return options;
    }
  });
});
{% endhighlight %}

This is now enough for the main images for any page to be handled by Imgix, however I also use header images for many pages which are actually background images. This allows me to set the size of the container as a percentage of the users screen, and to let the browser control the image size and position to best fill that area.

I had to make some minor modifications to this to allow Imgix to handle the images, which now looks like this:

{% highlight html %}
<div class="image imgix-fluid-bg" data-src="https://danielgroves-net-2.imgix.net/2016-03-web-DSCF6107.jpg"></div>
{% endhighlight %}

This simply sits at the top any page with a header image just inside the `<main>` tag. This also requires a second snippet to initiate the Imgix library for the headers, as I wanted to have different settings for these images:

{% highlight javascript %}
imgix.onready(function() {
  imgix.fluid({
    fluidClass: 'imgix-fluid-bg',
    updateOnResizeDown: true,
    updateOnPinchZoom: true,
    pixelStep: 100,
    autoInsertCSSBestPractices: true
  });
});
{% endhighlight %}

The addition of the `autoInsertCSSBestPractices: true` option allows the Imgix library to automatically inject any CSS it requires to setup the image as a background.

All of these didn't take as long as you might think to do, I spent maybe an hour total setting up Imgix and a few hours preparing my content for the new Origin. The question is, how much of a different has this actually made?

## Testing the results

Let's take a couple of different pages and look at wheat difference it's made in the most popular browser for this website: Google Chrome. This first post has been picked because it has a large range of images and no map embedded – something which would mask some of the benefits gained. This test is using Soar as an example.

First I loaded the page using the old code. This was done with a clean cache in Chrome. The results show a clear improvement — before the DOM content loaded in 474ms, finished  loading in 6.79s and 4.2MB transferred. Now with responsive images we're looking at DOM load of 359ms, finished loading in 1.3s and a mere 785kb of transfer. That's a pretty significant improvement.

{% figure %}
  {% img src: 2016-04-responsive-images/before_soar, wm: false, alt: Before responsive images result for Soar %}
  {% img src: 2016-04-responsive-images/after_soar, wm: false, alt: After responsive images result for Soar %}
  {% figcaption %}Before then after introducing responsive images for Soar.{% endfigcaption %}
{% endfigure %}

Next I tested the Adventures and Photography post listing. This page has a series of small thumbnails. Before introducing Imgix I was manually generating these at roughly the right size, now they're done dynamically. Once again we've seen a significant improvement: just shy of 50% less data.

{% figure %}
  {% img src: 2016-04-responsive-images/before_adventures_photography, wm: false, alt: Before responsive images result for Adventures and Photography %}
  {% img src: 2016-04-responsive-images/after_adventures_photography, wm: false, alt: After responsive images result for Adventures and Photography %}
  {% figcaption %}Before then after introducing responsive images for Adventures and Photography.{% endfigcaption %}
{% endfigure %}

The final page was Wind, Rain and Mountains. In this case we've also got an embedded map to contest with that loads a lot of images that are outside of my control. In this case we saw a total of 5.1MB reduced to 1.5MB. This could be reduced further in the future by lazy loading the mapping iframe as and when it is required.

{% figure %}
  {% img src: 2016-04-responsive-images/before_wind_rain_mountains, wm: false, alt: Before responsive images result for Wind, Rain and Mountains %}
  {% img src: 2016-04-responsive-images/after_wind_rain_mountains, wm: false, alt: After responsive images result for Wind, Rain and Mountains %}
  {% figcaption %}Before then after introducing responsive images for Wind, Rain and Mountains.{% endfigcaption %}
{% endfigure %}

## Summery

For something which only took a few hours to put together, including setting up a new origin location, the improvements seen here are massive. This is seems to be working well so far, but it will be interesting to see how it works in the long term.

I firmly believe this was the right solution _for me_. With more and more content going up on my website regularly, almost all of which is image heavy, pre-generating images would only ever have become more and more of a hindrance. For me performance is becoming more and more of an issue as I slowly work towards a bigger endgame.

If you're serving responsive images on your website please do let me know what solution you've picked. I'd be very interested to hear how you're getting along and if you'd change it in the future.


[optimus]: https://github.com/danielgroves/Optimus
[adventures_photography]: /adventures-photography/
[webp_images]: https://developers.google.com/speed/webp/
