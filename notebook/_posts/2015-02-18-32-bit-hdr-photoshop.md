---
layout: blog
published: true
title: Incorrect Colour with 32-bit TIFF files in Lightroom
excerpt: When creating a 32-bit RAW images in Photoshop, Lightroom will render the image with incorrect colour. This can be solved through the use of Photoshop Smart Objects.

date: 2015-02-18 20:30
---

Last sunday I spent a large portion of my evening processing a single image in photoshop. This wasn't really a single image, it was actually an HDR images made up of five separate images.

You have three options when you make an HDR image with Photoshop. You can create a 8-bit, a 16-bit or a 32-bit image; with the 8- and 16-bit images you complete your initial toning in HDR Pro, and when you press *done* the image is flattened to you can complete your work in Lightroom or Photoshop. 32-bit images are a little different; you get the option to complete your toning in Camera Raw (also referred to as *ACR*).

ACR is much more powerful than the other options. Rather than embedding changes into the output or as a sidecar file it creates a *smart filter* with is layered on top the HDR image to give you much more flexibility in editing techniques, as well as the ability to go back and fine-tune the toning at a later date.

There are two main disadvantages to working with 32-bit files. Firstly, the size of the output files is huge. They're twice the size of a 16-bit images, which is in turn twice the size a 8-bit file (which is normally what your camera produces). Secondly, they don't render correctly in Lightroom. This is because [Lightroom doesn't think 32-bit images have been tone-mapped](http://feedback.photoshop.com/photoshop_family/topics/lightroom_preview_of_hdr_tonemapped_image_doesnt_match_what_is_shown_in_photoshop_acr#reply_13709665) yet, and so it applies it's own tone-mapping.

As it happens there is a relatively simple workaround to this. You can convert a 32-bit image to a 16-bit image in photoshop, but in doing so you flatten the image meaning you cannot go back and alter your layers of filters at a later date.

If you're familiar with crating 32-bit HDR images already skip to the *Saving with a 16-bit rendering and 32-bit detail*.

## Creating the HDR Image

Select the images you want to use in Lightroom, right-click and select "Edit In" followed by "Merge to HDR Pro". This process will take a few minutes to complete, and then you will be presented with Photoshop HDR Pro. On the drop-down in the top-right of the window is will most likely say 16-bit (it might say 8-bit or 32-bit though), ensure this is set to 32-bit.

At this point most of the toning options will disappear. At this point there is not need to change the one dial left, ensure "Complete tone mapping in ACR" is and press "Tone in ACR".

At this point Adobe Camera Raw will open. From here you can resume your normal editing workflow; if you're new to ACR have a play with the dials and you'll pick it up pretty quickly. Don't feel that you have to get this perfect now, this will be applied as a filter so you can always come back and tweak these settings later as well as taking advantage of all the other feature photoshop can offer to your editing workflow.

Once you're happy-enough with your work here move on to the next section to save the image so that Lightroom can render it correctly, and you can still revisit your edits.

## Saving with 16-bit rendering and 32-bit detail

Select all your layers in Photoshop and then right-click and select *Ceate Smart Object*. Once this is done you'll be left with a single layer. Double clicking the small page icon in the bottom-right of the layer preview will allow you to expand it back into multiple 32-bit layers and resume editing. Now we need to conver the smart-object to a 16-bit image to allow Lightroom to render and export it correctly. To do this select *Image*, *Mode*, and then *16 bits/channel*.

At this point you'll be presented with this popup.

> Reducing the document depth can affect the appearance of layered HDR images.  Merge layers before changing depth?

Select the *Don't Merge* option and let it finish, the image will look the same but when you press save you'll be saving a 16-bit image with the 32-bit layers embedded in the smart-object.

If you have previously saved the image in this process you may find at this point that the image still looks like the colours are incorrect in Lightroom. This is easily resolved by right-clicking and selecting *Metadata* followed by *Read Metadata from File*.

## Summery

That's all there is to it. It's an easy process, and allows you to retain the full abilities of 32-bit editing whilst having the power to use Lightrooms organisation and exporting abilities. The only real disadvantage of this is the files outputted from Photoshop grow ever larger, but most people will distribute their images as JPEG anyway making this a minor issue.
