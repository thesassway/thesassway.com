---
date: 18 November 2013
categories: intermediate, guides
author: John W. Long
summary: Learn how to use Sass color functions to calculate backwards compatible colors for browsers that don't support alpha transparency and wrap up this functionality in a couple of handy mixins.
---

# Mixins for Semi-Transparent Colors

One of the things I love most about Sass is it's ability to calculate colors based on other colors. I often use functions like <code>darken()</code>, <code>saturate()</code>, and <code>adjust-color()</code> to calculate highlight colors or shadows for things like buttons.

Recently I've enjoyed using semi-transparent colors in my designs to better blend elements with their backgrounds. Sass makes it easy to create semi-transparent colors with the <code>rgba()</code> function:

    :::scss
    .button {
      background: rgba(black, 0.5);
    }

In CSS, <code>rgba()</code> takes four parameters. The first three are for red, green, and blue. The last is the alpha channel. Sass allows you to pass just two parameters. The first can be any color and the last, like the CSS version, is the alpha channel. At compile time Sass will translate the two parameter version into four.

But <code>rgba()</code> colors come with a price. Earlier versions of Internet Explorer can't interpret them correctly. When browsers have trouble interpreting an attribute/value pair they ignore it. This means that any element with an <code>rgba()</code> background will be rendered as completely transparent. You can get around this by including another color attribute with a format older browsers understand:

    :::scss
    .button {
      background: #7f7f7f;
      background: rgba(black, 0.5);
    }

If you have a color picker tool, you can grab the values of the mixed colors yourself and add the additional attribute/value pairs manually, but this can be quite tedius. Why not use the the <code>mix()</code> function to mix the colors for you?

    :::scss
    .button {
      background: mix(black, white, 50%);
      background: rgba(black, 0.5);
    }

But we can do better than this! Invoking some deeper magic, we can write a mixin that extracts the alpha component of a color, convert it to a percentage and use <code>mix()</code> to convert an <code>rgba()</code> color and a background color into the appropriate attribute/value pairs:

    :::scss
    @mixin alpha-background-color($color, $background) {
      $percent: alpha($color) * 100%;
      $opaque: opacify($color, 1);
      $solid-color: mix($opaque, $background, $percent);
      background-color: $solid-color;
      background-color: $color;
    }

Now we can write our code like this:

    :::scss
    .button {
      @include alpha-background-color(rgba(black, 0.5), white);
    }

Which greatly simplifies things. With just a bit more effort, you can use a little [Sass interpolation](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#interpolation_) to make a generic mixin that you can use to set any color attribute:

    :::scss
    @mixin alpha-attribute($attribute, $color, $background) {
      $percent: alpha($color) * 100%;
      $opaque: opacify($color, 1);
      $solid-color: mix($opaque, $background, $percent);
      #{$attribute}: $solid-color;
      #{$attribute}: $color;
    }

And finally, our updated code:

    :::scss
    .button {
      @include alpha-attribute('background-color', rgba(black, 0.5), white);
    }

Handy! To see this in action on a couple of my own buttons, check out [this code pen](http://codepen.io/jlong/pen/IEpvh).
