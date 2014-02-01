---
date: 30 January 2014
categories: advanced, guides
author: Hugo Giraudel
summary: Have you ever wanted to know how to programmatically jump from one color to another? In this article, I'll show you how to find the color operations that are required to go from the color to another. To do this, we'll use a couple of Sass 3.3 features, including maps and the handy `call` function.
---

# How to programmatically go from one color to another in Sass

At work, we have four major sections on our site: *Shopping*, *News*, *Associations*, and something that could be translated *Ads*. Each section has its own color scheme to make it visually distinct from the others. Shopping is blue, News is purple, Associations is orange, and Ads is green.

Each color scheme is made up of a few secondary colors that are based on the key color. The secondary colors are generally simple variations on the key color. One is a little lighter, another has less saturation, another a slightly different hue... You get the idea.

Now Sass allows us to use tools like `lighten()` and `adjust-hue()` to programmatically generate the secondary colors that we need, but often the differences between the key color and the secondary colors are not simple transformations.

This got me thinking! What if we could calculate the mathematical relationship between two colors and use that calculation to generate colors of other themes?


## Understanding colors

Before we go too far, perhaps it would be a good idea to review how colors actually work in CSS. I've got an older article on my own website that gives a good overview of [Colors in CSS](http://hugogiraudel.com/2012/11/27/css-colors/). Go on. Have a look! I can wait.

Okay, ready now? So you've probably figured out that colors can be written using an HSL representation. HSL stands for *Hue Saturation Lightness*, the three main components of a color. According to Wikipedia:

> HSL [is one of] the two most common cylindrical-coordinate representations of points in an RGB color model. HSL stands for hue, saturation, and lightness, and is often also called HLS. [T]he angle around the central vertical axis corresponds to "hue", the distance from the axis corresponds to "saturation", and the distance along the axis corresponds to "lightness", "value" or "brightness".

Hue is the base color that the color is derived from (red, green, blue...). Hue is defined based on the color wheel (given in degrees). Saturation defines if your color is bright or dull (given as a percentage). And lightness defines if you color is dark or light (also given as a percentage).


## Moving on to Sass

To figure out the color operations required to go from one color to another, we need to determine the individual components of the two colors. Thankfully we don't have to manually figure this out because Sass already provides functions to do just this: `hue($color)`, `saturation($color)` and `lightness($color)`. These functions allow us to extract the individual components of a color.

To calculate the difference between two colors we need determine the differences between the individual components of each color:

    :::scss
    $hue: hue($color-a) - hue($color-b);
    $saturation: saturation($color-a) - saturation($color-b);
    $lightness: lightness($color-a) - lightness($color-b);

As you can see, it is very easy to derive the differences between two colors in Sass. Now with these differences in hand we need to determine which functions we need to calculate `$color-b` from `$color-a`.

    :::scss
    // Hue is easy, adjust-hue takes negative and positive params:
    $function-hue: 'adjust-hue';

    // If saturation diff is positive then desaturate, otherwise saturate
    $function-saturation: if($saturation > 0, 'desaturate', 'saturate');

    // If lightness diff is positive then darken, otherwise lighten
    $function-lightness: if($lightness > 0, 'darken', 'lighten');

To wrap up our `color-diff()` function we'll return a map of functions and value params. Maps are a new Sass 3.3 feature similar to a Hash in Ruby or an Object in JavaScript. It allows is to store keys and values:

    :::scss
    @function color-diff($color-a, $color-b) {
      $hue: hue($color-a) - hue($color-b);
      $saturation: saturation($color-a) - saturation($color-b);
      $lightness: lightness($color-a) - lightness($color-b);

      $function-hue: 'adjust-hue';
      $function-saturation: if($saturation > 0, 'desaturate', 'saturate');
      $function-lightness: if($lightness > 0, 'darken', 'lighten');

      @return (
        #{$function-hue}: -($hue),
        #{$function-saturation}: abs($saturation),
        #{$function-lightness}: abs($lightness),
      );
    }

If this looks a little odd to you, we are using Sass interpolation to return something that looks like this:

    :::scss
    $map: (
      'adjust-hue': -42deg,
      'saturate': 13.37%,
      'darken': 4.2%
    );

The keys are function names and values are the diff results. So the result of the `color-diff()` function is a map of the operations to apply to `$color-a` in order to get `$color-b`. Now let's make sure it works as expected.


## Making sure it works

Checking whether our work is efficient is actually quite simple: we only have to apply those operations to color `$color-a` and see if it returns color `$color-b`. Of course we are not going to do it manually, that would be time consuming and error prone. Let's make an `apply-color-diff()` function to alter a color with the diff returned from `color-diff()`.

    :::scss
    @function apply-color-diff($color, $diff) {
      @each $key, $value in $diff {
        $color: call($key, $color, $value);
      }
      @return $color;
    }

So here's how `apply-color-diff()` works.

1. We loop through all the pairs from the color diff map
2. We call the function by then name stored in `$key` with two arguments: `$color` and `$value`
3. We return the transformed color

The Sass 3.3 `call($function, $param-1, $param-2...)` function makes this all possible. Call takes the name of a function in the form of a string and parameters to pass to the function. Here we are using it with our new color diff map to apply the functions in the map to the values.

Nothing better than a little example to make sure everything's right. Consider `$color-a: #BADA55` and `$color-b: #B0BCA7`. First, we run the `color-diff()` function to get the diff.

    :::scss
    $color-a: #BADA55;
    $color-b: #B0BCA7;
    $diff: color-diff($color-a, $color-b);
    // (adjust-hue: 19.84962deg, desaturate: 50.70282%, lighten: 10.19608%)

Now we run `apply-color-diff` on `$color-a` with `$diff` to check if `$color-b == apply-color-diff($color-a, color-diff($color-a, $color-b))`.

    :::scss
    $c: apply-color-diff($color-a, $diff);
    // #B0BCA7

Victory! It works like a charm.


## Back to our case

Now getting back to my original use case. I wanted to see if there was a way to consistently calculate the secondary colors for each theme with one calculation.

Using the `color-diff()` function I can now see if there is a consistent mathematical relationship between the primary and secondary colors in each theme.

Using the function I get the following results:

    :::scss
    $shopping: color-diff(#41cce4, #4f8daa);
    // (adjust-hue: 10.28652deg, desaturate: 38.56902%, darken: 8.62745%)
    $associations: color-diff(#ffa12c, #fb6e04);
    // (adjust-hue: -7.52115deg, desaturate: 3.13725%, darken: 8.62745%)
    $news: color-diff(#937ee1, #ad69ec);
    // (adjust-hue: 18.41777deg, saturate: 15.25064%, darken: 1.96078%)
    $ads: color-diff(#b1d360, #88a267);
    // (adjust-hue: 8.70155deg, desaturate: 32.56861%, darken: 8.23529%)

Darn it! Since each color diff produces different results, I can't actually use this method on my project. There is no way to generate the precise secondary colors used in our design using this approach.


## Final thoughts

Even though I couldn't use the `color-diff()` function in my project, I still found the whole exercise quite valuable. After all, I got a great blog post out of this! It's also been interesting to study how you can morph one color into another one.

What do you think of all this? Have you found interesting ways to morph and use color in your own projects?

I hope you've enjoyed this experiment! If you'd like to play with the code in this project, check out [this Sassmeister gist](http://sassmeister.com/gist/8668994). Cheers!

On a side note, Brandon Mathis has also worked on [Color Hacker](https://github.com/imathis/color-hacker), a Compass extension providing some advanced color functions for dissecting your own color schemes.
