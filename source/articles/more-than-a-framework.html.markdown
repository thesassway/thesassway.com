---
Date: 2099-01-14 00:00:00 +0100
Categories: articles, scott-kellum
Author: Scott Kellum
Summary: Sass is the perfect foundation for frameworking. With all the power in Sass it is important to know how to apply it to create something truly amazing, maybe even ask yourself if Sass can create something that is more than a framework.
---

# More than a Framework

The potential of Sass can be seen in small code examples using variables, mixins, and other features but it shines when all these parts start working together. Where CSS frameworks fail, Sass creates openings that allow for agile code to adapt to every users needs. With this power comes responsibility and bloat in the compiled CSS easily creep up. However well considered Sass can provide a foundation above and beyond anything else.

## Where CSS frameworks fail

The flat nature of CSS prevents it from being able to fit everyones needs. CSS frameworks provide an excellent foundation for a lot of people but chances are they will probably fit your site like a cheap suit without a lot of extra tailoring. Most projects require slightly different features and grids and while working within the box may be fast for prototyping things just need to be built from the ground up with CSS. If you decide to go with a more complex framework with all the bells and whistles people visiting your site have to load that extra weight every time. Blueprint is 12KB of CSS, 960.gs comes in at a nice 6KB for the core style sheet, and Twitter Bootstrap (minified) comes in at a whopping 47KB. Granted, Bootstrap has tons of goodies where 960.gs is more of a no frills framework. With no ability to scale or adjust metrics in development CSS can fall flat when it comes to frameworks.

## Scaling up with Sass

Sass provides the tools to create scalable frameworks that can fit every front end development need while trimming the fat on the features you might not use. By modularizing parts can be loaded as needed or turned off to output the most optimized code possible. These same tools also help to make frameworks flexible for users who might want to build on something other than a 960px grid or 12 columns. By generating all the core code on the fly based on simple logic every aspect of these frameworks can be fine-tuned to meet every need. A simple variable change can recalculate a grid for 14 columns at 1400px wide to a 24 column fluid grid. With expressions in Sass, it is often a matter of dividing one value by another to achieve grid logic that can adapt to every need.

## Think the big thoughts

Before touching code as yourself why are you building a framework and what do you want to achieve? Has something similar been done before and why not start contributing to that project? Chances are, if you are developing something new from the ground up then other solutions aren’t working for you. Identifying those things that work and don’t work as well as new functionality will help steer you towards your goals and creating a better, more cohesive framework.

## A modular foundation

Every great Sass framework is built to be modular. Unlike with CSS, files can be fragmented and organized deep into a file tree. Mixins and function tools can be kept separate from core layout logic and styles. One part can be easily swapped out for another making it easy to work with groups or enable easier 3rd party customization. As organization gets better so do the compiled stylesheets.

Not only can files be modularized but features can be turned on and off through various means. [Susy](http://susy.oddbird.net/) provides some excellent grid tools that can be loaded as needed via mixins or functions. This gives you the ability to load only what you need.

I prefer to work with configuration files and load everything through true/false statements like `$clearfix: true` to write the clearfix class. Unfortunately conditional loading isn’t available in Sass but wrapping code within `@if` statements allows you to write it if the variable has a value of true. A config file can centralize the other settings used in your framework so editing your grids, color schemes, and whatever other settings are set in one place overriding `!default` values elsewhere.

## Object Oriented Sass

OOCSS is a beautiful thing for CSS authoring. It is semantic and organized. Sass makes generating OOCSS grids easy with [control directives](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#control_directives) but this can start generating a lot of code, especially taking into account [responsive web design](http://chriseppstein.github.com/blog/2011/08/21/responsive-layouts-with-sass/). Responsive web design needs to remain flexible and layouts based on classes can be difficult to change as well as ridiculously verbose. By using a semantic name and creating Sass objects that apply to those objects flexibility can be preserved while keeping the flat CSS and HTML file size down.

When generating an OOCSS grid all the points on that grid are written to classes. These classes are applied to HTML to snap them into place. If they are to be overridden then more classes need to be generated to override on an `@media` rule. Class lists start growing exponentially as break-points are introduced. However, using functions that contain grid measurements HTML elements can be targeted individually and are not fixed to a point on the grid. Where there is overlap `@extend` can group redundant code. `@media` rules can be applied where they are applicable allowing for more natural transitions to different screen sizes.

Using [simple grid functions](https://github.com/scottkellum/universal-grid/blob/master/sass/lib/_grid.sass) I managed to squeeze not just a grid system but a range of styles into a responsive framework that compiles to [just 7kb of un-minified CSS](https://github.com/scottkellum/universal-grid/blob/master/html/_/css/style.css).

Nothing should be taken as gospel in a space that is evolving as quickly as the web. The strict OOCSS approach does wonders for [some frameworks](https://github.com/scottkellum/Seasons). The point is to figure out what works best for you and identify the strengths and pitfalls of different techniques.

## Fill your toolbox

If you have been working with Sass for a while, chances are you are using a lot of mixins and functions that do various things. Weather it is writing CSS3 or adjusting typography these little tools can make a big impact. With no code being generated from the tools themselves there is no reason not to fill up a folder with dozens of tools. If you are working with Compass, you have an incredible library of tools at your fingertips. However, remaining aware of all these mixins and functions can be difficult as things get more complex. Currently, Sass doesn’t allow conditional loading or asking weather a file has been included or not. However, writing variables to indicate a tool is loaded can help your framework [intelligently adapt to additional features](https://github.com/Snugug/Aura/commit/0f42218295ec5119ce01f4dde4ce320c4064078b) when they are available by simply writing conditions if that variable is true.

## More than frameworks

Sass opens the doors to incredible things when it comes to frameworking. Could these new Styling systems created with Sass be even more than frameworks? We are able to create such extensive libraries that are incredibly flexible. Like the leap from HTML to Ruby/PHP, Sass is a leap from CSS and allows us to create elegant style management systems. These systems can help us build sites to any spec rapidly and efficiently while, if it was built well to begin with, will produce clean and concise CSS.
