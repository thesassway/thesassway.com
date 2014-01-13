---
date: 9 October 2019
categories: advanced, guides
author: Scott Kellum
about_author: scott_kellum
summary: Sass provides so much power, but how can it be leveraged to create frameworks.
---

# Building a styling framework with Sass

Over the past few years, the “CSS framework” topic has been one of the hottest topics. There have been a number of permutations of CSS grid frameworks; fixed, fluid, elastic, responsive … you name it. To most seasoned front-end veterans, the topic of CSS frameworks isn’t new. Styling frameworks have been big for good reason. Building a foundation of styles for each new project can be tedious and repetitive.  However, I have always shied away from traditional CSS frameworks as they never completely satisfy all the needs of a particular project, as well as containing code to deal with things not used in any given project.

Sass easily solves all of these gripes with CSS frameworks by creating a platform where nothing is set in stone. Instead of taking a framework and using it as-is, a well designed Sass framework opens the doors for expression well beyond the predefined setup it arrives to you in.

After publishing a highly specialized styling framework, [Seasons](https://github.com/scottkellum/Seasons), a boilerplate for [Treesaver](http://treesaverjs.com), I started understanding how new frameworks built on Sass should behave. When leveraging the power of Sass every aspect of the framework should be customizable and extensible.

## Building a modular framework
Every front-end developer I know does things slightly different from the next. Weather it is using a different reset or that piece of code you always find yourself writing, breaking your project into smaller files to keep things organized is something that shouldn’t be done in CSS, but because Sass rolls everything into one flat file chopping everything up can be useful. Using booleans is another way to modularize. Most people aren’t going to dig into your folder structure to dig out the pieces they don’t want. Instead simple true/false statements and a configuration file can help cut and add features to the users liking. Not a fan of the bundled reset? Just write ´$reset: false´.  This will allow the framework to add more features while curbing the bloat.

## Building a customizable grid
Instead of pulling out a calculator have Sass to the heavy lifting when it comes to the measurements of the grid. While you may want to jump into the loops the logic behind those loops is more important. [Susy](http://susy.oddbird.net/) does a fantastic job of [setting up grid logic](https://github.com/ericam/compass-susy-plugin/blob/master/sass/susy/_grid.scss) creating values a developer can pull from as needed. Logic should be based around three key variables for a standard vertical grid: $column or the width of a grid unit; $gutter, the space between grid units; and $margin, the distance between the edge of the page and the content. These elements of page layout have been around for centuries and do wonders in aiding design. I like to [keep things simple](https://github.com/scottkellum/Seasons/blob/master/sass/lib/tools/_grid-tools.sass) with a single function doing all the work and a mixin for quick placement. When writing a framework generally enough the same logic can be used to create a responsive or fixed layout by changing the unit of measure. Percents can be broken into columns just as easily as pixels can.

## Looping it through
Now the core logic is written for the grid, there isn’t much actually written to layout your page. If a complex site is in the works it might be beneficial to have pre-built classes to help snap items on a grid. [Loops](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#id11) make it insanely easy to flush out all the values needed to build a site on a grid.

## Piling on the extras
Most frameworks come in two-forms, the plain pizza or the meat lovers with everything piled on. Chances are you really would like a little something extra or less. Fortunately we talked about those booleans, but what optional extras should be included? We already have [Compass](http://compass-style.org/) which is an incredible collection of ad-on functionality to Sass. However there are probably some framework-specific ad-ons that will be beneficial. Building support for cir tan page types, elements that may float off the grid or page, a vertical grid and any bonus features like light boxes can add value to your framework. If it’s too much it can always be turned off. Tools that aren’t user-facing are also important. I like to include a [set of mixins](https://github.com/scottkellum/Seasons/blob/master/sass/lib/tools/_basic-functions.sass) to help with basic typography and debug projects.

## Polish and extensibility
In the end frameworks need to be extensible. Not just the start of projects but a basis for clean and maintainable code. Modularizing, again, is the key to this but it needs to be left open to growth and maintenance. With Seasons I have an independent skin for page styles, chrome for the user interface, and beyond that a plugins folder to anything that might be added as core functionality, outside the core files. Balancing and polishing the way the core framework files and the user styles interact is extremely important to the health of a framework. When done correctly updating the framework underneath a design or swapping skins can become completely seamless.
