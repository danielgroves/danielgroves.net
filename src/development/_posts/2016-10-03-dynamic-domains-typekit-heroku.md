---
published: true
title: Dynamic Domains with TypeKit and Heroku Review Apps
excerpt:
date: 2016-05-12 07:00
tags: development heroku typekit
---

As part of a recent effort to improve the feedback cycle on this website I decided to move the site onto Heroku. Moving to Herku allows me to take advantage of their [Review Apps][review_apps] to automatically deploy branches to their infrastructure on temporary URLs. Doing this removes the need of technical knowledge and reduces the effort involved for friends, family and co-workers to view and feedback on new features and posts I'm working on.

This feature works well - Heroku is linked to the [GitHub repository][github_repo] for this site and automatically triggers a new deploy on a free Dyno when I submit a pull request. The status of the deployment, as well as the public link, are all shown inline for the PR, and the branch-deployment is automatically destroyed when the branch is closed.

The problem with this setup is TypeKit required domains to be whitelisted, but blocks `*.herokuapp.com` from being whitelisted. To get around this we need to dynamically add the domain when a new review app is deployed, and remove it when destroyed. This allows for applications to be reviewed in a state that is as close as possible to the live environment.

To handle this we must dynamically add domains to the TypeKit whitelist during a server build, and remove it on destruction.

- Need the correct type for full testing
- Makes what those reviewing see closer to production

## How

TypeKit can easily be interacted with via [the API][typekit_api], and a [good third party SDK][ruby_typekit_sdk] is available for Ruby. In order to add and remove easily I wanted the whole process to be based upon the environment. To do this I added a few lines to my [`app.json`][heroku_appjson] file to make the [`HEROKU_APP_NAME`][heroku_app_name] available as an environmental variable, as well as two custom properties: `TYPEKIT_API_AUTH` and `TYPEKIT_KIT_ID`. The env part of my configuration looks like this:

{% highlight json %}
"env": {
  "LANG": {
    "required": true
  },
  "RACK_ENV": {
    "required": true
  },
  "HEROKU_APP_NAME": {
    "required": true
  },
  "TYPEKIT_API_AUTH": {
    "required": true
  },
  "TYPEKIT_KIT_ID": {
    "required": true
  }
}
{% endhighlight %}

These variables will all be required to make the calls into TypeKit. You should set the values for `TYPEKIT_API_AUTH` and `TYPEKIT_KIT_ID` in your staging app as that will be used as a template for your review apps, `HEROKU_APP_NAME` will automatically be set by Heroku when they provision your Dyno. The `HEROKU_APP_NAME` is important as the app name is the subdomain that will be issued for your review app to allow it to be previews, for example `danielgroves-net-pr-1` becomes `danielgroves-net-pr-1.herouapp.com`.

To do the grunt-work of the calls into TypeKit and to verify they were successful I wrote a Ruby class which has two public methods, `add` and `remove`. Neither of them take any arguments; everything that is needed is read directly from the environment. Both methods look almost identical and will do the following:

- Read kit details from TypeKit API
- Modify the domain list, adding or removing the Heroku if required
- Republish the kit so the changes take effect
- Read the kit in and check the domain is (or isn't, as required) in the list

This simple class relies on the [`typekit-client` gem][], and looks like this:

{% highlight ruby %}
require 'typekit'

class TypekitDomain
  @@api_key = ENV['TYPEKIT_API_AUTH']
  @@kit_id = ENV['TYPEKIT_KIT_ID']
  @@app_domain = "#{ENV['HEROKU_APP_NAME']}.herokuapp.com"

  def add
    kit = get_kit
    domains = kit.domains

    unless (domains.include? @@app_domain)
      domains << @@app_domain

      kit.update(domains: domains)
      kit.publish
    end

    domains = get_domains
    abort "Failed to add domain to whitelist" unless domains.include? @@app_domain
  end

  def remove
    kit = get_kit
    domains = kit.domains

    if (domains.include? @@app_domain)
      domains.delete @@app_domain

      kit.update(domains: domains)
      kit.publish
    end

    domains = get_domains
    abort "Failed to remove domain from whitelist" if domains.include? @@app_domain
  end


  private
  def get_kit
    typekit = Typekit::Client.new token: @@api_key
    typekit::Kit.find @@kit_id
  end

  def get_domains
    kit = get_kit
    kit.domains
  end
end
{% endhighlight %}

Now we have a way is easily making the required changes to the kit, we need to automatically invoke it. This can easily be done by adding a couple of simple rake tasks we can have Heroku automatically call on the [`postdeploy`][heroku_postdeploy] and [`pr-predestroy`][heroku_predestroy] scripts. I added two tasks to my Rakefile that look like this:

{% highlight ruby %}
namespace :typekit do
  task :add_domain do
    typekit = TypekitDomain.new
    typekit.add
  end

  task :remove_domain do
    typekit = TypekitDomain.new
    typekit.remove
  end
end
{% endhighlight %}

Calling these is easyily done via the scripts in the `app.json` file:

{% highlight json %}
"scripts": {
  "postdeploy": "bundle exec rake typekit:add_domain",
  "pr-predestroy": "bundle exec rake typekit:remove_domain"
}
{% endhighlight %}

It's worth keeping in mind that the `postdeploy` script will only run on the _first_ deployment of a review app, and subsequent deployments will skip it. For our needs here though, this works perfectly.

- Based on environment
- Call out to Typekit API
- Use build/teardown

## Conclusion

I'm now doing this for this website, and plan to for multiple others. It works well, and doesn't seem to have any negative impacts on deployment. Placing all of the configuration in environmental variables means it's easily adaptable to other use cases, and is perfectly safe to do for open-source projects such as this one, where you really cannot afford to commit any API keys.

With this in mind this website is now being served from Heroku instead of my own server, so keep an eye out for mre details on why and how in the near future.

- Possible other uses
- works well
- Site now on Heroku

[review_apps]: https://devcenter.heroku.com/articles/github-integration-review-apps
[github_repo]: https://github.com/danielgroves/danielgroves.net
[typekit_api]: https://typekit.com/docs/api
[ruby_typekit_sdk]: https://github.com/IvanUkhov/typekit-client
[heroku_appjson]: https://devcenter.heroku.com/articles/app-json-schema
[heroku_postdeploy]: https://devcenter.heroku.com/articles/github-integration-review-apps#the-postdeploy-script
[heroku_predestroy]: https://devcenter.heroku.com/articles/github-integration-review-apps#pr-predestroy-script
[heroku_app_name]: https://devcenter.heroku.com/articles/github-integration-review-apps#heroku_app_name-and-heroku_parent_app_name
