---
date: 9 Feb 2014
categories: intermediate, guides
author: Daniel Imms
summary: Sass provides us with many tools to get the job done cleanly and efficiently. This article from Daniel Imms goes into depth on using placeholder selectors with `@extend`, problems that can occur and how it differs with `@include`.
---

# Understanding placeholder selectors

[`@extend`](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#extend) is a great tool, allowing us to reuse styles and stay <abbr title="Don't Repeat Yourself">DRY</abbr>. 

For those of you that are unfamiliar with the `@extend` keyword, it allows sharing all styles of a class with another. This is illustrated in the following example:

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

After compilation, the `.error-icon` and `.info-icon` selectors will share all styles of the `.icon` selector by attaching them to `.icon`'s styles.

    :::css
    .icon, .error-icon, .info-icon {
      transition: background-color ease .2s;
      margin: 0 .5em;
    }


But what if we never use the `icon` class and its only purpose is to be there to extend? The resulting CSS files will be slightly larger as we'll have a style that will never be used.

Since we all care deeply about performance on the web (right?), we want to keep both the weight and complexity of our page down as much as possible.

## Enter placeholder selectors

In version 3.2.0 of Sass, placeholder selectors were introduced to fix this exact flaw. They are selectors defined like any other, but instead of using a `.` or `#` at the start, the `%` character is used. Placeholder selectors have the additional property that they *will not* be generated, only the selectors that extend them will be.

Going back to our initial example, if our icon styles are defined like so:

    :::scss
    %icon {
      transition: background-color ease .2s;
      margin: 0 .5em;
    }

    .error-icon {
      @extend %icon;
    }

    .info-icon {
      @extend %icon;
    }

They will be compiled to:

    :::css
    .error-icon, .info-icon {
      transition: background-color ease .2s;
      margin: 0 .5em;
    }

Notice how `.error` is no longer present in the compiled CSS.

## @extend vs @include

At first glance it looks like placeholder selectors are the same as parameterless mixins. While this is almost always true from a *functional* perspective, the CSS that is output differs drastically. Consider the implementation of the icon example using mixins:

    :::scss
    @mixin icon {
      transition: background-color ease .2s;
      margin: 0 .5em;
    }

    .error-icon {
      @include icon;
    }

    .info-icon {
      @include icon;
    }

From a maintenance perspective it is just as good as the `@extend` example, not so from a performance perspective though. This is what it's compiled as:

    :::css
    .error-icon {
      transition: background-color ease .2s;
      margin: 0 .5em;
    }

    .info-icon {
      transition: background-color ease .2s;
      margin: 0 .5em;
    }

Notice how the rules themselves are duplicated when `@include` is used.

## Limitations

There is a major limitation with placeholder selectors, well `@extend` in general, to always keep in your mind. `@extend` doesn't work when the *extending* selector is in a different `@media` block. Consider the following:

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

<pre><samp>
You may not @extend an outer selector from within @media.
You may only @extend selectors within the same directive.
From "@extend %icon" on line 8 of /app/lib/sassmeister.rb.
</samp></pre>

When I first ran into this limitation there was no compiler message and I thought it was a bug. There is a very good reason that this is how it works though. Since `@extend` works by adding a selector to another selector without duplicating any of the styles, it doesn't make sense for them to be shared across multiple `@media` blocks (because they're impossible to share).

It does work the other way though, any media queries surrounding the placeholder selector will be applied to the selectors extending it.

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

Which compiles to:

    :::css
    @media screen {
      .error-icon, .info-icon {
        transition: background-color ease .2s;
        margin: 0 .5em;
      }
    }

## Final words

The `@extend` and `@include` keywords are both very powerful features with some subtle differences. When approaching a style reuse problem that could be solved by either of them, you should ask yourself which is the right solution.

Of course, nothing is stopping you from [mixing and matching](http://sassmeister.com/gist/8893261) if the situtation calls for it. Just make sure that the maintenance gains outweight the additional complexity of the Sass.
