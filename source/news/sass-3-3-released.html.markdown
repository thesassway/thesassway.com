---
date: 11 February 2014
categories: news
author: John W. Long
summary: It's been a long time coming, but well worth the wait! Sass 3.3 includes many long awaited features, including the new Map data structure, source maps, improved ampersand semantics, and an improved `if()` function.
header: sass-3-3
reversed_header: true
---

# Sass 3.3 (Maptastic Maple)

<div class="intro">
<p>Today, we're pleased to announce that Sass 3.3 (aka Maptastic Maple) has been released! With over 500 commits and <a href="http://sass-lang.com/documentation/file.SASS_CHANGELOG.html">35+ new features</a> it's safe to say that this is a significant release.</p>
</div>

To make it easy to understand some of the exciting new features in Sass 3.3 we've summarized them in the sections below. Click on an item in the list to jump straight to it:

* [New map data structure](#maps)
* [Sass source maps](#source-maps)
* [Parent selector suffixes](#parent-selector-suffixes)
* [New @at-root directive](#at-root)
* [Improved if() semantics](#if)
* [Backwards @for loops](#backwards-for)
* [Multiple assignment in @each loops](#multi-each)


## <a name="maps" class="anchor"></a>New map data structure

The most significant change to the language in this update is the addition of the `Map` data structure! If you've used regular programming languages like JavaScript or Ruby you may know that a `Map` is sometimes called a `Hash`. They store a mix of key/value pairs:

    :::scss
    $colors: (
      header: #b06,
      text: #334,
      footer: #666777,
    )

You can retreive values from the map with the `map-get()` function:

    :::scss
    .header {
      background-color: map-get($colors, header)
    }

Maps can also be used instead of keyword parameters:

    :::scss
    $adjustments: (hue: 5deg, lightness: 10%);
    $color-1: adjust-color($color-1, $adjustments...);
    $color-2: adjust-color($color-2, $adjustments...);

For more info about Sass maps see the [changelog](https://github.com/nex3/sass/blob/master/doc-src/SASS_CHANGELOG.md) and read Jason Garber's article, *[Sass maps are awesome](http://viget.com/extend/sass-maps-are-awesome)*. Also if you are interested in the history of the syntax, check out [this awesome issue](https://github.com/nex3/sass/issues/642) on GitHub where the syntax is proposed and discussed in detail.

<a class="top-link" href="#features">Back to top</a>


## <a name="source-maps" class="anchor"></a>Sass source maps

Sass source maps are a hot new feature in Sass that make it possible to view the Sass source files inside the browser instead of just the compiled CSS (currently this only works in Chrome). And with the proper configuration you can actually edit the files inside of your browser, too!

![Sass source maps in action!](/images/articles/sass-sources.png)

I don't have time to detail how this works in this post, but read Google's documentation on *[Working with CSS Preprocessors](https://developers.google.com/chrome-developer-tools/docs/css-preprocessors)* or Sam Richard's article *[Debugging Sass With Source Maps](http://snugug.com/musings/debugging-sass-source-maps)*. Or, if you are more visual, watch Chris Eppstein show this off in his talk *[The Mind-blowing Power of Sass 3.3](http://www.youtube.com/watch?v=-ZJeOJGazgE)* (in which he also shows off many more amazing Sass 3.3 features).

<a class="top-link" href="#features">Back to top</a>


## <a name="parent-selector-suffixes" class="anchor"></a>Parent selector suffixes

The ampersand operator has a long and celebrated past in the Sass community. It makes it possible to write code like this:

    :::scss
    // The parent selector in action...
    .button {
      &.primary { background: orange; }
      &.secondary { background: blue; }
    }

    // Output:
    .button.primary { background: orange; }
    .button.secondary { background: blue; }

It's now possible to use a parent selector with a suffix to append to the selector

    :::scss
    // Ampersand in SassScript:
    .button {
      &-primary { background: orange; }
      &-secondary { background: blue; }
    }

    // Output:
    .button-primary { background: orange; }
    .button-secondary { background: blue; }

Previously, this would have caused an error in Sass, but no longer!

<a class="top-link" href="#features">Back to top</a>


## <a name="at-root" class="anchor"></a>New @at-root directive

A new directive has been added to Sass that allows you to "unwind" nesting and insert something at the highest level. Simply prefix a selector with the `@at-root` directive and it will ignore previous levels of nested selectors:

    :::scss
    .message {
      @at-root .info { color: blue; }
      @at-root .error { color: red; }
    }

Produces:

    :::css
    .info { color: blue; }
    .error { color: red; }

The `@at-root` directive can also be used with a block. This means that the previous example could have been written:

    :::scss
    .message {
      @at-root {
        .info { color: blue; }
        .error { color: red; }
      }
    }

By default `@at-root` will only bust out nested rules, but it can also be used to remove the effects of `@media` or `@support` blocks. For instance:

    :::scss
    @media print {
      .page {
        width: 8in !important;
        @at-root (without: media) {
          width: 960px;
        }
      }
    }

Would produce the following output:

    :::css
    @media print {
      .page {
        width: 8in !important;
      }
    }
    .page {
      width: 960px;
    }

<a class="top-link" href="#features">Back to top</a>


## <a name="if" class="anchor"></a>Improved if() semantics

If you're not a heavy user of Sass you probably haven't come across the `if()` function before. Sass does have the `@if` control structure:

    :::scss
    @if (condition) {
      ...
    } @else {
      ...
    }

Which is useful for multi-line conditionals. But it also has the `if()` function which can be used for simpler constructs:

    :::scss
    $variable: if(condition, result-when-true, result-when-false);

In most cases how this function works is pretty transparent. Unfortunately, it can lead to errors on older versions of Sass. To see what I mean, consider this function:

    :::scss
    @function my-function($args...) {
      // Assign the first argument to $param-1
      $param-1: nth($args, 1);

      // If a second argument was passed assign it to $param-2,
      // otherwise assign an empty list:
      $param-2: if(length($args) > 1, nth($args, 2), ());

      ...
    }

Above, if we passed two arguments to `my-function()` the second will be assigned to `$param-2`. If we only pass one argument to `my-function()` an empty list will be assigned to `$param-2`. Or that's our intention.

In previous versions of Sass, however, an error will be raised when only one argument is passed because the expression `nth($args, 2)` will be evaluated regaurdless of the conditional. And since only one argument was passed `nth($args, 2)` is trying to index a non-existant item in the `$args` list which causes an error.

On older versions of Sass the execution works like this:

  * Evaluate result when true
  * Evaluate result when false
  * If `conditional` is true, return `result-when-true`
  * If `conditional` is false, return `result-when-false`

Sass 3.3 has made the `if()` function more of a language construct so that it works like this:

  * If conditional is true, evaluate and return `result-when-true`
  * If conditional is false, evaluate and return `result-when-false`

For most people this won't make a lot of difference in how you write Sass, but if you are a heavy user of the `if()` function these improvements should make you quite happy and you have [Chris Eppstein](https://twitter.com/chriseppstein) to thank for his [work to make this possible](https://github.com/nex3/sass/pull/836).

<a class="top-link" href="#features">Back to top</a>


## <a name="backwards-for" class="anchor"></a>Backwards @for loops

A significant and welcome change contibuted by [Rob Wierzbowski](https://twitter.com/robwierzbowski) is the ability to write `@for` loops that count down instead of counting up:

    :::scss
    @for $i from 5 to 1 {
      .span:nth-child(#{6-$i}) { content: $i; }
    }

Which would output:

    :::css
    .span:nth-child(1) { content: 5; }
    .span:nth-child(2) { content: 4; }
    .span:nth-child(3) { content: 3; }
    .span:nth-child(4) { content: 2; }
    .span:nth-child(5) { content: 1; }

Previously, this would have failed silently with no output.

<a class="top-link" href="#features">Back to top</a>


## <a name="multi-each" class="anchor"></a>Multiple assignment in @each loops

One improvement that might be easy to overlook is that `@each` loops now support multiple assignment. What do I mean by that? Take a look at this example:

    :::scss
    $animals: (puma, black, default),
              (sea-slug, blue, pointer),
              (egret, white, move);

    @each $animal, $color, $cursor in $animals {
      .#{$animal}-icon {
        background-image: url('/images/#{$animal}.png');
        border: 2px solid $color;
        cursor: $cursor;
      }
    }

Basically, multiple assignment for `@each` is good news for when you find yourself dealing with lists of lists. `@each` can now destructure assignment based on the elements of the sub-lists.

Here are the iterations for the loop in our example:

1. First time through: `$animal: puma`, `$color: black`, `$cursor: default` 
2. Second time: `$animal: sea-slug`, `$color: blue`, `$cursor: pointer` 
2. Third time: `$animal: egret`, `$color: white`, `$cursor: move` 

Check out the Sass docs on [multiple assignment with each](http://sass-lang.com/documentation/file.SASS_REFERENCE.html#each-multi-assign) for more info.

<a class="top-link" href="#features">Back to top</a>


## And, much, much more!

These are just the highlights of some of the new features in the latest version of Sass. To get the full scoop, you'll need to read the [changelog](http://sass-lang.com/documentation/file.SASS_CHANGELOG.html) yourself!

Prefer video? Here's Chris Eppstein presenting, *[The Mind-blowing Power of Sass 3.3](http://www.youtube.com/watch?v=-ZJeOJGazgE)*:

<iframe width="560" height="315" src="//www.youtube.com/embed/-ZJeOJGazgE" frameborder="0" allowfullscreen></iframe>
