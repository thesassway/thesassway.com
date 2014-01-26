---
date: 26 Jan 2014
categories: beginner, guides
author: Frank S
summary: Sass makes it easy to reuse common values with variables. But if you're not careful your variable names can spiral out of control. Frank S debuts his first article on *The Sass Way* with some helpful advice on naming your variables.
---

# Choosing great variable names

Variables in Sass are a powerful way to define values in one place that can be reused in
multiple places in your project. They allow you to make changes from a central point
without needing to use find and replace across multiple files and directories.

But... **Naming things is hard!**

If you're not careful, it's very easy for variable names to spiral out of control. Before
you know it the benefit is lost because those variables are hard to recall and end up
causing more frustration than benefit.

However, by following some simple guidelines you can maintain control... and your sanity!


## Use semantic variable names

Imagine for a moment that you client's primary brand color is red and you called that
variable `$red`. Six months go by and the marketing department decides to re-brand the company
and the primary brand color is now blue.

Changing the value of `$red` is easy enough, but the variable has no description of its
intended purpose.

Instead of describing what a variable looks like in the name, describe its function or
purpose. In other words, try to choose semantic names for your variables.

    :::scss
    // Bad
    $red: red;
    $yellow: yellow;

    // Better
    $brand-color: red;
    $accent-color: yellow;


## Adopt useful conventions

It's important to come up with some good conventions for naming your variables so that they
are easy to remember.

For example, you can postfix color names with `-color`:

    :::scss
    // Base colors
    $base-color: #333;
    $brand-color: red;
    $brand-80-color: rgba($color-brand, 0.8);
    $accent-color: yellow;

Or, add a prefix like `header-` or `footer-` for specific sections:

    // Header
    $header-height: 100px;
    $header-background-color: $color-brand;

    // Footer
    $footer-height: 200px;
    $footer-background-color: #aaa;


## Keep a centralized config

I like to keep all my variables in a single file, called `_config.scss`, that I include in
my primary stylesheet using the `@import` directive. This way, every other file that gets
included after my config file will have access to those variables.

    :::scss
    @import base/config;
    @import base/typography;
    @import base/utilities;

    @import modules/button;


## Conclusion

There are probably a lot of opinions on how to name things in Sass, but what's really important
is that you find conventions that work for you and your team. Choosing good variable names will
make it much easier to maintain your project's stylesheets.
