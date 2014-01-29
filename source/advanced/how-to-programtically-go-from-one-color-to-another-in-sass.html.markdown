---
date: 29 January 2014
categories: advanced, guides
author: Hugo Giraudel
summary: Have you ever wanted to know how to programmatically jump from one color to another, just out of curiosity? Today I will show you how to find the color operations that are required to go from the color to another. We'll use everything we can from Sass 3.3 features, including maps and the awesome yet little known `call` function.  
---

# How to programmatically go from one color to another in Sass

At work, we have 4 major sections on our site: shopping, news, associations and something that could be translated to ads. Each section has its own color scheme bound to it, to make every part of the site visually distinct from the others. So shopping is blue, news is purple, associations is orange and ads is green.

While each theme has its own color scheme, the latter is based on two colors. Both are very close, and usually one is just a tiny variation from the first, like a little lighter, a little less saturate... You get the idea.

We are using Sass for our CSS architecture and you know as well as I do all the color manipulation functions from Sass like `lighten`, `darken` and all the others. So I thought to myself: "hey, what if I could dynamically generate the second color from the first so I could get rid of all the secondary color variables?".

It would be quite cool, right? So today guys I'd like to show you a little experiment pushing the color functions a little further than usual. What do you say? Let's go?


## Understanding colors

Before digging into Sass code, it is very important for this one to understand how colors actually work. If you haven't read my &mdash; old yet still valuable &mdash; article about [CSS colors](http://hugogiraudel.com/2012/11/27/css-colors/), I highly recommand you to do so. Go on, I'll wait.

Okay, you ready now? So you've probably figured out that colors can be written using a `HSL` representation. HSL stands for *Hue Saturation Lightness*, the 3 main components of a color. According to Wikipedia:

> HSL [is one of] the two most common cylindrical-coordinate representations of points in an RGB color model. HSL stands for hue, saturation, and lightness, and is often also called HLS. [T]he angle around the central vertical axis corresponds to "hue", the distance from the axis corresponds to "saturation", and the distance along the axis corresponds to "lightness", "value" or "brightness".

Basically the hue gives the tint (based on a color wheel), saturation defines if your color is bright or dull (percentage) and lightness defines if you color is dark or light (percentage).


## Moving on to Sass

Let's sum up what we need to do: we want to figure out what are the operations to do to one color in order to get to another color. But we already know both colors, right? So we only want to understand what does it take to go from the first to the second.

Then once we've done this for one of our 4 sections, we can repeat it for the others. If the manipulations are the same for all sections, then it means we can programmatically generate the second color of each color scheme, which would be pretty awesome.

To figure out the color operations required to jump from one color to another, we need to determine the difference of two colors. Thankfully we won't have to manually compute this because Sass already provides a couple of functions for this: `hue($color)`, `saturation($color)` and `lightness($color)`. Exactly what we need, right? 

    :::scss
    @function color-diff($a, $b) {
      $hue: hue($a) - hue($b);
      $saturation: saturation($a) - saturation($b);
      $lightness: lightness($a) - lightness($b);
    }

As you can see, it is very easy to define the differences between two colors with Sass. But what should we do with this? Remember we want to know what are the color functions to apply to color `$a` to retrieve color `$b` so we could determine which functions should be called. 

    :::scss
    @function color-diff($a, $b) {
      $hue: hue($a) - hue($b);
      $saturation: saturation($a) - saturation($b);
      $lightness: lightness($a) - lightness($b);

      $function-hue: 'adjust-hue';
      $function-saturation: if($saturation > 0, 'desaturate', 'saturate');
      $function-lightness: if($lightness > 0, 'darken', 'lighten');
    }

I believe you're like *"wait.. what? where are you going with that?"*. Hold on, you'll understand in a minute. For the saturation function to apply, it depends on the difference between `saturation($a)` and `saturation($b)`. If it's positive, then it means the first color is more saturate than the second and we have to desaturate it. Else it's the opposite. It works the same for lightness.

What if we returned a map (Sass 3.3) with functions as key and diff results as values?

    :::scss
    @function color-diff($a, $b) {
      $hue: hue($a) - hue($b);
      $saturation: saturation($a) - saturation($b);
      $lightness: lightness($a) - lightness($b);

      $function-hue: 'adjust-hue';
      $function-saturation: if($saturation > 0, 'desaturate', 'saturate');
      $function-lightness: if($lightness > 0, 'darken', 'lighten');

      @return (
        #{$function-hue}: -($hue),
        #{$function-saturation}: abs($saturation),
        #{$function-lightness}: ($lightness),
      );
    }

I have to admit it looks pretty odd. To put it simple, we've returned something that looks like this:

    :::scss
    $map: (
      'adjust-hue': -42deg,
      'saturate': 13.37%,
      'darken': 4.2%
    );

See? Keys are function names, values are diff results. So the result of the `color-diff` function is a map of the operation to apply to `$a` in order to get `$b`. That sounds pretty cool but we should make sure it works as expected.


## Making sure it works

Checking whether our work is efficient is actually quite simple: we only have to apply those operations to color `$a` and see if it returns color `$b`. Of course we are not going to do it manually, that would be gross. What about an `apply-diff` function?

    :::scss
    @function apply-diff($color, $diff) {
      @each $function, $value in $diff {
        $color: call($key, $color, $value);
      }
      @return $color;
    }

Guys, isn't that nice, seriously? 

1. We loop through all the pairs from the map
2. We call the `$key` function with two arguments: `$color` and `$value`
3. We return the transformed color

Nothing better than a little example to make sure everything's right. Consider `$a: #BADA55` and `$b: #B0BCA7`. First, we run the `color-diff` function to get the diff.

    :::scss
    $a: #BADA55;
    $b: #B0BCA7;
    $diff: color-diff($a, $b);
    // (adjust-hue: 19.84962deg, desaturate: 50.70282%, lighten: 10.19608%)

Now we run `apply-diff` on `$a` with `$diff` to check if `$b == apply-diff($a, color-diff($a, $b))`.

    :::scss
    $c: apply-diff($a, $diff);
    // #B0BCA7

Victory! It works like a charm.

*Note: instead of returning function names to be called as map keys, you could return a map with `hue`, `saturation` and `lightness` as keys (`(hue: $hue, saturation: $saturation, lightness: $lightness)`) and then call the `adjust-color` function from Sass like this `adjust-color($color, $hue: map-get($diff, hue), $saturation: map-get($diff, saturation), $lightness: map-get($diff, lightness))` in the `apply-diff` function. It works as well but I kind of like the elegance of the map + `call` workflow. Your choice, really.*


## Back to our case

So I applied the `color-diff` function to each color pair for each site section I am working in. Here are the result:

    :::scss
    $shopping: color-diff(#41cce4, #4F8DAA);
    // (adjust-hue: 10.28652deg, desaturate: 38.56902%, darken: 8.62745%)
    $associations: color-diff(#ffa12c, #FB6E04);
    // (adjust-hue: -7.52115deg, desaturate: 3.13725%, darken: 8.62745%)
    $news: color-diff(#937ee1, #AD69EC);
    // (adjust-hue: 18.41777deg, saturate: 15.25064%, darken: 1.96078%)
    $ads: color-diff(#b1d360, #88A267);
    // (adjust-hue: 8.70155deg, desaturate: 32.56861%, darken: 8.23529%)

Damn it! Since all diff are different (no pun intended), there is no way I can dynamically generate the second color from the first one.


## Final thoughts

Even if I couldn't use this stuff in my project, I haven't done this in vain; Firstly because it gave me the occasion to write a blog post (and God knows I lack of topics to write about) but also because I think it's interesting to understand how you can morph a color into another one.

Colors are very complicated to deal with once you get off your color picker. Being able to find the manipulation process to get a color from another one is &mdash; in my opinion &mdash; valuable. What do you think? Anyway, I hope you liked the experiment guys ([check the code](http://sassmeister.com/gist/8668994)). Cheers!

On a site note, imathis has worked on [Color Hacker](https://github.com/imathis/color-hacker), a Compass extension providing some advanced color functions to deal with your color schemes. It is worth a look. ;)
