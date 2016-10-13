---
published: true
title: Moving to Heroku
excerpt: Moving a Jekyll website from a VPS to Heroku

date: 2016-10-09 17:45

tags: development heroku vps
---

As someone who is supposed to be a _software_ developer I am spending too much time managing servers and infrastructure and not enough time _building_ things. Every time I’ve looked into switching to a PaaS (Platform as a Service) solution it’s simply been too expensive. Recently Heroku started offering free SSL, reducing the cost of hosting this website with them from $27/mo to just $7/mo.

The reduction in cost perked my interest, and seeing the new [Review Apps][] feature won me overly entirely. To take full advantage of Heroku I needed to make use of the [GitHub integration][], so with this in mind I made sure my GitHub mirror of my GitLab repository was up-to-date and then made the switch.

I chose to make this website the first one I’d move because it is so simple. There’s no moving parts — it’s a Jekyll powered website so it would be a case of building the solution and then serving some static files. I also wasn’t overly bothered about creating a few minutes of downtime as the site isn’t critical in any way.

## The Setup Process

The process is fairly easy – I completed it in just a few hours, some of which was waiting for DNS changes. We’ll start by creating a staging ‘app’ in Heroku and getting a working deployment. Once this is done we’ll use it as a template for our production ‘app’ before configuring the ‘review’ apps. We’ll then use a pull-request driven workflow to finish the setup by adding a routing layer, setting custom headers, and configuring SSL.

Most of this can be completed from the command-line by installing the Heroku client, however of the sake of simplicity I’ll be using the web interface except where the command line makes something significantly easier, or cannot be avoided. You should make sure you have the Heroku client installed[^1] and then running `heroku login` to get everything set-up and ready to go.

## Setup Staging

The first thing to do is login to the Heroku dashboard and create a new app. This will be the staging application, and you should name it appropriately and choose the region closest to you, Europe in my case. As an example I named mine `danielgroves-net-staging`, and you should replace all occurrences of this within this article with _your_ app name.

** Screenshot showing how to setup a new app here **

Once setup navigate to Settings, then [Buildpacks][] and add the _Ruby_ buildpack. This is a set of common build patterns for Ruby applications, and will tell Heroku what to do to build our application.

** Add the Ruby build pack image here **

One of the things the build pack does as part of it’s process is call the command `bundle exec rake assets:precompile`. We’re going to hook into the build process and run the appropriate commands to built the website by implementing this Rake task. This is very simple to do.

If you haven’t already, create a file at the root of your project called `Rakefile`. Now add the `assets:precompile` and `build` tasks, and have it run `jekyll build`.

```
desc "Build the site with the production configuration."
task :build do
     system ("bundle exec jekyll build")
end
''
namespace :assets do
    desc "Rake task that Heroku runs to build static assets by default. "
    task :precompile => :build
end
```

The other vital task is to configure a web server. We’ll use Puma here, which easily installed via bundler. Just add `gem 'puma'` to your Gemfile and then create a new file at the root of your repository called `Procfile` with the following.

```
web: bundle exec puma -t 8:32 -w 3 -p $PORT
```

We also need to configure Puma so it knows what to serve, we do this with a Rack configuration file which should also be at the root of your repository and named `config.ru`. It will use the `rack/jekyll` gem to serve your project, so be sure to add `gem 'rack/jekyll'` to your Gemfile and to run `bundle install`.

```
require 'rack/jekyll'
run Rack::Jekyll.new
```

Now we can do the first deploy of our Jekyll site. To do this go back to Heroku and select the _Deploy_ tab. Part way down this page is a _Connect to GitHub_ button. Click this and follow the instructions to let Heroku enable the GitHub integrations. Once you have done this at the bottom of the _Deploy_ screen is a _Manual Deploy_ option. Select the appropriate branch and then press deploy and Heroku will build and deploy the website.

** screenshot to show website building here **

Once that is complete you can select the _Open app_ button at the top of your screen to view the site on the heroku staging domain. Assuming everything goes to plan here we’re ready to create our _pipeline_ which will contain the end–to–end process for your repository.

## Setup Pipeline

A [pipeline][] is a container on Heroku that keeps all of your apps for a codebase together. It’s best phrased in the Heroku documentation:

> A pipeline is a group of Heroku apps that share the same codebase. Apps in a pipeline are grouped into “review”, “development”, “staging”, and “production” stages representing different deployment steps in a continuous delivery workflow. A code change will typically be deployed first to a pull request, which automatically creates a review app, then merged into master which is automatically deployed to staging for further testing before promotion to production where the new feature will be available to end users of the app.

We will create a pipeline via the web interface — adding our staging app at the same time — before switching to the command-line to clone our staging app as a production app.

Start by loading your staging app and heading to the _Deploy_ tab. Right at the top there’s a button labelled _New Pipeline_, press this button and then press the new _Create Pipeline_ button. A new screen will load showing your existing app in the _Staging_ column. Now we’ll use our working staging application to create a production application via the command line interface.

`heroku fork --from [your-app-name]-staging --to [your-app-name]-production --region eu`

Heroku is intelligent enough to work out that this is a new production app based on the name ending with “production”.

** screenshot of set-up pipeline here**

The next step is to setup the review apps, which will automatically deploy when a pull-request is created or updated.

## Setup Review Apps

Reviews Apps are a powerful feature from Heroku which will deploy a new version of your app for each pull-request you have open. This makes reviewing colleagues contributions to your projects much easier as you already have a fresh deployment of each change to review for providing feedback.

In order to enable review apps you need to have a `app.json` file committed to the _master_ branch of your project. The `app.json` tells Heroku what dynos will be required, and what build-packs will be required in order to deploy your application.

The JSON is pretty self-explanatory so far, but you can [review the schema documentation][app_json_schema] if you want to know more about a particular field.

```
{
  "name": "danielgroves.net",
  "description": "The Jekyll site that powers danielgroves.net",
  "website": "https://danielgroves.net",
  "repository": "https://github.com/danielgroves/danielgroves.net",
  "formation": {
    "web": {
      "quantity": 1
    }
  },
  "addons": [
  ],
  "buildpacks": [
    {
      "url": "heroku/ruby"
    }
  ]
}
```

Once you’ve committed a `app.json` file, make sure you merge it into your master branch – if you didn’t just commit it there to start with – and then head back over to Heroku and press the _Enable Review Apps_ button on the far left. I just left the default options selected.

**screenshot of setup review apps here**

We’ll now create a router to handle URL redirects, and we’ll use a review application to test the new functionality.

## Create a Router

To make use of review apps for testing our new functionality we need to work on a branch, such as `heroku-router`. Once you’ve created your branch we’ll need to pull in a few more Gems to save reinventing the wheel with our router. Add `gem rack-rewrite', '~> 1.5.0'` to your Gemfile, and run `bundle install` like normal. Now we can define rules using a mixture of string matches and regular expressions, for example I added the following to the top of my `config.ru` file.

```
require 'rack/rewrite'
use Rack::Rewrite do
  r301 '/adventures-photography/2014/11/JOGLE-2/', '/adventures-photography/2014/12/JOGLE-2/$&'
  r301 '/adventures-photography/2014/10/JOGLE/', '/adventures-photography/2014/11/JOGLE/'
  r301 %r{^/([0-9]{4})/([0-9]{2})}, '/notebook'
  r301 %r{^/notebook/page/(.*)}, '/notebook/$1'
  r301 %r{^/page/(.*)}, '/notebook/$1'
  r301 '/tag', '/notebook'
  r301 '/category', '/notebook'
  r301 %r{^/camera-roll/(.*)$}, '/adventures-photography/$1'
  r301 '/camera-roll', '/adventures-photography'
  r301 %r{^/feed/camera-roll/(.*)}, '/feed/adventures-photography/$1'
  r301 '/feed/camera-roll', '/feed/adventures-photography/'
end
```

These rules are ported from my old NGINX configuration, and redirect old application URLs from past versions of this website. You can test your rules locally by running `rackup` in the same directory as your `config.ru` file – just be sure to build your site first.

**screenshot of backup running here**

Once you’re happy with your rules commit and push them to GitHub, then open a PR for the branch. You’ll notice Heroku immediately updates the PR to tell you a deploy is pending, and a few minutes later this gets replaced with a _View deployment_ button. Get your friends or colleagues to review your pull request, and once you’re all in agreement that the rules are right merge the PR and watch as Heroku automatically deletes the Review App. When you’re ready deploy it to staging for any final testing before you hit the Promote button in the Heroku admin and it’ll copy the application to production.

**screenshot showing Heroku integration here**

Now we’ve got our workflow dialled, but we do need to change some headers that are being used as currently we cannot add any caching or security headers.

## Implement Custom Headers

Unfortunately the `Rack-Jekyll` gem does _not_ support adding custom headers, so we’re going to swap it out for `Rack-Contrib` which has a module for serving static files and does allow us to set our own headers. Add `gem 'rack-contrib', '~> 1.4'` to your Gemfile, and then replace `require 'rack/jekyll'` and `run Rack::Jekyll.new` with `require 'rack/contrib/try_static'` and the following respectively.

```
use Rack::TryStatic,
  urls: %w[/],
  root: 'build',
  try: ['.html', 'index.html', '/index.html'],
  header_rules: [
    [:all, {
      'Strict-Transport-Security' => 'max-age=31536000; preload',
      'X-Xss-Protection' => '1; mode=block',
      'X-Content-Type-Options' => 'nosniff',
      'X-Frame-Options' => 'DENY',
      'Content-Security-Policy' => "default-src 'self'; font-src data: https://fonts.typekit.net; img-src 'self' https://danielgroves-net.imgix.net https://danielgroves-net-2.imgix.net https://d1238u3jnb0njy.cloudfront.net https://p.typekit.net https://www.google-analytics.com; style-src 'self' 'unsafe-inline' https://d1238u3jnb0njy.cloudfront.net https://use.typekit.net; script-src 'self' 'unsafe-inline' https://d1238u3jnb0njy.cloudfront.net https://use.typekit.net https://www.google-analytics.com; child-src https://a.tiles.mapbox.com; frame-src https://a.tiles.mapbox.com;"
    }],
    [['html'], { 'Content-Type' => 'text/html; charset=utf-8'}],
    [['css'], { 'Content-Type' => 'text/css'}],
    [['js'], { 'Content-Type' => 'text/javascript' }],
    [['png'], { 'Content-Type' => 'image/png' }],
    [['gif'], { 'Content-Type' => 'image/gif' }],
    [['jpeg'], { 'Content-Type' => 'image/jpeg' }],
    [['jpg'], { 'Content-Type' => 'image/jpeg' }],
    [['zip'], { 'Content-Type' => 'application/zip' }],
    [['pdf'], { 'Content-Type' => 'application/pdf' }],
    [['/assets'], { 'Cache-Control' => 'public', 'Vary' => 'Accept-Encoding' }]
  ]

  run lambda { |env|
    [404, { 'Content-Type' => 'text/html' }, File.open('build/404.html', File::RDONLY)]
  }
```

You may not want _all_ of these headers in your project depending on what the project is, what it’s requirements are or even how lazy you’re feeling. At the very least you will have to remove or update the `Content-Security-Policy` to match your environment and ensure that the `root` points to your build–output directory.

Essentially this configuration is telling our web server to load the `Rack::TryStatic` module, and giving it a configuration with which to attempt to serve files for each URL. It's searching for an HTML file named after our URL path, and then checking for any index files incase it’s a directory (as it often is). Once its found a file to serve we’re applying our standard headers to the response, and then anything for that _specific_ file extension. These rules can cover any part of the file-path (the headers are applied in-order of the configuration), which allows us to grab everything in the `/assets` directory to tweak the headers in-bulk.

Finally, if it doesn't find a file we’re serving the `404.html` to ensure the user always gets some kind of response.

## SSL in Production

Cost was a concern to me when switching to Heroku, and so I decided not to pay for an SSL certificate, but to use a Let’s Encrypt certificate instead. Whereas most certificate authorities will send an email to `admin@domain.com` to validate that the requester is the domain owner Let’s Encrypt works slightly differently. Instead of sending an email is uses [Automatic Certificate Management Environment (ACME)][acme] checks instead. This is actually a good thing as the validation process is as simple as serving a file at a given URL.

To generate our certificate we will need to make DNS changes, run Certbot, and modify our Heroku router to serve the file given to us by Certbot at the correct URL. To make this process as easy as possible we’re going to serve the ACME validation based on an environmental variable so that we can change the code for renewing the certificate in the future _without_ having to do a deployment.

Start by adding `gem 'acme_challenge'` to your Gemfile, running `bundle install` and then adding the following to the **top** of your `configu.ru`.  It’s important this goes first so no other routing options available in the `config.ru` get an opportunity to respond with a 404 error.

```
require 'acme_challenge'
''
use AcmeChallenge, ENV['ACME_CHALLENGE'] if ENV['ACME_CHALLENGE']
```

Now the web server will pass the local environment variable `ACME_CHALLENGE` to the ACME module when each request comes in, but _only_ if it’s set so this won’t cause any staging, review or development issues. Before we can continue this will need to be deployed to your **production** app.

The `ACME_CHALLENGE` take the form of a key that is provided by the Certbot process. It will look something like this: `DR3HsHaR7ddga8StA4GghBGkIf02JDI5Nad3H_PdR3.pR84GiE5MNgksEKLD34dXoPLw-jglei40m2HKt9D3-1`. This key is uniquely generated and needs to be served at `/.well-known/acme/` followed by everything before the ‘.’. The entire key needs to be served by the file. Because the URL is built on this pattern we can provide the `AcmeChallenge` module with the full key, and it will take care of serving it on the correct URL.

To continue setting up SSL you will need to follow the Heroic instructions on setting up your domain to point to the Heroku servers. This process will result in a couple of minutes where you will have no SSL while we generate and upload the certificate. You can find these instructions in your production app at _Settings_ and then _Domains_.

Download and install Certbot[^2], and then run `sudo certbot certonly --manual` to start the SSL Certificate generation process. Follow the wizard answering the questions as you’re prompted. Once you’ve answered the questions you’ll get a prompt like this:

' ```
Make sure your web server displays the following content at                                                      
http://your-domain-name/.well-known/acme-challenge/DR3HsHaR7ddga8StA4GghBGkIf02JDI5Nad3H_PdR3 before continuing:
DR3HsHaR7ddga8StA4GghBGkIf02JDI5Nad3H_PdR3.pR84GiE5MNgksEKLD34dXoPLw-jglei40m2HKt9D3-1
```

Take the key from the bottom and set it as an environment variable in Heroku by navigation to your production app then _Settings_ and clicking the _Reveal Config Vars_ button. Then in the last row set `ACME_CHALLENGE` followed by your key, and then press _Add_. Hit enter in the terminal window and it will verify your your ACME key, and save the certificates to your local disk.

The easiest way to add the new certificates to your website is to use the command line utility to upload them, which only takes a single command. It will activate SSL at the same time, and respond by giving you the DNS entries you need to set for your application to use SSL.  `sudo heroku certs:add /etc/letsencrypt/live/your-domain-name/fullchain.pem /etc/letsencrypt/live/your-domain-name/privkey.pem --app your-production-app-name`

Remember to replace `your-domain-name` with, well, your domain name and `your-production-app-name` with your production app name. Now you’re almost there.

Heroku does not enforce SSL, but we can easily do this by adding a few lines to our `config.ru` file to redirect http to https in production. Add the following just after `use Rack::Rewrite do`:

```  
if ENV['RACK_ENV'] == 'production'
 r301 %r{.*}, 'https://danielgroves.net$&', :scheme => 'http'
end
```

Make sure to update the domain before you commit, and once you’ve deployed the change to production you should find yourself being redirected to https every-time you attempt to access the site over http.

## Conclusions

Although this process sounds quite complicated on the surface, it’s really not hard to understand. If your app follows the principles of a [12-factor application][12_factor] then you’re already most of the way there. So far I’ve been enjoying not having to worry about what’ll happen if there’s a big spike in traffic, or something breaks on a server – scaling is easy, and infrastructure management isn't my problem anymore.

There’s a few things I’d like to improve and write about later on: currently TypeKit does not work with review apps as you can’t whitelist `*.heroku.com`, I have to manually update my certificates with Let’s Encrypt every three months, and I’d like to have some automated testing for the web server configuration.

I’ve already got a pretty good idea of how to solve these first two, and I’m sure I’ll be able to find a way to write the tests I’d like with Rspec, or something similar in the near future.

So far I really can’t complain, this works really quite well.

[^1]: You can do this by running `brew install heroku` on Mac OS. Instructions are available on the Heroku website for other operating systems: [https://devcenter.heroku.com/articles/heroku-command-line#download-and-install]
[^2]: On Mac you can run `brew install certbot` if you have Homebrew installed, otherwise refer to the documentation: https://certbot.eff.org. Select "None of the Above" as your webserver and then the relevant operating system.

[Review Apps]: https://devcenter.heroku.com/articles/github-integration-review-apps "Heroku Review Apps"
[GitHub integration]: https://devcenter.heroku.com/articles/github-integration "Heroku GitHub Integration"
[Buildpacks]: https://devcenter.heroku.com/articles/buildpacks "Heroku Buildpacks"
[pipeline]: https://devcenter.heroku.com/articles/pipelines "Heroku Pipelines"
[app_json_schema]: https://devcenter.heroku.com/articles/app-json-schema "Heroku app.json schema"
[acme]: https://github.com/letsencrypt/acme-spec/ "ACME Spec on GitHub"
[12_factor]: https://12factor.net "The Twelve-Factor App"
