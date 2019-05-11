---
date: 2050-11-29 02:00:00 -0600
categories: projects
author: Adam Stacoviak
summary: WordPress is a great tool for building a fully customizable blog. Now you can make it even better by adding Sass and Compass support using this simple plugin.
---

# Font Stacks, a Sassy font stack library

WordPress is a great tool for building a fully customizable blog. With custom themes, you gain full control over almost all aspects of your blog, including your markup and styles. Wouldn't it be great if you could use Sass and Compass as well?

<a href="https://github.com/adamstac/font-stacks"><img src="/attachments/font-stacks.png" class="full" /></a>

## Sass for WordPress

I created a very straight forward plugin for WordPress called [Sass for WordPress](https://github.com/roytomeij/sass-for-wordpress/) which watches for changes to your Sass files and re-compiles your CSS when needed.

Where for instance [Forge](/projects/forge) is great to develop and compile complete themes using Sass, the Sass for WordPress plugin is a simple drop-in replacement when you only want to transform your CSS to Sass.

## Installation and usage

All the Sass for WordPress plugin requires is having Sass and Compass installed and making sure PHP isn't running in safe mode. This is needed because PHP needs to be able to execute the `exec()` function, which is used to invoke the Sass-to-CSS compiler. Don't worry, all arguments that get sent to the shell from the plugin are properly escaped.

Adding Sass support to your theme is as easy as installing the plugin to your plugins folder and enabling it in your plugins pane. Since you probably can't or don't want to install the Sass and Compass gems on your hosting environment, I recommend you to run the plugin locally when developing your theme(s) and upload the compiled CSS along with the reset of your theme.

### Link to your stylesheet

Link to your stylesheet with this code.

    :::php
    <link rel="stylesheet" href="<?php sass('stylesheets/scss/screen.scss')" type="text/css" />

The `sass()` function takes care of everything from here, including returning the complete path to the compiled CSS. The only parameter it takes is the path to your Sass file, in this case it will look for `style.scss`. To use the original Sass syntax replace `style.scss` with `style.sass`.

### The WordPress Theme Stylesheet

WordPress requires a file named `style.css`, aka the [theme stylesheet](http://codex.wordpress.org/Theme_Development#Theme_Stylesheet), located at the root of your theme used to identify your theme. You're going to want to keep that. :)

### Sample Sass structure in WordPress

Here's a snapshot of the terminal output of `tree .` ran inside of a theme using the Sass for WordPress plugin. I've omitted the mention of all the other theme files and just left what was needed to show off the hierarchy regarding adding Sass and Compass.

    :::bash
    |-- config.rb
    |-- style.css
    `-- stylesheets
        |-- css
        |   |-- print.css
        |   `-- screen.css
        `-- scss
            |-- print.scss
            `-- screen.scss

### Compass

[Compass](http://compass-style.org/) is the standard library of Sass and adds awesome [CSS3 mixins](http://compass-style.org/reference/compass/css3/), a number of [helper functions](http://compass-style.org/reference/compass/helpers/), [reset utilities](http://compass-style.org/reference/compass/reset/utilities/) and much more.

Simply use `@import "compass";` as you normally would to add Compass to your Sass stylesheet. If a `config.rb` file doesn't exist it will be created on first run. Likewise, if you're going the route of the stylesheet structure mentioned above, you'll need to set a few Compass variables.

    :::ruby
    # Sass and CSS locations
    sass_dir              = 'stylesheets/scss'
    css_dir               = 'stylesheets/css'

## Links

* [Source on GitHub](https://github.com/roytomeij/sass-for-wordpress/)
* [Forge, a WordPress theme development toolkit with Sass and CoffeeScript](/projects/forge)
* [Getting started with Sass and Compass](/beginner/getting-started-with-sass-and-compass)
