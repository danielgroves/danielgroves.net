---
published: true
title: Colour Shift with 32-bit RAW files in Lightroom
excerpt: When creating 32-bit RAW images in Photoshop, Lightroom will render the image with incorrect colour. This can be solved through the use of Photoshop Smart Objects.

date: 2015-02-21 10:15
---

When producing HDR images with Photoshop HDR Pro there are three 'bit rate' options. The idea here is the higher the bit-rate the more data that can be stored per-pixel and thus the better the colour accuracy, range and manipulation abilities. The three options are 8-, 16-, and 32-bit. 8-bit is what most cameras shoot, and the end result from each bit rate is exactly double the size of the previous.

The problem is 8- and 16-bit images embed the toning within the image as a flat-file which moves the ability to go back and revisit the toning at a later date. This is fine for a lot of users, but sometimes the ability to come back and revisit this is required. That's where 32-bit files come into play.

Not only do 32-bit images hold a greater range of colour and more accurate colour but photoshop can maintain the layers within these images. This allows them to be revisited and a later date and re-toned from scratch if wanted, or even to layer additional toning layers on top of a base.

The problem with 32-bit images is Photoshop CC doesn't allow images to be directly exported from Photoshop itself, and thus Lightroom is required. This in itself isn't a problem, but Lightroom will treat any 32-bit raw files (such as a TIFF or DNG) [as an un-toned image][32bittoning] and attempt to apply its own base-toning on top of this image.

<figure>
    <img src="/assets/images/blog/2015-02-21-colour-shift-lightroom/colourshift.jpg" alt="" />

    <figcaption>
        Colour shift between Lightroom and Photoshop, with the incorrect image on the left and the correct image on the right.
    </figcaption>
</figure>

Thankfully there is a simple way to work around this; smart objects. By combining multiple layers (or converting a single 32-bit layer) into a smart object it is possible change the final document into a 16-bit image while retaining the advanced editing abilities that are held by the 32-bit image. Once combined the smart-object will be a flattened version of those documents held within allowing access to the original documents, and automatically taking in any changes made to those documents.

Doing this is a simple case of selecting all of the layers within a 32-bit RAW file and then right-clicking and selecting "Convert to Smart Object". Once this has finished select "Image", "Mode", and then "16 Bits/Channel" from the top menu, followed by "Don't Merge" in the popup that follows. This will convert the final image into a 16-bit RAW file. Getting back to your 32-bit document is a simple case of double-clicking the page icon in the bottom corner of the layer preview image.

From time to time Lightroom doesn't pickup the changes to the image if the image was saved as a 32-bit file previously. Working around this is just as easy; right-click the file and select Metadata followed by "Read Metadata from File".

[32bittoning]: http://feedback.photoshop.com/photoshop_family/topics/lightroom_preview_of_hdr_tonemapped_image_doesnt_match_what_is_shown_in_photoshop_acr#reply_13709665 "Lightroom treats 32-bit RAW files as untoned"
