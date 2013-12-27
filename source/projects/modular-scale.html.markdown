---
date: 23 August 2011
categories: projects, adam-stacoviak
author: Adam Stacoviak
summary: Have you been wanting to design with modular scales, but the math and static-ness of CSS has held you back? Modular Scale is a Sass mixin that does all the heavy lifting and math for you to calculate the values of the modular scale. So put down the calculator and get excited about "prearranged sets of harmonious proportions" and let Sass do the work!
---

# Sassy Modular Scale: Inspired by and adapted from Tim Brown's modularscale.com

Have you been wanting to design with modular scales, but the math and static-ness of CSS has held you back? Well, put down the calculator and get excited about "prearranged sets of harmonious proportions" and let Sass do the work!

## Who is Tim Brown?

Tim Brown is Type Manager for [Typekit](http://typekit.com/). He studies, promotes, and advances the craft of web typography on a daily basis, shares what he knows at [Nice Web Type](http://nicewebtype.com/), and helps web designers with tools like [Web Font Specimen](http://webfontspecimen.com/) and [Modular Scale](http://modularscale.com/). You can follow Tim on Twitter [@nicewebtype](http://twitter.com/nicewebtype) (we do).

## What is Modular Scale?

Just over 9 months ago, Tim gave his "first ever" talk in front of an audience at [Build](http://www.buildconference.com/) titled ["More Perfect Typography"](http://vimeo.com/17079380) where he talked about the history and craft of typesetting and how it is the center-piece of design.

<blockquote cite="http://vimeo.com/17079380">
<p>Typography is an ancient art and craft; we are merely its latest practitioners. By looking to our tradition for guidance, we might once more attain our finest typographic achievements in this new medium.</p>
<footer>— <a href="http://nicewebtype.com/">Tim Brown</a> in <cite><a href="http://vimeo.com/17079380">More Perfect Typography</a></cite></footer>
</blockquote>

<a href="http://nicewebtype.com/fonts/minion-with-myriad-condensed/"><img src="/attachments/nicewebtype-modular-scale-demo.png" class="right" /></a>

5 months later, Tim wrote an *eye opening* article on A List Apart titled ["More Meaningful Typography"](http://www.alistapart.com/articles/more-meaningful-typography/) that expanded that talk even further to bring up the golden mean (also known as the [golden ratio](http://en.wikipedia.org/wiki/Golden_ratio) or golden section) and how meaningful ratios rooted in geometry, music, nature, and history can be expressed as modular scales and put to work on the web.

## Sassy Modular Scale

Sassy Modular Scale is a fresh new Sass project started by [Scott Kellum](http://scottkellum.com/) and maintained by [Mason Wendell](/mason-wendell) and [Adam Stacoviak](/adam-stacoviak) (myself) that takes inspiration from Tim's [modularscale.com](http://modularscale.com/) project to create a family of functions and mixins to do all the math and heavy lifting for you to calculate the values of a modular scale.

### Installation

To use Sassy Modular Scale in your project, you have the option of installing it as a Compass extension or as a vanilla Sass mixin.

#### Install as a Compass extension (ruby gem)

In terminal, type `gem install modular-scale`. Then add `require 'modular-scale'` to your Compass config file.

#### Alternative installation (without Compass)

Copy `stylesheets/_modular-scale.sass` into your project's Sass directory. Then import the file into your Sass stylesheet to access the mixins and functions.

For example, `@import vendor/modular-scale`.

### How it Works

Building on Tim's original concept, Sassy Modular Scale provides a number of ratios (`$ratio`) that you can use to create relationships. The Golden Ratio is there, as well as eleven other ratios derived from musical intervals like the Major Third, Fourth, and Fifth. You can set any of these as your default ratio, define your own custom ratio, or choose multiple ratios for more complex relationships.

You also choose a default starting value (`$base-size`). This can be any number that has meaning in your design, such as your base font size. Just like with ratios, you can also choose multiple starting values to create relationships between them. This is the same as the process Tim outlined in his original article.

Finally you need to know which value you want from the calculated scale (`$multiple`). Do you want the next value up the scale? The 15th? Or perhaps the 6th value down the scale? This is the one variable you'll pass each time you use the function.

### Usage

Sassy Modular Scale can be used as a function or as a mixin that generates a range of classes to `@extend`. Here are a few examples below using the SCSS syntax.

#### Function

This is the most common use. The function takes an argument for the multiple, base-size, and ratio and returns the desired value along the newly calculated modular scale.

    :::scss
    // modular-scale($multiple, $base-size, $ratio)
    .my-module {
      width: modular-scale(7, 14px, $golden);
    }

The `modular-scale()` function calculates the following set of values, and in this case returns the 7th value up the scale, starting with `$base-size`.

    22.652px 36.651px 59.301px 95.949px 155.246px 251.188px [406.422px]

Here's the generated CSS

    :::css
    .my-module {
      width: 406.422px;
    }

In practice you'll often set some defaults before calling the function. There's also a short name for the function to save on keystrokes. The `ms()` function is identical to the `modular-scale()` function. In fact behind the scenes all it does is call the longer-named function and return its calculation.

    :::scss
    $base-size: 14px;
    $ratio: $golden;

    h1 {
      font-size: ms(2);
      // Pro tip: You can multiply the calculated value,
      // for example to arrive at a suitable line-height.
      line-height: ms(2) * 1.2;
    }

Here's the generated CSS

    :::css
    h1 {
      font-size: 36.651px;
      line-height: 43.981px;
    }


Setting multiple `$base-size` and/or `$ratio` values is simple. Just set the value of either variable as a space separated list. Note: If you use multiple `$base-size` values, the starting point of the scale will always be the *lowest* value in this list.

    :::scss
    $base-size: 14px 125px;
    $ratio: $golden;
    .my-module {
      width: ms(7);
    }
    // 18.239px 22.652px 29.51px 36.651px 47.748px 59.301px [77.256px]


    $base-size: 14px;
    $ratio: $golden $fourth;
    .my-other-module {
      width: ms(7);
    }
    // 18.667px 22.652px 24.889px 33.185px 36.651px 44.247px [58.996px]

Here's the generated CSS

    :::css
    .my-module {
      width: 77.256px;
    }
    .my-other-module {
      width: 58.996px;
    }


#### Mixin to generate a range of classes

There is also a mixin, which allows you to create multiple classes with modular scale values set to some property. These are well-suited to the `@extend` functionality in Sass

    :::scss
    $ratio: $golden;
    $base-size: 14px;
    $class-slug: ms;

    @include modular-scale-classes(4, font-size);

Here's the generated CSS

    :::css
    .ms-0 {
      font-size: 14px;
    }

    .ms-1 {
      font-size: 17.5px;
    }

    .ms-2 {
      font-size: 21.875px;
    }

    .ms-3 {
      font-size: 22.652px;
    }

    .ms-4 {
      font-size: 27.344px;
    }


### Conclusion

Tim Brown's Modular Scale technique is a really great tool for finding numerical relationships for your web work. Sassy Modular Scales is a robust tool for handling these calculations, and can really help you be more nimble when using this technique in Sass.

### Links

* [Project on GitHub](https://github.com/scottkellum/modular-scale)
* [Readme](https://github.com/scottkellum/modular-scale/blob/master/readme.mdown)
* [modularscale.com](http://modularscale.com)
* [More Perfect Typography](http://vimeo.com/17079380)
* [More Meaningful Typography](http://www.alistapart.com/articles/more-meaningful-typography/)
