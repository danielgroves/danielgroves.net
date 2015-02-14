---
layout: default
published: true
title: "Jekyll Deployment"
excerpt: Using GitLab CI to automate Jekyll Deployments.

date: 2015-01-19 08:30
---

A while back I wrote about how I deployed my Jekyll based site using a [small bash script triggered by cron](/notebook/2013/10/task-automation/ "Task Automation"). This was a fast solution to develop, but had plenty of room for improvement. During my final year at university I started to research continuous integration and setup my own [GitLab CI](https://about.gitlab.com/gitlab-ci/ "Open Source Continuous Integration") installation to go alongside my [GitLab](https://about.gitlab.com "Open Source Git Repository Management") installation. These integrate perfectly and for the last nine-months or so I've wanted to setup a real deployment system using GitLab CI at the heart.

## Repository Management

In order to understand why I do things in the way explained here a basic understanding of how I manage this site is required. It has two hosted repositories, one in my private GitLab installation and one on GitHub. I only ever interact directly with the version sat in GitLab, and all changes I make (past minor corrections) take place in development branches. When I want something to go live I merge it into the `master` branch.

At CI level I build the site and confirm that any changes do not break the build (I regularly make minor content and front-matter changes without building locally). If the commit is on the `master` branch I then use `rsync` to deploy yet new build into he server. Finally, I add the GitHub remote to the repository and push to GitHub.

What you see on GitHub is the same as what is currently deployed.

## Dependencies

The first stage is to work towards automating everything; dependencies and tasks. The fist thing was to create a `Gemfile` which contains the ruby gems the site is dependent on. To use this we require the `bundler` gem to be already installed on the CI runner as well as the local development machine. My initial `Gemfile` looked something like:

{% highlight ruby %}
source "https://rubygems.org"

gem "jekyll"
gem "redcarpet"
{% endhighlight %}

We can then run `bundle install` to ensure that all gems are installed to the machine.

## Tasks

With dependencies handled we now need some level of task automation. Rake is idea for this, so we'll add the Rake gem to our Gemfile.

{% highlight ruby %}
source "https://rubygems.org"

gem "jekyll"
gem "redcarpet"
gem "rake"
{% endhighlight %}

And then create a basic `Rakefile` locally at the root of the project. The first thing we need to be able to do is do a basic build of the site.

{% highlight ruby %}
task default: %w[build]
$linebreak = "\n\n =========================\n"

task :build do
  clean
  puts $linebreak
  puts "Building for production"
  jekyll "build"
end

def jekyll(args)
  system "jekyll #{args}"
end

def clean
  puts $linebreak
  puts "Cleaning previous builds"
  system "rm -Rf _site/"
end
{% endhighlight %}

Now to build the site as can issue `bundle exec rake build` on the command line. In this basic example we delete any previous build, output saying we're about to build the site, and simply call `jekyll build` on the command line.

In the past for debugging I've found it useful to output the version number of Jekyll which I am building with. We can add this as another task, and have the build task call this before running.

{% highlight ruby %}
task :version do
  jekyll "--version"
end

task :build => :version do
  clean
  puts $linebreak
  puts "Building for production"
  jekyll "build"
end
{% endhighlight %}

If we're not on the master branch we'll want to build all future and draft posts too, to ensure they will build fine when merged into master. This requires a second build task.

{% highlight ruby %}
task :build_all => :version do
  clean
  puts $linebreak
  puts "Building with all future and draft posts"
  jekyll "build --future --drafts"
end
{% endhighlight %}

Finally we need to be able to deploy the site, but only when running against the master branch. We can test for this as GitLab CI creates an environmental variable before running any build tasks called `CI_BUILD_REF_NAME` with the branch name. We will then require the remote to deploy to be passed as a second environmental variable to avoid having to commit any sensitive information into the repository.

{% highlight ruby %}
task :deploy => :build do
  if "#{ENV['CI_BUILD_REF_NAME']}" == "master"
    puts $linebreak
    puts "On master branch, will attempt to deploy"
    system "rsync -avz --omit-dir-times --no-perms --delete _site/ #{ENV['REMOTE']}"

    puts $linebreak
    puts "Attempting to push open Git Repo"
    system "git remote add github git@github.com:danielgroves/danielgroves.net.git"
    system "git reset HEAD --hard"
    system "git checkout master"
    system "git push github master"
  else
    puts $linebreak
    puts "Cannot deploy non-master branch"
  end
end
{% endhighlight %}

What we do here is build the site, then test to see if we're on master. If we are we'll copy the build to the remote using rsync and then add the GitHub remote to the project and push the master branch up to GitHub. If we're not on master we'll simply say that deploying isn't allowed, but we won't use a zero exit code as we don't want the build to fail; we're expecting the reply no to take place if we're not on master.

While writing this I added a couple of extra tasks to save myself typing longer commands when developing locally. The final `Rakefile` should look something like:

{% highlight ruby %}
task default: %w[build]
$linebreak = "\n\n =========================\n"

task :version do
  jekyll "--version"
end

task :watch do
  jekyll "serve --watch --future --drafts"
end

task :serve do
  jekyll "serve"
end

task :build => :version do
  clean
  puts $linebreak
  puts "Building for production"
  jekyll "build"
end

task :build_all => :version do
  clean
  puts $linebreak
  puts "Building with all future and draft posts"
  jekyll "build --future --drafts"
end

task :deploy => :build do
  if "#{ENV['CI_BUILD_REF_NAME']}" == "master"
    puts $linebreak
    puts "On master branch, will attempt to deploy"
    system "rsync -avz --omit-dir-times --no-perms --delete _site/ #{ENV['REMOTE']}"

    puts $linebreak
    puts "Attempting to push open Git Repo"
    system "git remote add github git@github.com:danielgroves/danielgroves.net.git"
    system "git reset HEAD --hard"
    system "git checkout master"
    system "git push github master"
  else
    puts $linebreak
    puts "Cannot deploy non-master branch"
  end
end

def jekyll(args)
  system "jekyll #{args}"
end

def clean
  puts $linebreak
  puts "Cleaning previous builds"
  system "rm -Rf _site/"
end
{% endhighlight %}

## CI Setup

At this point setting up the CI jobs is a trivial task thanks to the dependency and task automation. We have two tasks, one to build and test all future posts and drafts, and a second one to do a production build and try to deploy.

I named the first task "Build and Deploy Production" and used the following script.

{% highlight bash %}
git submodule update --init

bundle install
bundle exec rake deploy REMOTE='user@danielgroves.net:/path/to/www/'
{% endhighlight %}

This will simply ensure we have pulled down any git submodules that are required, ask bundler to install all dependencies and then run the deploy task.

The second job is called "Build Future and Drafts"; this uses the following script.

{% highlight bash %}
git submodule update --init

bundle install
bundle exec rake build_all
{% endhighlight %}

There is nothing we can do to tell GitLab CI to run which task on which branch which is why we needed to test to check which branch we're on earlier in the `Rakefile`.

At this point an issue was found; Jekyll doesn't always fail with a non-zero exit code [when it errors on parsing front-matter](https://github.com/jekyll/jekyll/issues/1907 "GitHub issue for parsing font-matter"). To fix this we need use a particular build of Jekyll, [commit `ea8920`](https://github.com/jekyll/jekyll/commit/ea8920 "Jekyll commit ea8920"). Thankfully this is a trivial task as bundler can handle this with a small modification to our `Gemfile`.

{% highlight ruby %}
source "https://rubygems.org"

gem "jekyll", :git => "https://github.com/jekyll/jekyll.git", :ref => 'ea8920'
gem "redcarpet"
gem "rake"
{% endhighlight %}

## Conclusions

With relatively minimal effort we have developed a simple system which allows us to use automated deployments which are fail-safe, so we won't deploy any build that break by accident. This is a completely transparent process with runs in the background without any user input making deployment a simple task which can be forgotten about.

All of the code in this example can be seen in [the GitHub repository for this site](https://github.com/danielgroves/danielgroves.net "danielgroves.net on GitHub").
