---
date: 31 August 2011
categories: intermediate, guides, adam-stacoviak
author: Adam Stacoviak
summary: Sass control directives are the cornerstone of creating libraries for reuse and distribution, and need to be among the very first items on your list of things to learn when taking your Sass skills to the next level. They provide flow and logic and give you a finite level of decision making required by mixins and functions.
about_author: adam_stacoviak
---

# Sass control directives: @if, @for, @each and @while

Sass control directives are the cornerstone of creating libraries for reuse and distribution, and need to be among the very first items on your list of things to learn when taking your Sass skills to the next level.

## A crash course to Sass control directives

[Sass control directives](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#control_directives) provide flow and logic and give you a finite level of decision making required by mixins and functions.

In this guide, we will be covering: [@if](#if), [@for](#for), [@each](#each) and [@while](#while).

### Working Code

If you'd like to follow along using the compass project used to create this guide, check out [the working code](https://github.com/thesassway/if-for-each-while) on GitHub.

### @if

The `@if` control directive takes a [SassScript](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#sassscript) expression and processes its block of styles if the expression returns anything other than `false`.

Here's a fairly simple example of an `@if` control directive. I've simplified this example to be more readable, rather than usable.

    :::sass
    // Set a variable to run the if statement against
    $boolean: true !default

    =simple-mixin
      @if $boolean
        @debug "$boolean is #{$boolean}"
        display: block
      @else
        @debug "$boolean is #{$boolean}"
        display: none

    .some-selector
      +simple-mixin

Which emits this CSS:

    :::css
    .some-selector {
      display: block;
    }

Also notice that I've added `@debug` followed by a string in each flow option. This isn't core to this guide, but I've added this to show you how you can output a message to the command-line output log to let users know about certain events such as a [@warn](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#id9) or a [@debug](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#id8) as your code gets executed. For complex mixins and functions, this could come in handy to provide a better user experience and make it easier to spot and track down issues.

For example, if you ran this code this is what you would see in the command-line output.

    :::bash
    /Users/.../screen.sass:8 DEBUG: $boolean is true

### @for

The `@for` directive comes in two forms.

The first option is `@for $var from <start> through <end>` which starts at `<start>` and loops "through" each iteration and ends at `<end>`. Pretty straight forward.

The second option is `@for $var from <start> to <end>` which starts at `<start>` and loops through each iteration "to" `<end>` and stops. Once the directive hits the `<end>` it stops the looping process and does not evaluate the loop that one last time. Using the values mentioned in the example below, it's like saying "go from 1 to 4 and then stop".

In either case, the `$var` can be any variable name. Because this directive is often used to increment `$i` is often the name you will see as the `$var`.

Here's a fairly simple example of a `@for` control directive.

    :::sass
    $class-slug: for !default

    @for $i from 1 through 4
      .#{$class-slug}-#{$i}
        width: 60px + $i

Which emits this CSS:

    :::css
    .for-1 {
      width: 61px;
    }

    .for-2 {
      width: 62px;
    }

    .for-3 {
      width: 63px;
    }

    .for-4 {
      width: 64px;
    }

If you want to see a real world example of a `@for` directive, check out how I've used it in [Grid Coordinates](https://github.com/adamstac/grid-coordinates/blob/master/stylesheets/partials/_grid-coordinates-mixin.scss) to create a range of classes on lines 37-53.

Here's a sample of the code you'll see in that file.

    :::scss
    // Loops to enumerate the classes
    // Yep, this saves us tons of typing (if this were CSS)
    @for $i from 1 through $grid-columns {
      .grid-#{$i} { @include grid-base($i); @extend .grid-block; }
    }
    @for $i from 1 to $grid-columns {
      .grid-prefix-#{$i} { @include grid-prefix($i); }
    }
    @for $i from 1 to $grid-columns {
      .grid-suffix-#{$i} { @include grid-suffix($i); }
    }
    @for $i from 1 to $grid-columns {
      .grid-push-#{$i} { @include grid-push($i); }
    }
    @for $i from 1 to $grid-columns {
      .grid-pull-#{$i} { @include grid-pull($i); }
    }

### @each

The `@each` directive takes the form `@each $var in <list>`. If you haven't played with lists yet, get ready because this has just turned into a 2 in 1 lesson.

As you can see in the example below, `$var` can be any variable name, and `<list>` is a SassScript expression that returns a list. When processed, `$var` is set to each item in the list, and processes its block of styles using that value of `$var`.

Here's a fairly simple example of an `@each` control directive.

    :::sass
    $list: adam john wynn mason kuroir

    =author-images
      @each $author in $list
        .photo-#{$author}
          background: image-url("avatars/#{$author}.png") no-repeat

    .author-bio
      +author-images

Which emits this CSS:

    :::css
    .author-bio .photo-adam {
      background: url('/images/avatars/adam.png') no-repeat;
    }
    .author-bio .photo-john {
      background: url('/images/avatars/john.png') no-repeat;
    }
    .author-bio .photo-wynn {
      background: url('/images/avatars/wynn.png') no-repeat;
    }
    .author-bio .photo-mason {
      background: url('/images/avatars/mason.png') no-repeat;
    }
    .author-bio .photo-kuroir {
      background: url('/images/avatars/kuroir.png') no-repeat;
    }

### @while

The `@while` directive takes a SassScript expression (just like the other control directives) and repeatedly emits the nested block of styles until the statement evaluates to `false`. Much like the `@for` control directive, you are able to create very complex looping statements "while" a specific condition evaluates to `true`.

Here's a fairly simple example of a `@while` control directive.

    :::sass
    $types: 4
    $type-width: 20px

    @while $types > 0
      .while-#{$types}
        width: $type-width + $types
      $types: $types - 1

Which emits this CSS:

    :::css
    .while-4 {
      width: 24px;
    }

    .while-3 {
      width: 23px;
    }

    .while-2 {
      width: 22px;
    }

    .while-1 {
      width: 21px;
    }

## Conclussion

As you can see, Sass control directives will super-charge your mixins and functions to give you all the tools you need to make decisions, loop through and to, and provide the flow and control required to create awesome libraries.

Be sure to browse [the working code for this guide](https://github.com/thesassway/if-for-each-while) on GitHub.
