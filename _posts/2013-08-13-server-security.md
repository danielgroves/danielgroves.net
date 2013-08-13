---
layout: blog
published: true

title: Server Security
date: 2013-08-13 14:30 +00:00
excerpt: "How I current go about securing a new server, with hope hope of helping and gaining feedback from others"
---

The first time you get your own server, whether it be dedicated or virtual private, it is important to learn about security. This is one discussion that came up between myself and [Daniel Tomlinson][dt] ([@dantoml][dt_tw]) on Twitter a while back, during which I agreed to write a post on the basics of securing a linux server, although many of these practices can be transferred to just about any environment. 

During this article if you read *anything* that is incorrect, please let me know. The same applies to anything that could be improved or anything that I may have missed, or overlooked. 

At this stage it would also be wise to make this clear: I am *by no means* a security expert, and *cannot* be held responsible under any circumstances if this security does not prove strong enough in your circumstances, or you screw-up your server. Essentially, should you use anything or follow any advise form this article, and something goes wrong, *don't blame me*. 

During this article, what I am going to cover is:

- Disabaling the root account
- Enabling a firewall
- Securing SSH
- Some best-practices

This will all be based upon [Ubuntu][ubuntu], but feel free to post suggested packages for other distributions in the comments. 

### Disabling the root account

The first thing I tend to do is to disable root account on the VPS. This has advtanges and disadvantages which are discussed in the [ubuntu documentation][ub_sudo], but it essentially boils down to the following:

- Makes is harder for *you* to screw up
- All `sudo` activity is logged
- Easier to give and revoke superuser privlidges to users as nessessery
- The root account password does *not* need to be distributed
- Superuser authentication can expire quietly in the background while a user continues working. 
- Harder to brake into a box through brute-force. If the attacker does not know your username it's harder to attack your account, and as root is disabled no attempts to crack the root login will let them in. 

Disabling the root account on Ubuntu is pretty simple; but first you need to create yourself a new account with superuser privlidges (if you don't already have one). To create a new user run `useradd <username>` and follow each prompt as they appear to give the system your details. 

Once you have a new user account add it to the 'sudo' group by running `usermod -aG sudo <username>`. This will enable your new account as a superuser, now logout of the root account and login as the new user.  

Assuming you have now logged in without any issues we can disable the root account. To do this run `sudo passwd -dl root`, and that all there is to it. 

### Enabling a firewall

The idea of a firewall is to manage connections to your server in order to help block or filter unwanted packets. Blocking unwanted packets helps us to ensure a server is properly secured and helps prevent malicious access attempts, for this reason firewalls are often thought of a a first-line of defence. In many corporate environments a hardware firewall is used, but for you small VPS we'll setup a software firewall. 

A firewall is a list of rules that each network packet gets checked against. If it passes all of the rules it'll be allowed through to whatever program is listening out for it. If it fails it will be discarded. 

Although some may argue that you're better off configuring iptables directly, you can't beat the *Uncomplicated Firewall*, or *ufw*, for ease of use; that's what we'll be using here. 

Installing ufw on Ubuntu couldn't be easier, just run `sudo apt-get install ufw` and press 'y' when prompted to confirm the installation. Once it's installed we need to configure some rules. By default all inbound traffic is denied and all outgoing traffic is allowed, we need to open port 22 (as some of you may be logged in via SSH) before enabling the firewall. 
	
	sudo ufw allow 22
	sudo ufw enable

If you're logged in via SSH ufw will warn you about the possible connection interruption when you enable it. Just hit 'y' as we've added an exception to the firewall already for SSH. At this point you have an active firewall that is blocking access on every port except for SSH, but you'll probably want to open up some more as well. 

- `sudo ufw allow 80` will allow an http connection.
- `sudo ufw allow 433` will allow an https connection.
- `sudo ufw allow 21` will allow an FTP connection; I do not recommend using FTP but we'll cover this later. 

Only open the ports you need as you need them. Opening ports unnecessarily will only increase the risks that your server is open to. We can increase the security on our server by creating rules that are stricter than the current set. 

For this next example we will only allow SSH access from our own IP address, which should help to eliminate most, if not all, brute force attacks as these can only be carried out from behind the same public-facing IP as our network uses. It is important to note that you should only to this if your public IP is static, as a dynamic IP could change resulting in you getting locked out of your own server. To limit SSH access by IP simply run:

	sudo ufw allow from 172.20.10.2 to any port 22
	
This will only allow connection to port 22 from the ip `172.20.10.2`, you should change the IP to your own IP, however the old rule is still active. We need to list the existing rules and remove the two old ones to ensure anyone else gets denied access. To do this list all the rules and delete the IPv4 rule, and repeat for IPv6. The output should look something like this:

	vagrant@precise32:~$ sudo ufw status numbered
	Status: active

	     To                         Action      From
	     --                         ------      ----
	[ 1] 22                         ALLOW IN    Anywhere
	[ 2] 22                         ALLOW IN    172.20.10.2
	[ 3] 22                         ALLOW IN    Anywhere (v6)

	vagrant@precise32:~$ sudo ufw delete 1
	Deleting:
	 allow 22
	Proceed with operation (y|n)? y
	Rule deleted
	vagrant@precise32:~$ sudo ufw status numbered
	Status: active

	     To                         Action      From
	     --                         ------      ----
	[ 1] 22                         ALLOW IN    172.20.10.2
	[ 2] 22                         ALLOW IN    Anywhere (v6)

	vagrant@precise32:~$ sudo ufw delete 2
	Deleting:
	 allow 22
	Proceed with operation (y|n)? y
	Rule deleted (v6)

Once this is done SSH access can only be gained from your IP address. For more details on the advanced ufw configuration options, [check the documentation][ufw]. 

### Key Based Authentication

Key based authentication is primarily used to increase the security when connecting to a server via SSH over that of a password. A key-pairs consists of a public "encrypting" key and a private "decrypting" key, the public key is stored in an `authorized_keys` file on the remote server which is used to authenticate SSH sessions. 

Although it is still possible from someone to brute-force an SSH session the chances are lower due to the size of the key and how random the key is. In the event that a key is compromised it would need to be de-authorised so that it can no longer be used. A more solid way of preventing brute-forcing of a key-pair would be to block all IP addresses but your own with a firewall, as previously mentioned this will only work if you have a static IP address. WikiPedia has a detailed article about [how key pairs work][keys]. 

Generating a key-pair is easy to do on Ubuntu, it's as simple as running a single command and then copying the key to your remote server. Here's the output from generating a key on my system, don't forget to replace `you@example.com` with your own email address though, you can leave the location as the default but I would recommend setting a password. 

	vagrant@precise32:~$ ssh-keygen -t rsa -C "you@example.com"
	Generating public/private rsa key pair.
	Enter file in which to save the key (/home/vagrant/.ssh/id_rsa): 
	Enter passphrase (empty for no passphrase): 
	Enter same passphrase again: 
	Your identification has been saved in /home/vagrant/.ssh/id_rsa.
	Your public key has been saved in /home/vagrant/.ssh/id_rsa.pub.
	The key fingerprint is:
	87:aa:01:8c:dc:b1:90:09:99:48:0b:95:74:83:e1:88 you@example.com
	The key's randomart image is:
	+--[ RSA 2048]----+
	|=*++o            |
	|Bo*. .           |
	|E=..             |
	|.oo o    .       |
	|..oo    S .      |
	|   .   . .       |
	|    . .          |
	|     o           |
	|    .            |
	+-----------------+

Now we need to get our public key onto our remote server, this is easily done.  What we'll do here is display the contents of out `id_rsa.pub` file on the command line so that we can copy it onto the remote server. To do this run `cat ~/.ssh/id_rsa.pub`. Now SSH into your remote server, and type `ls ~/.ssh`.  If it returns `ls: .ssh: No such file or directory` we need to make the folder. To do this type `mkdir ~/.ssh`. 

Now we need to add your key to the `authorized_keys` file. Do do this type `nano ~/.ssh/authorized_keys` and paste your public key into this file. Place it on a new line if there are already entries in this file. Hit Control + O to save and Control + X to exit from nano. When copying your key be sure to get the whole thing, it will start `ssh-rsa` and end with your email address. 

Now, we need to configure OpenSSH. To do this type `sudo nano /etc/ssh/ssh_config` and remove the `#` from the start of the line that reads `PasswordAuthentication yes`, then changes the `yes` to read `no`. Also, ensure `RSAAuthentication` is set to `yes`. Press Control + O to save and then Control + X to exit again. 

Now we need to edit the `sshd_config` file, to do this run `sudo nano /etc/ssh/sshd_config`. In this file we will disable root login (ignore this line if you require it), and reject plain-text passwords requiring a key-pair to login. Ensure the settings detailed below match, you may need to uncomment some lines by removing the `#` from the start. 

	PermitRootLogin no
	RSAAuthentication yes
	PubkeyAuthentication yes
	AuthorizedKeysFile     %h/.ssh/authorized_keys
	PasswordAuthentication no
	
At this point we need to restart SSH for the changes to take effect, run `sudo service ssh restart` and then test your connection (I'd recommend keeping your existing one open for the minute, just until you are sure everything is working). To do this, SSH in from your local machine. You may be asked to authenticate your key by providing the password you chose (if you gave it one), and then SSH will authenticate you automatically using the key in the background. 

Thats it, as long as you successfully logged in without your *server* prompting you for your password then everything has worked as expected. It's perfectly normal for your local system to ask for your authentication key password, on OS X you can tell the system to remember this in the keychain. 

### Good Practice

There are good practices that can be carried out, some of which we've already looked at. 

- Only allow SSH on your IP, where possible
- Use SFTP, not FTP ([FTP is insecure][ftp-insecure] and transmits passwords in plain-text), better still deploy with source control (like [Git][git]). 
- Avoid public web-based interfaces for configuration; these can be exploited to gain access to your server, if you must have one only allow access to it from your own IP and your servers. You can always access it by creating and [SSH tunnel][ssh-tunnel] to your server. 
- Run SSH on an abnormal port; this makes life harder for an attacker. 

#### Use SFTP, not FTP

When using SFTP user login with their normal accounts from the remote server. In order to allow the use of SFTP ensure that a line reading `Subsystem sftp /usr/lib/openssh/sftp-server` exists in your `sshd_config` file. If you have to add it you will need to restart SSH after, although Ubuntu should have it by default. 

Now all local system users will be able to login with SFTP, if you opened port 21 for FTP earlier you'll now be able to close this port on your firewall and uninstall FTP from your system. 

#### Run SSH on an abnormal port

First, open the new port on your firewall. Do this in exactly the same way as detailed in the firewall section, but remember the port number you choose. For this example I will use port number 12345. If you had SSH configured to only be accessible from a certain IP address don't forget do do the same now. 

Then, edit `/etc/ssh/sshd_config` again, and change `Port 22` to your port number, for example `Port 12345`. Now save and restart SSH `sudo service ssh restart`. Now, you can close port 22 on your firewall and login on you're new port by adding `-p 12345` onto your SSH login command, so for example I might use `vagrant@192.168.1.85 -p 12345` to login to my vagrant test virtual machine. 

---

The basic security practices for a linux system are all pretty easy to complete, even for a novice. Just keep your firewall tight, don't run unnecessary services, and configure SSH securely as detailed above. 

If you've found any problems with this article, or have other tips or suggestions then please do comment below, I'd love to here them. 


[dt]: http://danie.lt "Daniel Tomlinson's website"
[dt_tw]: https://twitter.com/dantoml "Daniel Tomlinson on Twitter"
[ubuntu]: http://ubuntu.com/
[ub_sudo]: https://help.ubuntu.com/community/RootSudo
[ufw]: https://help.ubuntu.com/community/UFW "UFW Documentation on the Ubuntu website"
[git]: http://git-scm.com "Git Source Control Manager"
[keys]: http://en.wikipedia.org/wiki/Public-key_cryptography "Public-key Cryptography"
[ftp-insecure]: http://en.wikipedia.org/wiki/File_Transfer_Protocol "FTP on WikiPedia"
[ssh-tunnel]: https://en.wikipedia.org/wiki/Tunneling_protocol "Tunnelling on WikiPedia"