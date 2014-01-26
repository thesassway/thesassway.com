---
date: 26 Jan 2014
categories: beginner, guides
author: Frank S
summary: Learn how to keep variable names organized and modular.
---

# Variable Naming

Variables in Sass is a very powerful way to define values that get used in multiple places
in your project. They allow you to make quick and easy changes from a central point without
having to do cumbersome find and replace substitutions across multiple files and directories.

But... **Naming Things is Hard!**

It is very easy for variable names to spiral out of control, and before you know it the benefit is lost
because those variables are hard to recall and end up causing more frustration than benefit.

However, by following some simple guidelines you can maintain control... and your sanity!

## Function Over Description

Imagine for a moment that you client's primary brand color is red and you called that
variable `$red`. Six months go by and the marketing department decides to re-brand the company
and the primary brand color is now blue.

Changing the value of `$red` is easy enough, but the variable has no description of its
intended purpose.

Instead of describing what a variable looks like, describe its function.

    :::scss
    // Bad
    $red: red;
    $yellow: yellow;

    // Good
    $brand: red;
    $accent: yellow;

## Be Specific

I like to name my variables by arranging descriptive words from generic to specific.

The real benefit of specificity is the grouping of variables that share commonality, and
this makes them easier to read and recall.

    :::scss
    // Base colors
    $color-base: #333;
    $color-brand: red;
    $color-brand-80: rgba($color-brand, 0.8);
    $color-accent: yellow;

    // Header
    $header-height: 100px;
    $header-background-color: $color-brand;

    // Footer
    $footer-height: 200px;
    $footer-background-color: #AAA;

## Keep a Centralized Config

*This is more an organizational tip than a naming tip.*

I like to keep all my variables in a single file, called `_config.sass`, that I include in my primary stylesheet using the `@import` directive.

Every other file that gets included after my config file will have access to those variables.

    :::scss
    @import base/config;
    @import base/typography;
    @import base/utilities;

    @import modules/button;

## Conclusion

There are many opinions on how to name things in software, but what is truly important
is that you find a convention that works for you and your team and that it will ensure easy
extension and updating of your project's stylesheets.

