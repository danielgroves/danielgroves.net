---
layout: blog
published: true
title: Picking Up GIT
excerpt: An introduction of using the Git version control system, aimed at those who are just starting out. 

date: 2012-02-15 00:28:23.000000000 +00:00
---
Around a year ago [Nick Charlton](http://nickcharlton.net/ "Nick Charlton") ([@nickcharlton](http://twitter.com/nickcharlton "Nick Charlton on Twitter")) did a [talk on Git](http://nickcharlton.net/resources/guide_to_git.pdf "Nick Charlton's Guide to Git") in [Termisoc](http://termisoc.org "Termisoc"), this opened my eyes to a technology I had heard of but never actually used. [GIT](http://git-scm.com/ "GIT-SCM") is extremely useful when working on group projects, or when working on larger projects alone, although it does require the adoption of a very modular approach to working.

Anyhow, before I start drifting off topic, this is intended to extend from what Nick taught me, although it will cover many of the same things. Nicks guide got me off to a good start, but this article is intended as a fast crash-course in using git for those I am completing group work with.

### Setting up Shop

I won't cover the install of Git here, it's easy enough to find guides on this all over the internet. A good place to start would be with the official [GitHub](http://github.com "GitHub Website") guides; which covers [Windows](http://help.github.com/win-set-up-git/ "Setup Git on Windows"), [Mac OS X](http://help.github.com/mac-set-up-git/ "Install Git on Mac OS X"), and [Linux](http://help.github.com/linux-set-up-git/ "Install Git on Linux"). Once installed your all good to go.

Where I am actually going to start with this guide is with actually using Git. For this guide the setting up shop will cover navigating to a repository (repo) via the command line, creating a repo, cloning/forking a repo, and adding a remote to a repository.

#### Navigating to a Repo

Navigating to via the command line is easy enough, and only two command are required. Firstly you'll need to fire up a Terminal window on Unix, or Git Bash on Windows - this was explained in the install links above.

The first command that will be required is <tt>cd</tt>. <tt>cd</tt> stands for Change Directory, so that exactly what we'll be using it for. Using the <tt>cd</tt> command really is very simple. Say you want to go to /Users/danielsgroves/Documents, to do it you would simply do as follows.

```cd /Users/danielsgroves/Documents```

The second command that can used used is the <tt>ls</tt> command, list. You can use this in two ways, firstly you can type <tt>ls</tt> followed by the directory you would like to list, or you could just type <tt>ls</tt> to list to contents of the current directory. Ignore the <tt>1></tt> and <tt>2></tt> in the examples below.

```1> ls
2> ls Documents```

Presuming we are in the <tt>/Users/danielsgroves/</tt> directory the first command would simple have listed all of the folders in danielsgroves/, but the second would have listed the contents of the danielsgroves/Documents directory. These two commands should be enough to allow you to navigate to your Git repositories.

#### Starting a Repository

Starting your own Git repository is very easy. Create a folder where you want to store it and navigate to this location using the Terminal (or Git Bash on Windows). To start your repo simply run the following command.

<pre>git init</pre>

This will initiate an empty Git repository, creating the <tt>.git</tt> folder which contains all the repository specific settings and a record of each file and it's history.

Of course this is only the first half, to use this repo with other people you will need to add a remoterepositorytosynchronisewith. Remote repositories will be covered in detail later in this article.

#### Forking and Cloning a Repository

Forking arepositoryas almostthe same as copying one, with a few subtledifferences. When you fork arepositoryyou not only copy it, but it's entire history as well. Further to this you can make changes and aftercommittingthem issue a pull-request to the owner of the originalrepositoryso that they thenhavethe option to merge your changes with the mainrepository.

Forking is easy to do, as shown below on every repository on GitHub you can simply hit the fork button, this duplicates the original into your own account.

[<img class="size-medium wp-image-702" title="Forking On GitHub" src="http://danielgroves.net/wp-content/uploads/2012/02/ForkingOnGitHub-550x27.png" alt="Forking On GitHub" width="550" height="27" />](http://danielgroves.net/wp-content/uploads/2012/02/ForkingOnGitHub.png)

Once you have forked a repository it's not much use left on the GitHub server. You could download the contents and then setup your repositorylikenormal, but would it not be easier to let git do all the hard work for you? This is where the <tt>clone</tt> command comes in. To use the clone and simply navigate to the directory in which you would like to store your git repository and run <tt>git clone</tt> followed by the contents of the SSH box present on yourrepositoryon GitHub.

[<img class="size-medium wp-image-706" title="Cloning URL found on GitHub" src="http://danielgroves.net/wp-content/uploads/2012/02/CloningURL-550x120.png" alt="Cloning URL found on GitHub" width="550" height="120" />](http://danielgroves.net/wp-content/uploads/2012/02/CloningURL.png)

An example of doing this follows.

<pre>git clonegit@github.com:danielgroves/Example-Repository.git</pre>

This command will clone the repository, andautomaticallycreate a remote for you called "origin", you can see this by running <tt>git remote</tt>.

#### Adding a Remote

A remote needs to be added in order to push your repository allowing you to share your code with other collaborators. This is pretty simple to do, and is easiest to do with a GitHub repository. GitHub is free for any number of [open source](http://en.wikipedia.org/wiki/Open_source "Open Source on Wikipedia") repositories. If you are a student, however, you can [apply for a free micro account](https://github.com/edu "Contact GitHub for a free Student Micro account")..

For this example I will be using an open GitHub repository, who actually provide all instructions on their website for getting set up when you create a newrepository. This can also be used on a private server with git installed ((To initiate a new repository on a server you will need to use <tt>git init --bare</tt> instead of <tt>git init</tt>)).

The syntax for setting up your remote is as follows.

<pre>git remote add origin [username]@[serverAddress]:[location/of/respositoy]</pre>

So for my [example repository](https://github.com/danielgroves/Example-Repository "An example Git repository on GitHub") I have on GitHub I would use this.

<pre>git remote add origin git@github.com:danielgroves/Example-Repository.git</pre>

Git automatically identifies if you have access to a repository based on the RSA key you use to login to the server.

### Operating Git

Now your all set up you need to know how to use the day to day commands that you will need to operate Git.

#### Checking the Status

When using Git the status of yourrepositorieswill frequently change, new files will be added and commits will be made, but how do we check exactly where we are?

The <tt>git status</tt> command will tell you which files git is currently tracking (in yourrepository), which are untracked (in the repository directory, but not being tracked) and which tracked fileshavebeen editing since the last commit.

To use this command simply run <tt>git status</tt>.

#### Adding and Editing

Adding and editing files is a simple enough process within Git. Firstly, you just create files like you normally would, once you have created these files you simply run the following command from within your Git repository.

<pre>git add .</pre>

This command will add all files within the folder to the repository, in the situation you do not want to add all files you can specify which file, or files, to add as follows.

<pre>git add readme.mdown</pre>

This command will just add the file "readme.mdown" to the repository.

#### Committing Changes

When working with Git it is important to work in a modular fashion. You complete one task and then proceed to commit your changes before continuing.

From past experience I can say now that it is best to close <em>all</em> open files that sit within a git repository before continuing. Committing changes is pretty simple, you start by making sure all of the files you have been working with are in your repository. To do this we simply use the <tt>git status</tt> command. This command will show tracked and untracked files in the format below.

{% highlight bash %}
Daniels-MacBook:Example danielsgroves$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached ..." to unstage)
#
#	new file:   index.html
#	new file:   main.css
#	new file:   readme.mdown
#
# Untracked files:
#   (use "git add ..." to include in what will be committed)
#
#	mobile.css
#	mobile.js</pre>
{% endhighlight %}

As you can see I haven't added the files mobile.css and mobile.js to my repository, so in order to do this I simply use the <tt>git add</tt> command as detailed in the section above.

Now I can use use the <tt>commit</tt> command to make the changes, this is used as follows.

{% highlight bash %}
git commit -am "Some message about what has been done here"
{% endhighlight %}

This will then return a message along these lines. Files changed, Inserts and Deletions are all blank in this case as I have not populated any of these files with any content for the sake of this example.

{% highlight bash %}
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 mobile.css
 create mode 100644 mobile.js
{% endhighlight %}

#### Pushing Changes

Pushing changes is pretty easy, but in order to do this you will require a 'remote'. If you created a new repository on your computer then you'll need to follow the steps in the 'Adding a Remote' section above.

Once you have added your remote pushing your latest commit is pretty easy. In order to push simply use the following command.

{% highlight bash %}
git push origin master
{% endhighlight %}

The syntax it derived in the following way; first you tell git to use the push command (<tt>git push</tt>) and then tell it which remote to use (<tt>origin</tt>) followed by the branch to push (<tt>master</tt>).

Once you have run the command you should get something like this appear.

{% highlight bash %}
Daniels-MacBook:Example danielsgroves$ git push origin master
Counting objects: 3, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 291 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
To git@github.com:danielgroves/Example-Repository.git
 * [new branch]      master -> master
{% endhighlight %}

The screenshot below show the repository after the initial push, as you can see it shows who last edited each file and the last commit message the is associated with each file or directory.

[<img class="size-medium wp-image-691" title="Repository After Initial Git Push" src="http://danielgroves.net/wp-content/uploads/2012/02/RespositoyAfterInitaGitPush-550x362.png" alt="Repository After Initial Git Push" width="550" height="362" />](http://danielgroves.net/wp-content/uploads/2012/02/RespositoyAfterInitaGitPush.png)

#### Pulling Changes

For this final section of the article I have logged into the GitHub website to make some changes to one of the files, allowing me to demonstrate how a pull works.

Pulling works in exactly the same way as pushing, except we use <tt>pull</tt> instead of <tt>push</tt>. Here an example:

{% highlight bash %}
git pull origin master
{% endhighlight %}

So it's pretty simple, eh? This command will bring up a response that tells your what has changed, here's mine after I added four lines to the file <tt>main.css</tt>.

{% highlight bash %}
Daniels-MacBook:Example danielsgroves$ git pull origin master
remote: Counting objects: 5, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From github.com:danielgroves/Example-Repository
 * branch            master     -> FETCH_HEAD
Updating d9dc5db..9abccfb
Fast-forward
 main.css |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)
{% endhighlight %}
 
### Final Note

When working in groups it is common for suchoccurrencesas two different people editing the same file, resulting in a merge beingnecessary. In this event I would suggest starting by looking through the official [GitHub guide to git](http://help.github.com/remotes/ "Managing remotes on GitHub help") before searching Google if the information doesn't help in your situation.
