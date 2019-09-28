---
published: true
title: "Van Electrics Fitout Part 1"
excerpt: "Getting a split caharge setup for a leisure battery installed under the drivers seat. "

date: 2019-09-28 11:00
tags: planvan van electrics

thumb: 20190324-DSCF5603
banner: 20190324-DSCF5603
---

[The vans](/tag/van) electrical fit-out has been broken into two phases. Because the main camper conversion isn't done yet I don't yet know exactly where I'll want switches, lights, control panels, fridges or anything else. Despite this, I really do need the lights for the way I use the van, as well as the ability to charge camera batteries, run my iPad, charge bike lights, GPS units, etc.

Doing the split charge conversion is a lot of work. The job started by removing the drivers and passengers seats entirely, the lower half of the dashboard and the flooring from the cab. From here it's possible to trace other cables and find a way through into the engine bay. I found a rubber grommet with a hole in behind the rubber matting near the passenger door, poking the 16mm2 battery cable through here I found it appeared right behind the start battery in the engine bay, perfectly located for a neat install. I ran this cable behind the dashboard and then followed the existing wiring loom under the airbag control unit guard and over to the drivers seat.

{% figure narrow %}
  {% img src: 20190324-DSCF5600, alt: Victron Energy Cyrix-ct Split Carge Relay installed and wired into both batteies. %}
  {% figcaption %}Victron Energy Cyrix-ct Split Carge Relay installed and wired into both batteies.{% endfigcaption %}
{% endfigure %}

With this cable run done I then ran the power supply for the radio from the drivers seat up behind the dashboard and out of one of the blanking plates. I left this for the time being, focusing on getting the split charge working before wiring the radio in to run off either the normal ignition wiring, or the leisure battery based on a switch.

With these initial wires in place I proceeded to ensure there was plenty spare at each end before reinstalling the dash and rubber floor, and then the seat-box from the drivers seat. This gave me a chance to test fit the 120aH leisure battery I'd chosen, and then wire everything up with plenty of space to move around and get at all of the components.

{% figure %}
  {% img src: 20190324-DSCF5603, alt: Battery teminal on the leisure battery. This terminal was insualted before the seat was reinstalled.  %}
  {% figcaption %}Battery teminal on the leisure battery. This terminal was insualted before the seat was reinstalled. {% endfigcaption %}
{% endfigure %}

I started in the engine bay, first making up a short 10cm cable to the first 125amp rated fuse, and then hooking up the main run to the drivers seat. I left the fuse out so I wouldn't be dealing with any live cables until the last possible minute. From here I spent some time playing with different layouts in the seat box before I decided to place the battery along the back, strapped into the reinforcements inside the box, and then screwing some wooden panels into the sides of the seat box via existing mounting holes. Now I could finalise the position of the fuse-box, voltage-sensing-relay, and the second charge wire cable.

{% figure %}
  <div class="row pair">
    {% img src: 20190324-DSCF5604, alt: Inline fuse between the split-carge relay and the leisure battery. %}
    {% img src: 20190324-DSCF5598, alt: Fuse box installed for auxiliary electrical devices. %}
  </div>
  {% figcaption %}**Left:** Inline fuse between the split-carge relay and the leisure battery; **Right:** use box installed for auxiliary electrical devices.{% endfigcaption %}
{% endfigure %}

Once happy with the position of everything I screwed all the parts in place and then wired each up in turn starting with the feed from the start battery and ending with the leisure battery. The rubber cab flooring has a large flap under the seat under which there's an earthing bolt, so I ran 16mm battery cable from the leisure battery to the earthing bold to complete the circuit, and to keep everything accessible ran 6mm cable from the leisure battery via a 20amp fuse to the fuse box, and then used a 6mm return for the negative on the fuse box to the battery, rather than to the earthing bolt. I did this to keep as much wiring as possible accessible and reduce the chances of having to pull everything out to fix any issues.

{% figure %}
  {% img src: 20190324-DSCF5596, alt: Final install. Some of the cables can be tidied up once aux devices are in their final install location. %}
  {% figcaption %}Final install. Some of the cables can be tidied up once aux devices are in their final install location.{% endfigcaption %}
{% endfigure %}

With these basics in place I connected my multimeter across the battery terminals to monitor the voltage, added the fuse under the bonnet, and started the van to test the system. A few seconds after start the relay clicked, signifying the start battery had hit a suitable voltage, and the voltage on the leisure setup jumped up to show it was charging. With this done I packed up shop, and decided to call it a day there.
