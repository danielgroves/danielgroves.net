---
layout: blog
published: true
title: Going Solid State
excerpt: I share how I went about upgrading to an SSD whilst maintaining the volume of storage that I require on a dialy basis. 

date: 2012-01-18 10:23:31.000000000 +00:00
---
I've been considering getting a [solid state drive](http://en.wikipedia.org/wiki/Solid-state_drive "Solid State Drive") (or SSD) for a while. I have a [2008 MacBook](http://support.apple.com/kb/sp500 "Late 2008 MacBook") with a 2.00GHz Core 2 Duo, 4GB of DDR3 ram and a 640GB hard drive. That last point is an important one, I have a 640GB drive upgrade for a reason, I simply need to storage capacity. My MacBook is my primary computer and so I cannot afford to loose the storage capacity.

### The Solution

To solve this issue I decided to loose my SuperDrive and to have dual hard drives in my MacBook instead. This meant I would run an SSD as my primary drive, and my old 640GB optical drive as a secondary bay, sat where my SuperDrive once was.

The disadvantage of this, aside from the obvious sacrifice of my SuperDrive, is a small reduction in battery life as I am now running dual hard drives. The advantage is of course the huge performance increase that comes with an SSD, as well as keeping the large amount of storage capacity I had before.

### The Hardware

I decided that this had to be done on a budget. I'm a student and so I don't have loads of cash to blow. I aimed to get everything I need for as close to the £100 mark as I could.

The obvious starting point was to look for a suitable SSD. I have a 2.5" hard drive bay with a SATA2 interface and space for a drive with a <strong>maximum</strong> depth of 9.5mm in the hard drive bay, this limited my option as some makes of drive such as the [OCZ drives](http://www.ocztechnology.com/products/solid_state_drives "OCZ SSDs") are too deep.

In the end I chose a [Crucial M4 64GB SSD](http://www.crucial.com/uk/store/ssd.aspx?gclid=CJ6JipeX2K0CFeshtAodSBLwSA&amp;cpe=pd_google_uk&amp;ef_id=cwpPFgAX2VMAAESb:20120117231119:s "Crucial M4 SSD") as it seemed to fit the bill with the best price, performance and most importantly the 9.5mm depth I required for it to fit in my MacBook.

After this I needed an adapter for my SuperDrive bay so that I could install the old hard drive in it's place. With this I decided to take a risk, I didn't have the budget available to splash out on a main stream brand, so I went over to eBay to see what I could find. I came across a [9.5mm bay for £13.99](http://www.ebay.co.uk/itm/280778916307?ssPageName=STRK:MEWNX:IT&amp;_trksid=p3984.m1439.l2649#ht_855wt_986 "SuperDrive adapter on eBay"), which I purchased.

Finally I also ordered an [external DVD±RW drive](http://www.ebay.co.uk/itm/320817808106?ssPageName=STRK:MEWNX:IT&amp;_trksid=p3984.m1439.l2649#ht_3160wt_1219 "External DVD Drive on eBay"). I decided to do this as I didn't want to completely sacrifice my capabilities to do such things as watching DVDs or copying CDs into iTunes, especially as I rely on my MacBook for everything. It is my DVD player, it is my CD player. It's even my TV.

With the exception of the DVD drive everything has now arrived and been running for about a week. I have had a few bugs to iron out, maybe I'll look into those in a future post, but for now the biggest issue.

### TRIM on a Mac

[TRIM](http://en.wikipedia.org/wiki/TRIM "TRIM on an SSD") is vital have have running when using an SSD. I won't go into any depth about it here as it is easy enough to find information on it elsewhere on the internet. What I will do here is explain how to activate it on OS X and how to find out if it is working on OS X.

All of this was completed on version OS 10.7.2 "Lion" with no problems, although I would suggest taking the usual precautions before messing with any system settings.

TRIM will most likely not be activated on any Mac that does not have an apple supplied SSD under the hood, but it is easy to enable. To check if it is enabled or not go to " -> About This Mac -> More Info...". From here press system report and then select "Serial-ATA" in the sidebar. If it is enabled it should look something like the image below.

[<img class="size-medium wp-image-598" title="Checking if TRIM is activated on OS X Lion" src="http://danielgroves.net/wp-content/uploads/2012/01/trimOnOSX-550x425.png" alt="Checking if TRIM is activated on OS X Lion" width="550" height="425" />](http://danielgroves.net/wp-content/uploads/2012/01/trimOnOSX.png) Checking if TRIM is activated on OS X Lion

To activate TRIM fire up a new Terminal window a use the following commands:

{% highlight bash %}
sudo cp /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage.original

sudo perl -pi -e 's|(\x52\x6F\x74\x61\x74\x69\x6F\x6E\x61\x6C\x00).{9}(\x00\x51)|$1\x00\x00\x00\x00\x00\x00\x00\x00\x00$2|sg' /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage

sudo kextcache -system-prelinked-kernel

sudo kextcache -system-caches
{% endhighlight %}

Once you have run these commands simply reboot your Mac for it all to take effect.

Overall I don't think any of the money spent was wasted. For day to day tasks and launching software though this machine now feels tenfold faster. I'll publish some bench marking results in the next few days to show just how big an improvement the SSD has bought around.
