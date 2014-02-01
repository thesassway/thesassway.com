---
date: 2012-04-09 06:00:00 -0500
categories: intermediate, guides
author: Mason Wendell
summary: Sass 3.2 is on the way, and there are many improvements to how it handles media queries. Let's get a jump start on all the new stuff and see how we can use media queries, which are now a first-class citizen, in Sass 3.2.
---

# Responsive Web Design in Sass: Using media queries in Sass 3.2

In [Responsive Web Design in Sass Part 2](/intermediate/responsive-web-design-part-2) I wrote about using media queries in Sass 3.1. At the time, I was mostly limited to the (still very cool) [@media bubbling](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#media) feature. I also pointed out some of the shortcomings.

At the end of the post I previewed how you can use [@content blocks](https://gist.github.com/1215856), one of the emerging features of Sass 3.2, to write a mixin that can really help to simplify using media queries in Sass. With Sass 3.2 nearly upon us, I am happy to report that media queries have become the first-class citizens they deserve to be. Let's see what's new.

## Variables in queries

If you tried to use a variable in the media query test in Sass 3.1 it would fail by simply spitting out the actual text of the variable name. This is fixed in Sass 3.2, and works pretty much as I always expected it would.

    :::scss
    $break-small: 320px;
    $break-large: 1200px;

    .profile-pic {
      float: left;
      width: 250px;
      @media screen and (max-width: $break-small) {
        width: 100px;
        float: none;
      }
      @media screen and (min-width: $break-large) {
        float: right;
      }
    }

Compiles to:

    :::css
    profile-pic {
      float: left;
      width: 250px;
    }
    @media screen and (max-width: 320px) {
      .profile-pic {
        width: 100px;
        float: none;
      }
    }
    @media screen and (min-width: 1200px) {
      .profile-pic {
        float: right;
      }
    }



## Variables as full query

You're not limited to using variables in the numerical part of a @media test. Go ahead and set the whole test as a variable. (Note the need for the interpolation braces `#{}`)

    :::scss
    $information-phone: "only screen and (max-width : 320px)";

    @media #{$information-phone} {
      background: red;
    }

Compiles to:

    :::css
    @media only screen and (max-width : 320px) {
      background: red;
    }


## Variables on either side of the colon in a query

You can also get really abstract and set a variable for items on either side of the colon in a test. I can see this being very usefull in building flexible responsive frameworks.

    :::scss
    $width-name: max-device-width;
    $target-width: 320px;

    @media screen and ($width-name : $target-width) {
      background: red;
    }

Compiles to

    :::css
    @media screen and (max-device-width: 320px) {
      background: red;
    }

You can also do math on a variable in a query, like so:

    :::sass
    @media screen and ($width-name : $target-width + 1) {
      background: red;
    }

Compiles to

    :::css
    @media screen and (max-device-width: 321px) {
      background: red;
    }


## Variables in queries, using @content

In [Responsive Web Design in Sass Part 2](/intermediate/responsive-web-design-part-2), I illustrated how to write some nicely abstracted media query systems using `@content` blocks in mixins. Now you can take that a step further by using variables in the actual queries. I think this will be very helpful in refining a set of breakpoints.

On my next project, I think I'll start with some of the usual device-related breakpoints (320, 480, 720) as "placeholder" breakpoints. Then as I progress in building my design I'll alter those to whatever values suit my design.

SCSS

    :::scss
    $break-small: 320px;
    $break-large: 1024px;

    @mixin respond-to($media) {
      @if $media == handhelds {
        @media only screen and (max-width: $break-small) { @content; }
      }
      @else if $media == medium-screens {
        @media only screen and (min-width: $break-small + 1) and (max-width: $break-large - 1) { @content; }
      }
      @else if $media == wide-screens {
        @media only screen and (min-width: $break-large) { @content; }
      }
    }

    .profile-pic {
      float: left;
      width: 250px;
      @include respond-to(handhelds) { width: 100% ;}
      @include respond-to(medium-screens) { width: 125px; }
      @include respond-to(wide-screens) { float: none; }
    }

CSS

    :::css
    .profile-pic {
      float: left;
      width: 250px;
    }
    @media only screen and (max-width: 320px) {
      .profile-pic {
        width: 100%;
      }
    }
    @media only screen and (min-width: 321px) and (max-width: 1023px) {
      .profile-pic {
        width: 125px;
      }
    }
    @media only screen and (min-width: 1024px) {
      .profile-pic {
        float: none;
      }
    }


## Nothing is Perfect

### @extend within @media

There are features and optimisations I'd like to see regarding `@media` handling in Sass. For example `@extend` doesn't behave like I'd expect when I use it in a media query.

When I write the Following in SCSS:

    :::scss
    .red {
      color: red;
      }

    .blue {
      color: blue;
    }

    @media only screen and (max-width : 300px){
      .blue {
        @extend .red;
        margin: 10px;
      }
    }

I intended for the generated css to look something like:

    :::css
    .red {
      color: red;
    }
    @media only screen and (max-width: 300px) {
      .blue {
        color: red;
      }
    }

    .blue {
      color: blue;
    }

    @media only screen and (max-width: 300px) {
      .blue {
        margin: 10px;
      }
    }

But what I really got wasn't nearly as useful.

    :::css
    .red, .blue {
      color: red;
    }

    .blue {
      color: blue;
    }

    @media only screen and (max-width: 300px) {
      .blue {
        margin: 10px;
      }
    }

This is a hairy issue, and different use cases suggest different results. Eventually this may just be [disallowed](https://github.com/nex3/sass/issues/154).


### Combining @media Queries on Compile

One feature I hear a lot of people bring up with `@media` bubbling is that you often end up with the same query in many places in your compiled CSS. The resulting CSS would be much smaller and more closely resemble "handcrafted" CSS if all the rules that match a particular query be combined when the CSS is compiled.

    :::scss
    .profile-pic {
      @media screen and (max-width: 320px) {
        width: 100px;
        float: none;
      }
    }

    .biography {
      @media screen and (max-width: 320px) {
        font-size: 1.5em;
      }
    }

It would be nice (and smaller) if that became:

    :::css
    @media screen and (max-width: 320px) {
      .profile-pic {
        width: 100px;
        float: none;
      }
      .biography {
        font-size: 1.5em;
      }
    }

But instead we get:

    :::css
    @media screen and (max-width: 320px) {
      .profile-pic {
        width: 100px;
        float: none;
      }
    }

    @media screen and (max-width: 320px) {
      .biography {
        font-size: 1.5em;
      }
    }

Nothing's broken here, but it's certainly not optimal. I think this would be a [great issue](https://github.com/nex3/sass/issues/116) to tackle, and it looks like there are some other smart optimisations they're considering.

## So go get it!

As before, you don't have to work hard to get the new good stuff. Just run the following in your command line and you're all set.

 `gem install sass --pre`
