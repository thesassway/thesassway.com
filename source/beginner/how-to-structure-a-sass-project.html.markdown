---
Date: 3 April 2013
Categories: beginner, guides, john-w-long
Author: John W. Long
Summary: One of the coolest features of crafting CSS with Sass is that you can build out a file structure that puts all your components in their right place. BUT the question is ... where is the right place? Is there a standard way to structure your Sass files?
about_author: john_w_long
---


# How to structure a Sass project

One of the most useful features of Sass is being able to separate your stylesheets into separate files. You can then use the `@import` directive to include the source of your individual files into one master stylesheet.

But how should you structure your Sass projects? Is there a standard way of separating out your CSS files?


## Basic directory structure

I like to layout my Sass projects like this:

    :::text
    stylesheets/
    |
    |-- modules/              # Common modules
    |   |-- _all.scss         # Include to get all modules
    |   |-- _utility.scss     # Module name
    |   |-- _colors.scss      # Etc...
    |   ...
    |
    |-- partials/             # Partials
    |   |-- _base.sass        # imports for all mixins + global project variables
    |   |-- _buttons.scss     # buttons
    |   |-- _figures.scss     # figures
    |   |-- _grids.scss       # grids
    |   |-- _typography.scss  # typography
    |   |-- _reset.scss       # reset
    |   ...
    |
    |-- vendor/               # CSS or Sass from other projects
    |   |-- _colorpicker.scss
    |   |-- _jquery.ui.core.scss
    |   ...
    |
    `-- main.scss            # primary Sass file


## Primary stylesheet

This allows me to keep my primary Sass file extremely clean:

    :::scss
    // Modules and Variables
    @import "partials/base";

    // Partials
    @import "partials/reset";
    @import "partials/typography";
    @import "partials/buttons";
    @import "partials/figures";
    @import "partials/grids";
    // ...

    // Third-party
    @import "vendor/colorpicker";
    @import "vendor/jquery.ui.core";


## Modules, partials, and vendor

As you can see this divides my project into three basic types of files. Modules, partials, and vendored stylesheets.

* The **modules** directory is reserved for Sass code that doesn't cause Sass to actually output CSS. Things like mixin declarations, functions, and variables.

* The **partials** directory is where the meat of my CSS is constructed. A lot of folks like to break their stylesheets into header, content, sidebar, and footer components (and a few others). As I'm more of a [SMACSS](http://smacss.com/) guy myself, I like to break things down into much finer categories (typography, buttons, textboxes, selectboxes, etc...).

* The **vendor** directory is for third-party CSS. This is handy when using prepackaged components developed by other people (or for your own components that are maintained in another project). jQuery UI and a color picker are examples of CSS that you might want to place in the vendor directory. As a general rule I make it a point not to modify files in my vendor directory. If I need to make modifications I add those after the vendored files are included in my primary stylesheet. This should make it easy for me to update my third-party stylesheets to more current versions in the future.


## Using a base partial

In my partials directory you will also notice that I have a base partial. The purpose of this partial is to load up my Sass environment so that it's easy to construct a stylesheet.

It might look something like this:

    :::scss
    // Use Compass ('cause it rocks!)
    @import "compass";

    // Font weights
    $light: 100;
    $regular: 400;
    $bold: 600;

    // Base Font
    $base-font-family: sans-serif;
    $base-font-weight: $regular;
    $base-font-size: 13px;
    $base-line-height: 1.4;

    // Fixed Font
    $fixed-font-family: monospace;
    $fixed-font-size: 85%;
    $fixed-line-height: $base-line-height;

    // Headings
    $header-font-weight: $bold;

    @import "modules/all";

The base stylesheet sets a couple of global variables and loads up all of my Sass modules. Again modules are not allowed to contain anything that would cause CSS output when importing. Tying all of my varibles and modules up into a base partial gives me access to my entire Sass environment whenever I'm setting up a new stylesheet with a single import statement. This allows me to build multiple stylesheets by importing different partials. Multiple stylesheets are handy once a project grows to a certain size.


## One step further

At [UserVoice](http://uservoice.com) we take this pattern one step further. Since we have multiple sub-projects all bundled together in a single Rails app, we bundle each sub-project into a separate top-level directory. Our stylesheet directory looks more like this:

    :::text
    stylesheets/
    |
    |-- admin/           # Admin sub-project
    |   |-- modules/
    |   |-- partials/
    |   `-- _base.scss
    |
    |-- account/         # Account sub-project
    |   |-- modules/
    |   |-- partials/
    |   `-- _base.scss
    |
    |-- site/            # Site sub-project
    |   |-- modules/
    |   |-- partials/
    |   `-- _base.scss
    |
    |-- vendor/          # CSS or Sass from other projects
    |   |-- _colorpicker-1.1.scss
    |   |-- _jquery.ui.core-1.9.1.scss
    |   ...
    |
    |-- admin.scss       # Primary stylesheets for each project
    |-- account.scss
    `-- site.scss

As you can see each sub-project has it's own primary stylesheet, modules, partials, and base. Vendored stylesheets are typically versioned and have their own top-level directory. This is a handy pattern to use on very large Sass projects.


## Further exploration

Now that I've laid out my own method for this, you may want to explore how other people have structured their Sass projects. There's actually a lot of variation in what you can do here. And some methods may work better on different projects:

* [Compass](https://github.com/chriseppstein/compass/tree/stable/frameworks)
* [Breakpoint](https://github.com/lesjames/breakpoint/tree/master/breakpoint)
* [Octopress](https://github.com/imathis/octopress/tree/master/.themes/classic/sass)
* [Sass Twitter Bootstrap](https://github.com/jlong/sass-twitter-bootstrap/tree/master/lib)

Also check out Dale Sande's excellent article, [_Clean out your Sass junk drawer_](http://gist.io/4436524).
