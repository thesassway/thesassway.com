---
date: 2012-03-26 16:15:00 -0500
categories: intermediate, guides
author: John W. Long
summary: One part suggestion to the Sass community to adopt a standard way of structuring Sass modules and one part show and tell. John attempts to leverage his knowledge of large Sass projects to suggest a format for a Standard Module Definition for Sass.
---

# A Standard Module Definition for Sass

Since becoming a fan of Sass, one thing that has bothered me is that not much has been written about best practices for structuring Sass projects. This is one of a series of articles we will be writing to talk about some of the things that folks are doing to make their projects better.

In this article, I'd like to kickstart the discussion on developing a <em>Standard Module Definition</em> for Sass. I'll start by sharing a couple of principles that I've found helpful for structuring Sass projects. (The principles here apply mostly to writing Sass for non-library code. We'll talk more about some ideas for structuring library modules in a future article.)

## 1. A module is a unit of code contained in a partial

I like to define modules in Sass partials. Since Sass doesn't currently have a way to namespace code, the easiest way to group code by function is to do so in a partial. One module per file. Example module names in typical projects might include: buttons, forms, lists, and typography.

## 2. Importing a module should never output code

I'm a strong believer in keeping your modules free of anything that would cause immediate CSS output. The idea is that you should be able to import any number of modules into your code-base and then make selective calls to control the output. This pretty much limits modules to mixins, functions, and variable definitions. (Sass 3.2 also introduces <em>placeholder selectors</em> which could also be used in a module definition.)

## 3. Each module should have a primary mixin

If appropriate, a primary mixin should be included in each module that outputs the standard usage of the module. This one is a little tricker to explain with words, so let me show you in code.

Here is an example `_buttons.scss`:

    :::scss
    // Primary mixin
    @mixin buttons {
      a.button, button {
        @include button(black, silver);
        &.blue  { @include button(white, blue); }
        &.red   { @include button(white, red); }
        &.green { @include button(white, green); }
      }
    }

    // Button mixin
    @mixin button($text-color, $bg-color) {
      font: 12px bold sans-serif;
      padding: 3px 8px;
      @include color-button($text-color, $bg-color));
      &:hover, &:focus { @include color-button($text-color, lighten($bg-color, 10%)); }
      &:active { background: darken($bg-color, 5%); }
    }

    // Color button mixin
    @mixin color-button($text-color, $bg-color) {
      color: $text-color;
      border: 1px solid mix(black, $bg-color);
      @include background-image(
        linear-gradient(
          lighten($bg-color, 5%),
          darken($bg-color, 5%)
        )
      );
    }

    ...

The idea here is that the buttons module includes all kinds of mixins for creating and styling buttons, but the primary mixin demonstrates and applies the default usage of the appropriate mixins. This makes it super simple to use the default behavior for a module in a stylesheet.

Here's an example of how I often combine modules in my main stylesheet:

    :::scss
    .content {
      @include typography;
      @include buttons;
      @include lists;
      @include forms;
      ...
    }


## 4. The name of the primary mixin should inherit the name of the module

I'd recommend that you try to pluralize your module names, where appropriate, and the name of your main mixin for that module should be the same as the name of the module itself. This simple naming convention will make it easy to import and use your modules without thinking hard about the names.


## 5. Variable definitions should always be defaulted

If a module defines top-level variables, they should always be defined with the `!default` directive. This will make it much easier to override those variables in a theme stylesheet or when reusing the module for other purposes.

Here's an example of using the `!default` directive to declare defaults for variables within a module:

    :::scss
    $base-font-family: Helvetica, Arial, sans-serif !default;
    $fixed-font-family: monospace !default;


## 6. Almost all project CSS should be written in modules

I like to code almost all of my CSS in modules using this pattern. This makes it much easier to reuse styles across stylesheets for a given project or even to share code between projects. It also helps me think about my code in a modular way from the very beginning -- a discipline that I find quite helpful.

For me, modules have become the basic units or building blocks of my Sass projects. What practices do you find helpful for structuring your own projects?
