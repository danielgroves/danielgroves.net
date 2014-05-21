---
layout: blog
published: true
title: Development Environments with Vagrant and Ansible
date: 2014-05-19 21:00
excerpt: "Looking at Vagrant and Ansible as a development environment solution"
---

[Vagrant](http://www.vagrantup.com "Configurable, cross-platform, development environments") is one of those technologies which I once didn't think I needed, but after giving it a go it quickly became an indispensable part of my daily workflow. Without it working on [Server Observer](https://serverapp.io "Simple and Reliable Server Monitoring") would have been much more difficult. The same can easily be applied to many other projects I have worked on as part of my degree.

Vagrant itself is only *part* of the solution, it handles the generation and basic imaging of virtual machines isolated development environments. However, Vagrant doesn't handle the provisioning of these virtual machines. It's still up to us to handling the installation and configuration of the packages we require to work. Thank-fully, Vagrant is easily integrates with existing provisioners including [Chef](http://www.getchef.com "IT Automation"), [Puppet](http://puppetlabs.com "Automated IT Ops") and my provisioner of choice *[Ansible](http://www.ansible.com/home "Simple IT Automation")*.

Once a virtual machine has been generated and a provisioner has been developed it is suddenly very fast to start a development environment on a brand-new computer without having to worry about finding, installing, and configuring multiple project dependencies. Any developer can pickup a project and start working on it with little manual work, in the same environment as everyone else, using their favourite text-editor on their local computer.

This article will take you through the stages of setting up a Vagrant configuration for a new virtual machine, and how to provision this with software using two custom Ansible playbooks. This will be a very hands-on tutorial where I'd recommend trying things for yourself. It is backed by a [repository on GitHub](https://github.com/danielgroves/Vagrant-Tutorial "Vagrant Tutorial on GitHub") with a complete copy of all of the resources used in this tutorial.

In this tutorial we'll create a Django development environment, using a Postgresql backend. Despite this, this tutorial can easily be adapted for other setups, such as the Nginx/MySQL/PHP-FPM setup in the [php branch](https://github.com/danielgroves/Vagrant-Tutorial/tree/php "Nginx, PHP and MySQL Vagrant + Ansible setup").

### Preparation

If you haven't used the Terminal before on your computer, I would suggest you [familiarise yourself with the basics](http://mac.appstorm.net/how-to/utilities-how-to/how-to-use-terminal-the-basics/ "Mac AppStorm Terminal Tutorial"). I will not be giving you a step-by-step of every command you need to run, so some knowledge will be required for navigating the file system on your platform. What commands are given here should be the same for Mac and Linux.

Make sure you've [installed the latest version of Vagrant for your platform](http://www.vagrantup.com/downloads.html "Download Vagrant") (version 1.5.4 at time of writing), as well as [Ansible](http://docs.ansible.com/intro_installation.html "Install Ansible") (version 1.6.1 at time of writing). If you don't already use it you'll also need to install [Virtualbox](https://www.virtualbox.org "Oracle Virtualbox"), although it is possible to use Vagrant with [VMware Fusion or Hyper-V](http://docs.vagrantup.com/v2/providers/index.html "Vagrant Providers"). Once this is done we're ready to start building our first development environment.

Vagrant is designed to be committed directly into your projects source control, along with any provisioners used. This is certainly something that is advised, as it makes the use of the environment as simple as possible, and also helps to document what the system dependencies are and when they change. Vagrant will create some files which do not want to commit though, just as the use of virtualenv later in this tutorial will. The following `.gitignore` file will stop any of these files from being committed by accident.

```
# Vagrant
.vagrant/

# Python
bin/
build/
include/
lib/
local/
.pyc
```

### Getting Started

Create a directory on you local file system to work from and navigate into this from the terminal. Feel free to initiate some version control software within the directory, before running `vagrant init`. This will generate a basic configuration file for us to work from, including some extensive commenting which should help you understand what is going on. For this use case the vast majority of this is not needed, so we'll remove this once we've gained a basic understanding of what is required.

Vagrant doesn't use the standard images most operating system distributors provide. Instead it uses a 'vagrant box', which will contain multiple pre-configured packages as well as the operating system. Anyone can generate a box, and [Vagrant Cloud](https://vagrantcloud.com/discover/featured "Featured Vagrant Boxes") already has many to choose from with various pre-isntalled packages. I tend to work from a standard Ubuntu Precise 64 box, as this is the operating system that most of my servers run. To make use of this, we'll set config.vm.box to '`hasicorp/precise64`'.

While we're adding this to the configuration we'll forward a port from out local computer to the Python development server and configure a shared folder which will allow us to work on the code-base on our local computer and have Vagrant synchronise changes into the development environment. Change your Vagrant file as follows:

{% highlight ruby %}
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "hashicorp/precise64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./app", "/var/www/django-app"
end
{% endhighlight %}

You'll notice that the `config.vm.synced_folder` line maps `./app` on our local filesystem to `/var/www/django-app` on the remote file-system. You'll need to make the `./app` directory within the same directory as your `Vagrantfile` now, or adjust this path to suit.

On the command line, run `vagrant up`. At this point Vagrant will download the Ubuntu box if it isn't already on your system, make a clone for the specific virtual machine, and boot the virtual machine with the given configuration. If needed it is possible to [change the default emulated hardware](http://docs.vagrantup.com/v2/virtualbox/configuration.html "Hardware Requirements") (default of 512MB memory and a single-core CPU) or have [one Vagrantfile launch multiple virtual machines](http://docs.vagrantup.com/v2/multi-machine/index.html "Vagrant multi-machine support").

### Provisioning Vagrant

At this point we have a development virtual machine, but it lacks the dependencies of out project; this is where the provisioner comes in. In order to get started we need to set-out a basic directory structure contains the files and folders required by Ansible. Initially, this may appear to be overkill but getting everything organised now makes life easier at a later date. We can use the terminal to take a few shortcuts and quickly build the required directory structure.

```
mkdir -p provision/{setup,deploy}/{tasks,vars,handlers}
touch provision/{setup,deploy}/{tasks,vars,handlers}/main.yml
touch provision/vagrant.yml
```

The resulting file-structure should be as follows:

```
app/
provision/
    setup/
        tasks/
            main.yml
        vars/
            main.yml
        handlers/
            main.yml
    deploy/
        tasks/
            main.yml
        vars/
            main.yml
        handlers/
            main.yml
    vagrant.yml
Vagrantfile
.gitignore
```

The idea here is to spilt the Ansible configuration up into multiple playbooks to help keep everything organised and as reusable as possible. The setup directory will have the configuration for the operating system, while the deploy will contain everything required for the virtualenv.

Now, let's tell Vagrant about the provisioners. Add the following just inside the closing `end` statement in the `Vagrantfile`.

{% highlight ruby %}
# Install required software, dependencies and configurations on the
# virtual machine using a provisioner.
config.vm.provision "ansible" do |ansible|
  ansible.playbook = "provision/vagrant.yml"
end
{% endhighlight %}

Then, add the following to `provision/vagrant.yml`:

```
- hosts: all
  roles:
      - setup
      - deploy
```

Now, when a new virtual machine is started with Vagrant it will automatically run the `vagrant.yml` with Ansible, which will run each of the playbooks in turn.

#### Installing Applications

This section will focus on the *setup* playbook. The first thing we need to do is install the system dependencies we require. Add the following to `provision/setup/tasks/main.yml`:

{% highlight yaml %}
{% raw %}
- name: Install packages
  sudo: yes
  apt: pkg={{ item }} state=installed update_cache=yes
  with_items:
      # Database
      - postgresql
      - libpq-dev # Required for Ansible to interact with postgres
      - python-psycopg2 # Required for Ansible to interact with postgres

      # Python Dev
      - python-dev
      - python-setuptools
      - python-virtualenv
{% endraw %}
{% endhighlight %}


This will update the package cache with `apt`, and then ensure each of the programs are installed alongside their dependencies. You'll notice two dependencies have a comment next to them detailing they're required by Ansible. These two programs allow Ansible to interact directly with Postgresql allowing us to automate its setup.

Earlier on we booted our virtual machine, but it was not provisioned as this hadn't been developed at the time. Rather than throwing away and rebuilding the virtual machine, we can force vagrant to provision the virtual machine by running `vagrant provision`. The final lines of the output should look like this:

```
PLAY RECAP ********************************************************************
default                    : ok=2    changed=1    unreachable=0    failed=0
```

#### Configuring PostgreSQL

At this point we're making good progress, however we need to configure Postgresql so that our Django project can use it. The first thing that needs doing is the authentication configuration so local users can use password authentication. To do this a file called `pg_hba.conf` needs replacing. I will not explain this in any detail here, however the file needed is in the GitHub repository. [Download a copy](https://github.com/danielgroves/Vagrant-Tutorial/blob/master/provision/setup/files/pg_hba.conf "Postgres authentication configuration on GitHub") and add a '`files`' directory within the setup playbook and place the file in there, named `pg_hba.conf`.

Add the following to the `provision/setup/tasks/main.yml` to copy the new configuration onto the server.

{% highlight yaml %}
{% raw %}
- name: Allow password authentication for local socket users
  sudo: yes
  copy: src=pg_hba.conf dest=/etc/postgresql/9.1/main/pg_hba.conf force=yes
  notify:
      - Restart Postgres
{% endraw %}
{% endhighlight %}

You'll notice this statements ends with a `notify` action. This calls a handler with the given name in the event that the task changes anything on the system. In this case should the `pg_hba.conf` file change, it'll restart Postgresql to load the new configuration. We do need to write this handler though, so add the following to `provision/setup/handlers/main.yml`.

{% highlight yaml %}
- name: Restart Postgres
  sudo: yes
  service: name=postgresql state=restarted
{% endhighlight %}

Now we have reconfigured postgres to allow local user to login we need to create a user and a database. First, we'll add some variables which contains the details we want to use for the new user. Add the following to `provision/setup/vars/main.yml`.

{% highlight yaml %}
db_name: django_app
db_user: django
db_password: sdjgh34iutwefhfgbqkj3
{% endhighlight %}

Now, we can use the Ansible postgres module to configure a user and a database within Postresqsl. Add the following to `provision/setup/tasks/main.yml`.

{% highlight yaml %}
{% raw %}
- name: Create Database
  sudo: yes
  sudo_user: postgres
  postgresql_db: name={{ db_name }}

- name: Create User
  sudo: yes
  sudo_user: postgres
  postgresql_user: name={{ db_user }} password={{ db_password }} state=present role_attr_flags=NOSUPERUSER,CREATEDB

- name: Provide user with DB permissions
  sudo: yes
  sudo_user: postgres
  postgresql_user: user={{ db_user }} db={{ db_name }} priv=ALL
{% endraw %}
{% endhighlight %}

The `sudo_user` lines tell Ansible what user to run a command as, and since Postgresql will only allow users to login from the `postgres` account by default we tell Ansible to run the commands as this user.

With this section complete we have now successfully provisioned a virtual machine with all of the system dependencies for the project. To force vagrant to re-provision the virtual machine and so load the latest changes run `vagrant provision`.

#### Working with Virtualenv

Now we're making good progress, but it's time to move onto provisioning the software deployment dependencies. From here on we'll be working with the `deploy` playbook. The first thing to consider is we'll be using pip to install a series of python modules within a playbook. To do this we need a requirements file which will be passed to pip. Let's install the latest versions on Django and South, as well as psycopg2 so that Django can talk to the postgres database. Create a file called `requirements.txt` within the app directory, and add the following:

```
Django
South
psycopg2
```

Now, we'll tell Ansible to create a virtualenv and then to install the required modules. Add the following to `provision/deploy/tasks/main.yml`.

{% highlight yaml %}
{% raw %}
- name: Setup Virtualenv
  pip: virtualenv={{ virtualenv_path }} requirements={{ virtualenv_path }}/requirements.txt
{% endraw %}
{% endhighlight %}

You'll notice the use of the `virtualenv_path` variable, let's add this in the `provision/deploy/vars/main.yml` file.

{% highlight yaml %}
virtualenv_path: /var/www/django-app
{% endhighlight %}

Now run `vagrant provision` again to setup the python virtual environment, then we can start wotking with Django.

#### Working with Django

Before we can use Ansible to automatically synchronise and migrate our database we need a Dajngo application.

Once the provisioner has finished running that's pretty much it for the initial setup, however we could take this further. Let's setup a basic Django application with South and then use ansible to setup the database on the virtual machine creation. Run the following to SSH into the virtual machine, activate the virtual environment and create a new Django application.

```
vagrant ssh
cd /var/www/django-app
source bin/activate
django-admin.py startproject vagranttest
```

This will have created the initial app, but now we need to update the `settings.py` file so Django can talk to Postgresql. Find the following lines in `app/vagranttest/vagranttest/settings.py`:

{% highlight python %}
# Database
# https://docs.djangoproject.com/en/1.6/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}
{% endhighlight %}

And replace them with:

{% highlight python %}
# Database
# https://docs.djangoproject.com/en/1.6/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'django_app',
        'USER': 'django',
        'PASSWORD': 'sdjgh34iutwefhfgbqkj3',
        'HOST': 'localhost',
    }
}
{% endhighlight %}

And add South for migrations support:

{% highlight python %}
# Application definition

INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'South',
)
{% endhighlight %}

Now, let's make Ansible sync our database for us.

{% highlight yaml %}
{% raw %}
- name: Django syncdb
  django_manage: command=syncdb app_path={{ virtualenv_path }}/vagranttest virtualenv={{ virtualenv_path }}
- name: Django migrate
  django_manage: command=migrate app_path={{ virtualenv_path }}/vagranttest virtualenv={{ virtualenv_path }}
{% endraw %}
{% endhighlight %}

Now provision the virtual machine one final time to ensure that it runs through properly.

### Putting Everything to Use

That's all there is to it. Now any developers working on the project simply clone the repository and run:

```
vagrant up
vagrant ssh
cd /var/www/django-app
source bin/activate
python vagranttest/manage.py runserver 0.0.0.0:8080
```

Once they've done this they'll have an identical environment to everyone else, will be able to continue working in their favourite editor, and will be able to access the project by simply accessing `http://localhost:8080` in a browser on their local machine.

There are a few Vagrant commands worth knowing:

* `vagrant up`: Boots a virtual machine
* `vagrant provision`: Force the provisioners to be run again a virtual machine. Useful for updating the configuration of existing virtual machines.
* `vagrant halt`: Shutdown a virtual machine.
* `vagrant suspend`: Sleep a virtual machine.
* `vagrant destroy`: Delete a virtual machine from your system.

It's also worth noting that you should always add `.vagrant/` to the ignore file for your source control. Otherwise you will be committing entire virtual machines to your project, which is the last thing you want to do.

### Summery

Vagrant provides a flexible way of allowing multiple developers to work on complex project with little manual setup time or complexity and without littering their system with project dependencies. It is a well-designed platform which allows complex infrastructure to be replicated on a local computer with ease by as many developers as required.

Ansible presents a powerful way of provisioning servers and virtual machines with a minimal leaning curve. This article has only touched on the basics of what Ansible can do, covering the basics of keeping your configuration organised, and how to setup and configure basic software packages.

Between Vagrant and Ansible you have everything you need to create portable development environment which can easily be committed into source control with the rest of your project for any developer to use.

The source for this example project is available on [GitHub](https://github.com/danielgroves/Vagrant-Tutorial "Vagrant Tutorial Source").
