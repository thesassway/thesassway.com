Date: 2019-10-03 21:27:07 -0500
Categories: advanced, guides, scott-kellum
author: Scott Kellum
summary: If you're a fan of the classic Penner equations by Robert Penner, made famous by Flash and jQuery. You are going to love Compass Ceaser Easing by Jared Hardy, also known for his Sassy Buttons project.

# Building a CSS framework with Sass

Over the past few years, the "CSS framework" topic has been one of the most hottest topics. There have been a number of permutations of CSS grid frameworks; fixed, fluid, elastic, responsive ... you name it. To most seasoned front-end veterans, the topic of CSS frameworks isn't new. But, let's face it. Building a foundation of styles for each new project can be tedious and repetitive. But not with Sass.

## Why do we use CSS Grid Frameworks?

Frameworks like [Blueprint](http://www.blueprintcss.org/), [960 Grid System](http://960.gs/), [Grid Coordinates](https://github.com/adamstac/grid-coordinates) and [Susy](http://susy.oddbird.net/) have created ways for designers to skip the repetitive, mundane and most importantly the math. With a CSS framework, front-end devs and designers can get a site laid out relatively quick with a minimal number of bugs, on top of a heavily tested code base.

## Treesaver Boilerplate

At my day job I work with a company called [Treesaver](http://treesaver.net) where we build magazine-style websites in HTML5 with an amazing bit of, "self-titled", JavaScript called [Treesaver](https://github.com/Treesaver/treesaver). When I started with Treesaver a little over a year ago, that amazing bit of JavaScript and the ever transforming HTML5 spec was just about all we had to work with. All our HTML5 templates, JavaScript and CSS stylesheets were custom built from the ground up. In order to rapidly create the magazine-style websites we needed to develop, I immediately knew we needed to develop a custom CSS framework robust and flexible enough to support a wide array of grid layouts.

### Sass, the perfect fit for creating CSS frameworks

I was introduced to Sass by my boss. Having access to variables, mixins, nested selectors and selector inheritance was quite literally *impossible* with vanilla CSS. Needless to say, I picked up Sass with a grin from ear to ear and just ran with it. The result? [Seasons](https://github.com/scottkellum/Seasons), a boilerplate for our self-titled JavaScript library [Treesaver](https://github.com/Treesaver/treesaver).

I immediately got into the variables and operations to calculate the grid. At the time I was tasked with designing and building about 5 publications, with slightly different grid measurements. I developed the core logic to determine all the math instead of pulling out the calculator for every calculation. Once I was done, all I had to do was swap out a class for the skin and voila. Magic! Everything updated to the new skin and grid layout.

## Every new project brought new challenges

Of coarse our challenges didn’t stop there. Each new project added new challenges to the table. The core code was refined to a series of simple loops, image sizing was added and positioning was greatly improved. When adding a vertical grid, even the semantics of `$column` was brought into question and changed to `$module-w` based on [Mark Boulton’s](http://twitter.com/#!/markboulton) article, [rethinking grids](http://www.markboulton.co.uk/journal/comments/rethinking-css-grids). The Sass looked nice and clean but the CSS output was starting to get hefty. Bloated CSS is a know problem with frameworks. They tend to just keep growing to satisfy every need, and making things more generalized and lean was a great ordeal. So I turned to Sass’s boolean features enable entire portions of the framework to be able to turn on and off. Sexy!

Before diving too deep into the code, Treesaver creates a number of unique challenges. All the HTML for layout exists in one file, resources.html. All the content is stripped from the `<article>` tags of pages. and placed into these “grids”. This manipulation of the DOM by the Treesaver JavaScript can be tough to figure our where some objects are placed. If that isn’t enough, the layouts are algorithmically chosen based on the amount and kind of content that can fit on each page. With all this complexity, the reasons for releasing a boilerplate were adding up.

All projects should start on a grid, but with grid layouts being defined in a separate file from the content grids need to be generated so the designer can do the taboo, layout in the HTML. That said, its just a matter of simple configurable loops to generate the output needed. These loops calculate for classes that position elements across the grid, So if I wanted an element to start on column 3 with a width of 4 columns it would be named `<div class="c3 w4">`. Maybe you want to turn the vertical grid on and position it 2 rows down? Add the `class r2`. It all sounds good so far but what if a project needs no less than a 30 column grid for some reason? Or a column width of 3px? These values may sound absurd but this framework is written in Sass so we have no excuse for locking down any values.

    :::sass
    // GRID MEASURMENTS
    @for $i from 1 through $columns // loop defines columns. c1, c2, c3 . . .
      .c#{$i}
        margin-left: grid($i) - $module-w
    @for $i from 1 through $columns // loop defines widths. w1, w2, w3 . . .
      .w#{$i}
        width: grid($i)

    // Vertical grid
    $vertical-grid: false !default
    $rows: 10 !default
    @if $vertical-grid // Generate only if $vertical-grid is true. This code is usually not nessisary.
      @for $i from 1 through $rows // loop defines rows. r1, r2, r3 . . .
        .r#{$i}
          position: absolute
          top: (grid($i, $module-h) - $module-h) + $top
      @for $i from 1 through $rows // loop defines heights. h1, h2, h3 . . .
        .h#{$i}
          height: grid($i, $module-h)

Image resizing has been the trickiest part in creating Seasons. In order for Treesaver to calculate the layouts it needs to know the dimensions of each element, and while the dimensions of different sized images can be defined in the content, complex layouts would require about twelve different images to be defined in the content, something that was just getting too hard to manage. Now Sass is great at looping through and calculating ways to resize these images but can result in bloat just as easily. In fact, the earlier code was taking about 50k just to resize images! Pulling on nested mixins in the configuration containing the ratios used throughout the publication. Using a custom selector for ratio instead of a class targeting measurements for various page along with image ratios became smaller while supporting more use-cases.

    :::sass
    @mixin ratios
      +ratio(16, 9)
      +ratio(4, 3)

    // IMAGE + PAGE RATIOS
    =ratio($width, $height, $cols: $columns)
      @for $i from 1 through $cols
        .r#{$width}x#{$height}.w#{$i}, .container.w#{$i} [ratio="#{$width}x#{$height}"] img // Grid ratio, figure ratio.
          width: grid($i) // Width spans all columns
          height: round(grid($i) * ( $height / $width )) // Height is the proportion of the width.

    +ratios // Run the code above. Ratios are defined in _config.sass

Creating powerful layout tools that don’t add heft to your file is another great point of creating a Sass framework. Creating tools for people to simply use the grid and control typography are just as if not more important for frameworks than just caring about the generated grids. Users should have as much control over aspects of layout from the stylesheets as they do with the classes the framework generated. For example grid is added as a function that generates different values based on the grid to use in stylesheets. Debug tools are another add-on that highlight elements. Ever made an element bright red just to see if it was showing up on the page at all? Well one-letter mixins `r`, `g`, `b`, `c`, `m`, and `y` will highlight elements in a verity of colors so you can quickly debug layouts. Also, throwing in some modular-scales, sprites, and CSS3 mixins for some fantastic layout possibilities. Want a list? you can find it [here](https://github.com/scottkellum/Seasons/wiki/Sass-functions-and-mixins)

Now configuring this monster may seem like a tall order, but it’s not that bad. Using the `!default` not everything needs to be defined. In fact, out of the box Seasons is set up so it works, no need to change anything unless you want a value changed. The nature of frameworks is to be bloated, but the config allows you to trim out a number of features you may not wish to use. Not using fullbleed figures or inset captions, or want to write your own variation? Just turn them off in the config. Building styling frameworks in Sass is a whole new ballgame. The level of customization and flexibility needs to be far greater than that of CSS frameworks because this is how style frameworks should always work.
