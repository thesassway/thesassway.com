---
date: 16 March 2014
categories: intermediate, guides
author: Aleksandar Goševski
summary: Learn how to use the image spriting features of Compass to improve page download time and drastically reduce the effort needed to assemble sprite sheets.
---

# Spriting with Sass and Compass

As web developers have become more concerned about browser performance a technique called “image spriting” has emerged that is designed to reduce the number of requests made to the server. As it turns out, fewer requests made the server (when there is no significant difference in the combined size of the files delivered) can make a big difference in how fast a page appears to download.

Image spriting works by combining a bunch of images (called “sprites”) into one large image (or “sprite sheet”) to significantly reduce the number of requests made to the server. Then, with clever use of `background-position` only part of the sprite sheet is revealed each time an image is needed.

Here’s an example sprite sheet for a set of toolbar of icons:

<figure class="figure">
  <img class="figure-image" src="/images/articles/sprite-sheet.svg" alt="A sprite sheet">
  <figcaption class="figure-caption">A &#8220;sprite sheet&#8221; with grid lines overlayed to illustrate how it is assembled.</figcaption>
</figure>

Given the image above, we could write the following styles for the media icon:

    :::scss
    $icon-width: 24px;
    $icon-height: 24px;
    $icons: image-url('toolbar.png');

    .media-icon {
      background-image: $icons;
      background-position: -($icon-width * 5) -($icon-width * 1);
      width: $icon-width;
      height: $icon-height;
    }

What this does is shift the background image 5 tiles in the X direction and 1 tile in the Y direction so that the media icon is revealed:

<figure class="figure">
  <img class="figure-image" src="/images/articles/sprite-sheet-position.svg" alt="A sprite sheet">
  <figcaption class="figure-caption">By shifting the <code>background-position</code> of the containing element the correct sprite can be shown.</figcaption>
</figure>

One downside to image spriting is that sprite sheets are notoriously difficult to maintain. Adding a new image requires updating both the image and the related CSS. Matters are made even worse if you decide to remove a sprite. What do you do then? Rejigger the entire sprite sheet?


## Compass to the rescue!

Fortunately for us, Chris Eppstein’s [Compass](http://compass-style.org) project includes a robust suite of tools for creating and maintaining sprite sheets automatically. Compass can build your sprite sheet image, give you the coordinates of each sprite, allow you to control the layout and spacing of the sprites, and write the SCSS necessary to display each image. In short, Compass’s sprite tools will save you a ton of effort.

I’m not going to go over getting started with Compass here because [we have a great tutorial on that already](http://thesassway.com/beginner/getting-started-with-sass-and-compass). If you are not familar with Compass please check out that tutorial before continuing.


## Folder structure

The basic idea behind spriting in Compass is that you drop your sprite images inside of a folder in your <code>images/</code> folder and Compass will use your source images to build the much larger sprite sheet image. For our toolbar example the <code>images/</code> folder would look something like this:

    images/
    |
    `-- toolbar/
        |-- bold.png
        |-- italic.png
        |-- link.png
        |-- code.png
        |-- unordered-list.png
        |-- ordered-list.png
        ...

Keep in mind that you should only put images inside of your sprite sheet folder that you want to be part of the final sprite sheet. Compass will use every image it finds in a sprite sheet folder to assemble the final image.


## The easy way

The easiest way to build your sprite sheet is to use the Compass’s magic import directive:

    :::scss
    @import "images/toolbar/*.png";

When Compass sees a “*.png” pattern in an import directive it assumes it is a folder of sprites that needs to be converted into a sprite sheet. It will then assemble a sprite sheet image for you and include a number of custom mixins to make it easy to access the sprites in your project.

One of those mixins can be used to generate custom classes for all of your sprites automatically. The name of the mixin is based on the name of the folder where the sprite sheet source images are located. In our example:

    :::scss
    @include all-toolbar-sprites;

Will output the following CSS:

    :::css
    .toolbar-sprite, .toolbar-bold, .toolbar-italic, .toolbar-link {
      background-image: url('../images/toolbar-s1f1c6cbfd0.png');
      background-repeat: no-repeat;
    }

    .toolbar-bold {
      background-position: 0 0;
    }

    .toolbar-italic {
      background-position: 0 -24px;
    }

    .toolbar-link {
      background-position: 0 -48px;
    }

Notice that Compass has built the “toolbar-s1f1c6cbfd0.png” image for us automatically. This is our sprite sheet. The name of the file is the name of our sprite sheet (in this case “toolbar”) plus a funny series of letters and numbers called a “hash.” The hash will change whenever you update the sprite sheet so that cached CSS will know to use the updated image.


## Controlling class names

If you want more control over the generated output, don’t use the <code>all-{FOLDER NAME}-sprites</code> mixin. Instead, Compass provides a mixin to ouput the CSS needed for one sprite:

    :::scss
    @import "images/toolbar/*.png";

    .bold-icon { @include toolbar-sprite(bold); }
    .italic-icon { @include toolbar-sprite(italic); }
    .link-icon { @include toolbar-sprite(link); }

Again, this mixin is named based on the name of your sprite sheet. In our example the name of the mixin is <code>toolbar-sprite</code>.


## Sprite maps

If you really want to get low-level, Compass provides another tool called a sprite map that allows you have control over how your sprite sheets are built.

Instead of using the magic import directive, create a sprite map like this:

    :::scss
    $icons: sprite-map("toolbar/*.png");

    .bold-icon { background: sprite($icons, bold); }
    .italic-icon { background: sprite($icons, italic); }
    .link-icon { background: sprite($icons, link); }

Notice that instead of using a sprite sheet specific mixin as we did in the class name example above, now need use the generic <code>sprite</code> mixin with our newly created sprite map.


## Controlling spacing

Sometimes it’s useful to specify that sprites should be separated by a certain amount of white space.

To set spacing around each icon:

    :::scss
    // Using import...
    $toolbar-spacing: 5px;
    @import "toolbar/*.png";

    // Or, if you are using a sprite map...
    $icons: sprite-map("toolbar/*.png", $spacing: 5px);


## Controlling layout

Compass supports a few different ways of laying out your sprite sheet:

<figure class="figure">
  <img class="figure-image" src="/images/articles/sprite-sheet-layout.svg" alt="A sprite sheet">
  <figcaption class="figure-caption">There are 4 types of layout - vertical, horizontal, diagonal, and smart.</figcaption>
</figure>

To set the layout of sprites on the sprite sheet:

    :::scss
    // Using import...
    $toolbar-spacing: 5px;
    $toolbar-layout: 'smart';
    @import "toolbar/*.png";

    // Or, if you are using a sprite map...
    $icons: sprite-map("toolbar/*.png", $spacing: 5px, $layout: diagonal);

**Note:** In the current version of Compass, you can’t use spacing and smart layout in the same time. For all layouts check out link in last section of article about sprite layouts.


## Additional functions and mixins

Compass also provides a number of helpful mixins and functions for working with sprite maps:

* `sprite-url($icons)` - Returns the URL of a sprite sheet.
* `sprite-position($icons, bold)` - Returns the X and Y position of a sprite on the sprite sheet.
* `@include sprite-dimensions($icons, link)` - Set width and height of a sprite based on its original dimensions.

Usage:

    :::scss
    $icons: sprite-map("toolbar/*.png", $spacing: 5px, $layout: diagonal);
    .bold-icon {
      background-image: sprite-url($icons);
      background-position: sprite-position($icons, bold);
      @include sprite-dimensions($icons, bold);
    }


## Digging deeper

There’s a lot more that you can do with Compass sprite sheets. More than we can cover in this simple tutorial. If you’re interested in learning more read the [official Spriting Tutorial](http://compass-style.org/help/tutorials/spriting/) and checkout [some of other docs here](http://compass-style.org/search/?q=sprites).
