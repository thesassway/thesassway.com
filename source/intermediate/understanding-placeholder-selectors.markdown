---
date: 9 February 2014
categories: intermediate, guides
author: Daniel Imms
summary: Sass provides us with a number of helpful tools to share code between CSS rules. In this article, I'll talk about a relatively new feature in Sass called placeholder selectors. We'll look at how to use this feature correctly, cover some problems that may occur, and examine how it differs from other approaches.
---

# Understanding placeholder selectors

Sass provides a number of different ways to share code between CSS rules. You can use [mixins](/intermediate/leveraging-sass-mixins-for-cleaner-code) to insert new CSS properties and/or rules into your CSS and you can use `@extend` to share CSS properties between selectors. Sass 3.2 introduces a new concept called "placeholders" to make `@extend` generate more efficient output.

But before we get into that, let's talk about how extend works...


## How extend works

The [`@extend`](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#extend) directive allows us to easily share styles between selectors. This is best illustrated with an example:

    :::scss
    .icon {
      transition: background-color ease .2s;
      margin: 0 .5em;
    }

    .error-icon {
      @extend .icon;
      // error specific styles...
    }

    .info-icon {
      @extend .icon;
      // info specific styles...
    }

Which will generate the following output:

    :::css
    .icon, .error-icon, .info-icon {
      transition: background-color ease .2s;
      margin: 0 .5em;
    }

    .error-icon {
      // error specific styles...
    }

    .info-icon {
      // info specific styles...
    }

What's going on here? The `@extend` directive allows us to declare that `.error-icon` and `.info-icon` should inherit the properties of the `.icon` selector. It does this by modifying the `.icon` selector to also include `.error-icon` and `.info-icon`. Pretty nifty, right?

Now here comes the interesting part. What if we never use the `icon` class in our markup and its only purpose is to be there to extend? The resulting CSS will be slightly larger than it really needs to be because we'll have a style that will never be used. We can get around this with placeholder selectors.


## Enter placeholder selectors

Placeholder selectors were introduced to solve this exact problem. They are very similar to class selectors, but instead of using a period (`.`) at the start, the percent character (`%`) is used. Placeholder selectors have the additional property that they *will not* show up in the generated CSS, only the selectors that extend them will be included in the output.

Going back to our initial example, if our icon styles are defined like so:

    :::scss
    %icon {
      transition: background-color ease .2s;
      margin: 0 .5em;
    }

    .error-icon {
      @extend %icon;
      // error specific styles...
    }

    .info-icon {
      @extend %icon;
      // info specific styles...
    }

The following CSS will be generated:

    :::css
    .error-icon, .info-icon {
      transition: background-color ease .2s;
      margin: 0 .5em;
    }

    .error-icon {
      // error specific styles...
    }

    .info-icon {
      // info specific styles...
    }


Notice how `.error` is no longer present in the compiled CSS!


## Extend vs. include

At first glance it may look like placeholder selectors are the same as parameterless mixins. While this is almost true from a *functional* perspective (it will achieve nearly identical results in the browser), the CSS that is generated differs drastically.

Consider the implementation of the icon example using mixins:

    :::scss
    @mixin icon {
      transition: background-color ease .2s;
      margin: 0 .5em;
    }

    .error-icon {
      @include icon;
      // error specific styles...
    }

    .info-icon {
      @include icon;
      // info specific styles...
    }

This will generate the following CSS:

    :::css
    .error-icon {
      transition: background-color ease .2s;
      margin: 0 .5em;
      // error specific styles...
    }

    .info-icon {
      transition: background-color ease .2s;
      margin: 0 .5em;
      // info specific styles...
    }

From a maintenance perspective this is just as good as the `@extend` example, but if you are concerned about the CSS output, this is much worse because the properties are duplicated between rules instead of sharing the same selector.


## Limitations

One limitation with `@extend` that applies to placeholder selectors as well is that it doesn't work between rules in different `@media` blocks.

Consider the following:

    :::scss
    %icon {
      transition: background-color ease .2s;
      margin: 0 .5em;
    }

    @media screen {
      .error-icon {
        @extend %icon;
      }
      
      .info-icon {
        @extend %icon;
      }
    }

This will actually result in a compile error:

    You may not @extend an outer selector from within @media.
    You may only @extend selectors within the same directive.
    From "@extend %icon" on line 8 of icons.scss

When I first ran into this limitation there I thought it was a bug. However, there is a very good reason for why it works this way in Sass.

Since `@extend` works by adding a selector to another selector without duplicating any of the properties it's actually impossible to join selectors in different `@media` blocks.

It does work the other way though. Any media queries surrounding the placeholder selector will be applied to the selectors extending it providing they are not in an `@media` block:

    :::scss
    @media screen {
      %icon {
        transition: background-color ease .2s;
        margin: 0 .5em;
      }
    }

    .error-icon {
      @extend %icon;
    }

    .info-icon {
      @extend %icon;
    }

This will compile to:

    :::css
    @media screen {
      .error-icon, .info-icon {
        transition: background-color ease .2s;
        margin: 0 .5em;
      }
    }


## Final words

The `@extend` and `@include` directives are both very powerful features with some subtle differences. When approaching a style reuse problem you may want to ask yourself if the generated CSS is important to you. In some cases `@extend` can greatly simplify the output and significantly improve the performance of your CSS.

Of course, nothing is stopping you from [mixing and matching](http://sassmeister.com/gist/8893261) `@extend` and `@include` if the situation calls for it. However, I generally try to err on the side of easy-to-understand and maintain source code.
