---
Date: 2011-10-11 10:00:00 -0500
Categories: intermediate, guides, mason-wendell
Author: Mason Wendell
Summary: Responsive Web Design is the new wave, right? In this two part series we'll explore the principles, and talk about how Sass can help. In part one we dive into how Sass can help with the calculations behind fluid layouts and images.
---

# Responsive Web Design in Sass Part 1: Fluid Layouts and Fluid Images

No doubt you've at least heard the term "Responsive Web Design". Since Ethan Marcotte's [article](http://www.alistapart.com/articles/responsive-web-design/) and [book](http://www.abookapart.com/products/responsive-web-design) came out over the last year or so it's been the hot topic among web folk, and rightly so. The solutions Ethan puts forth gracefully solve a number of problems we've been limping along with.

## Fixed width vs. responsive

Fixed width designs are easier to conceive and build in most cases, but they don't work well when the screen size is a drastic change from the design. Because of this, mobile device makers scale most sites down to size, which leaves the content too small to read until the user zooms in. That experience was great when the iPhone and other mobile phones and devices started to play nice with "the real web", but it's hardly a native experience. And that's just the mobile device issue.

Tablets are coming out in a variety of sizes, laptops are getting both smaller and larger, and even our old friend, the desktop, is growing to larger screens and resolutions. Given all these new display options, designing solely for 960px seems a little silly, right?

So what's an enterprising web designer to do?

### Responsive Web Design

Responsive Web Design (<abbr title="Responsive Web Design">RWD</abbr>) remedies most of the issues I've mentioned, but it's not a silver bullet. Nothing ever will be I'm sure. By using fluid layouts instead of fixed, allowing our images to scale, and incorporating media queries, we are able to adjust the shape and size of a design and "respond" to the device it's on.

We meet the device on it's own turf.

## Fluid Layouts

Most articles I've read on <abbr title="Responsive Web Design">RWD</abbr> focus on media queries which I'll cover in Part 2. Media queries are the shiny new toy of web design and allow us to do some great new things. But for my money, the larger break from the old ways is the switch from fixed to fluid layouts. Fluid layouts are certainly more challenging, in part because of all the math involved in calculating the percent and em values, but this is where Sass shines! Sass knows math and can do all the heavy lifting and calculations for you.

Sass already has you covered when it comes to calculating a percentage. With the appropriately named [`percentage()`](http://sass-lang.com/docs/yardoc/Sass/Script/Functions.html#percentage-instance_method) function, you can convert any value where you already have a pixel value into its equivalent percent.

For example if a sidebar is 360px wide in a fixed 960px wide layout, I can calculate the percentage like so:

    :::scss
    .sidebar {
      width: percentage(360px / 960px);
    }

which becomes:

    :::css
    .sidebar {
      width: 37.5%;
    }

Converting px to em values is nearly as simple, but Sass doesn't have a function for it and neither does Compass, so let's write our own.

This function is nearly the same as `percentage()` except that it takes two arguments (`$target-px` and `$container`) and represents the result in ems.

    :::scss
    @function calc-em($target-px, $context) {
      @return ($target-px / $context) * 1em;
    }

If you wanted to add the equivalent of a 12px left padding to an h2 set at a font-size of 32px you could use it like this:

    :::scss
    h2 {
      padding-left: calc-em(12px, 32px);
    }

which becomes:

    :::css
    h2 {
      padding-left: .375em;
    }


By doing things this way, you can continue to think in terms of pixels and still create perfectly fluid layouts. I don't know about you, but for me, it's much easier thinking in terms of 12px rather than .375em.

## Fluid Images

The next facet of <abbr title="Responsive Web Design">RWD</abbr> are images that scale to fit their containers. For all modern browsers, this is simple enough that you don't need Sass to help out. Simply add a `max-width: 100%` to your `<img>` tags and you're all set.

    :::css
    img {
      max-width: 100%;
    }

If you need to support IE6 or below you'll need to judiciously use `width: 100%` using an IE specific stylesheet. To help with IE's sizing performance, Ethan makes a case in his book [Responsive Web Design](http://www.abookapart.com/products/responsive-web-design) to use Microsoft's proprietary CSS filter `AlphaImageLoader`. It feels dirty, but it works. I wrote a little mixin to help with the syntax.

    :::scss
    @mixin scale-image-ie($image) {
      background: none;
      filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
        src="#{image_url($image, true, false)}",
        sizingMethod="scale"
      );
    }

If you have a background image that you need to scale or fit in a container, there is a CSS3 property that can help. `background-size` gives you some much needed control over how background images are handled. However, if you need to support IE6 through IE8, just know that [background-sizing isn't supported](http://caniuse.com/#search=background-size).

In addition to pixel and percentage values, you can also set your background-size to `contain`  or `cover`.  Contain will keep the entire image in view within your container, potentially leaving some room in the container. Cover will expand your image to fill the container. However, this option often obscures part of the image.

You can use Compass's [background-size mixin](http://compass-style.org/reference/compass/css3/background_size/) to smooth out the browser prefixes. The Compass website also has a great [demo page](http://compass-style.org/examples/compass/css3/background-size/) to show you how the different options behave.

    :::scss
    img.cover {
      @include background-size(cover);
    }

which becomes:

    :::css
    img.cover {
      -moz-background-size: cover;
      -webkit-background-size: cover;
      -o-background-size: cover;
      background-size: cover;
    }

## Next up?

In part 2 of Responsive Web Design in Sass, [Media Queries in Sass](/intermediate/responsive-web-design-part-2), I will be covering the breadth of what you'll need to know about media queries in Sass as well as the upcoming changes for media queries in Sass 3.2.

If you have any questions, please feel free to share your comments below.
