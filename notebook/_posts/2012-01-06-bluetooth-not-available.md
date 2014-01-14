---
layout: blog
published: true
title: "Bluetooth: Not Available"
excerpt: 'The solution to OS X reporting "Bluetooth: Not Availiable" and refuse to recognise your Macs bluetooth chip'

date: 2012-01-06 20:52:28.000000000 +00:00
---
It's not very often that I get any issues at all with my MacBook, let alone an issue this bad. I can't actually remember the last time I had a major issue, but given my MacBook is now well out of warranty the last thing I am going to do is take it near a Genius bar and risk having pay out loads of money I don't have.

After a reboot earlier today it came as a surprise then when the bluetooth icon in the menubar as a zigzagged line through it, providing the following information when clicking on it "Bluetooth: Not Available".

During the reboot my system appeared to freeze, just before the login screen appeared so, after a while of waiting, I resulted to force it to reboot. This time it booted fine, except for the bluetooth error.

After a little Googling I found an [article by Barry Hess](http://bjhess.com/blog/mac_bluetooth_not_available_after_power_outage/ "Mac bluetooth not available after power outage") about a similar issue caused by a power cut.

Unfortunately for me his solution didn't work, but I had an idea which, for now, appears to have worked. What I proceeded to do was to [reset the PRAM](http://support.apple.com/kb/ht1379 "Resetting the PRAM on your Mac") on my Mac. To do this you simply reboot while holding ⌘ + ⌥ + P + R. Once you hear the chime of your Mac restarting the process is complete, you can simply release the keys to resume a normal start-up.

I have published these finding here with the hope that someone will find them useful, or perhaps I may require them again one day in the future.

### Update 23/01/2012

This issue occurred again today, and this time none of the steps outlined here would work in order to fix the issue. After more research and trail and error exercises, I found that [resetting the SMC](http://support.apple.com/kb/ht3964 "Reset the SMC on an Intel Mac") in an intel based Mac is another common solution, and worked for me on this occasion.
