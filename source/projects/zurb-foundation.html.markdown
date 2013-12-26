---
Date: 2011-12-22 14:30:00 -0600
Categories: projects, adam-stacoviak
Author: Adam Stacoviak
Summary: What do you get when combine the power of Sass with Zurb? You get Zurb Foundation for Sass and Compass. It's the perfect flexible grid, desktop to mobile responsive, forms, buttons and UI library, plus other ZURB Playground favorites like Orbit and Reveal.
---

# Zurb Foundation, for Sass and Compass

What do you get when combine the power of Sass with Zurb? You get Zurb Foundation for Sass and Compass.

<a href="http://foundation.zurb.com/"><img src="/attachments/zurb-foundation.png" class="full" /></a>

## Foundation is awesome.

I come out of the gate saying, "Foundation is awesome." It's the perfect flexible grid from desktop to mobile.

Foundation includes forms, buttons, and a UI library. Plus other [ZURB Playground](http://www.zurb.com/playground) favorites like [Orbit](http://www.zurb.com/playground/orbit-jquery-image-slider) and [Reveal](http://www.zurb.com/playground/reveal-modal-plugin).

With [case studies](http://foundation.zurb.com/case-foundation.php) like [ZURB Jobs](http://www.zurb.com/jobs), [Swizzle](http://foundation.zurb.com/case-swizzle.php) and [the Foundation site itself](http://foundation.zurb.com/case-foundation.php), how can we deny ZURB of hitting this one out of the park?

<a href="http://www.getswizzle.com/"><img src="http://foundation.zurb.com/images/case-swizzle.jpg" class="full" /></a>

## Foundation's Features

ZURB Foundation features a set of global styles that include Eric Meyer's reset, tested styles for typography, links, lists, tables and more.

* [The Grid](http://foundation.zurb.com/grid.php), built for [rapid prototyping](http://foundation.zurb.com/prototyping.php) and [mobility](http://foundation.zurb.com/mobile.php)
* Various [layout](http://foundation.zurb.com/docs/layout.php) options
* [UI Elements](http://foundation.zurb.com/docs/ui.php)
* [Buttons](http://foundation.zurb.com/docs/buttons.php) and [forms](http://foundation.zurb.com/docs/forms.php)
* Plus [playground](http://www.zurb.com/playground) favorites [Orbit](http://www.zurb.com/playground/orbit-jquery-image-slider) and [Reveal](http://www.zurb.com/playground/reveal-modal-plugin)

And ZURB didn't stop there, they did an awesome job showing off [the documentation](http://foundation.zurb.com/docs/index.php) too. You can learn about all the features of Foundation, as well as how to use it on mobile and desktop displays.

## Installation

From your Terminal ...
    
    :::bash
    (sudo) gem install ZURB-foundation
    
If you use [Bundler](http://gembundler.com/), simply add `ZURB-foundation` to your `Gemfile` and `bundle install`.

    :::bash
    gem 'ZURB-foundation'
    
Form here, you have a few options on getting started with ZURB Foundation. You can start a Compass-based project with ZURB Foundation or you can install ZURB Foundation into an existing Compass-based project.

### Start a Compass-based project with ZURB Foundation

You can start a brand new project using Compass and ZURB Foundation with the following `compass` command.

    :::bash
    compass create <project-name> -r ZURB-foundation --using ZURB-foundation --force

If you'd like to require ZURB Foundation to install using a particular Sass syntax, use the Compass `--syntax` flag. Here's an example.

    :::bash
    compass create <my_project> -r ZURB-foundation --using ZURB-foundation --syntax sass --force

### Install ZURB Foundation into an existing Compass-based project

You can install ZURB Foundation into an existing project with Compass in place already.

    :::bash
    compass install ZURB-foundation/project

Running this will unfurl a number of files from the ZURB Foundation gem using the Compass framework.

    :::bash
    -> % compass install ZURB-foundation/project
    directory images/misc/ 
    directory images/orbit/ 
    directory javascripts/ 
    directory sass/ 
    directory stylesheets/ 
       create sass/app.scss 
       create sass/ie.scss 
       create javascripts/app.js 
       create javascripts/forms.jquery.js 
       create javascripts/jquery.customforms.js 
       create javascripts/jquery.min.js 
       create javascripts/jquery.reveal.js 
       create javascripts/jquery.orbit-1.3.0.js 
       create javascripts/jquery.placeholder.min.js 
       create index.html 
       create humans.txt 
       create robots.txt 
       create MIT-LICENSE.txt 
       create images/misc/button-gloss.png 
       create images/misc/button-overlay.png 
       create images/misc/custom-form-sprites.png 
       create images/misc/input-bg.png 
       create images/misc/modal-gloss.png 
       create images/misc/table-sorter.png 
       create images/orbit/bullets.jpg 
       create images/orbit/left-arrow.png 
       create images/orbit/loading.gif 
       create images/orbit/mask-black.png 
       create images/orbit/pause-black.png 
       create images/orbit/right-arrow.png 
       create images/orbit/rotator-black.png 
       create images/orbit/timer-black.png 
       create stylesheets/app.css 
       create stylesheets/ie.css 


## Awesome examples to check out

* [A prototype of Google+](http://foundation.zurb.com/prototype-example2.php)
* [All grid sizes](http://foundation.zurb.com/grid-example1.php)
* [Nesting the grid](http://foundation.zurb.com/grid-example2.php)
* [The mobile grid](http://foundation.zurb.com/mobile-example1.php)

## Links

* [ZURB Foundation](http://foundation.zurb.com/)
* [Foundation Sass](https://github.com/zurb/foundation-sass) on GitHub
* [Foundation Docs](http://foundation.zurb.com/docs/)