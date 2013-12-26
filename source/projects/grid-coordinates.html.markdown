---
Date: 8 September 2050
Categories: projects, adam-stacoviak
Author: Adam Stacoviak
about_author: adam_stacoviak
Summary: Grid Coordinates is a highly configurable Sass based CSS Grid Framework inspired by 960 Grid System and 1kb CSS Grid that takes three "coordinates" (columns, grid width, gutter width) and generates the styles required for your grid.
---

# Grid Coordinates, the highly configurable Sassy CSS Grid Framework

If you're familiar with [The 1kb CSS Grid](http://1kbgrid.com/) from [Tyler Tate](http://www.tylertate.com/) or [960.gs](http://960.gs/) from [Nathan Smith](http://sonspring.com/), then you're already familiar with Grid Coordinates.

Grid Coordinates is a highly configurable [Sass](http://sass-lang.com/) based CSS Grid Framework inspired by 960 Grid System and The 1kb CSS Grid that takes three "coordinates" (columns, grid width, gutter width) and generates the styles required for your grid.

## Just the grid

Grid Coordinates does one job - provide a rock solid grid framework. It's able to generate styles for grids of any size - you control the coordinates and it provides the styles. It fully leverages classes, `@extend` and mixins to set up the styles for your grid. It supports nested grids, prefix and suffix grid features as well as push and pull grid features.

    :::sass
    // Configure Grid Coordinates
    $grid-columns: 12
    $grid-width: 60px
    $grid-gutter-width: 20px

    @import "grid-coordinates"

    // Do it.
    +grid-coordinates

### Using classes and `@extend`

When you use the mixin `+grid-coordinates` (as shown above) you are able to leverage the CSS class selectors in your HTML markup or use the Sass `extend` option to "extend" the class selectors in your Sass stylesheets.

For an example of this in use, look at [grid-coordinates.com/.../demo.sass](https://github.com/adamstac/grid-coordinates.com/blob/master/themes/grid-coordinates/sass/demo.sass).

`@extend .grid-container`

`@extend .nested-grid-container`

`@extend .grid-[columns]`

`@extend .grid-prefix-[columns]`

`@extend .grid-suffix-[columns]`

`@extend .grid-push-[columns]`

`@extend .grid-pull-[columns]`

`@extend .grid-full`

### Using mixins

Regardless if go the route of using the mixin `+grid-coordinates` (as shown above) or not, you'll have access to use these mixins in your Sass stylesheets. Keep in mind that when you go the route of using mixins, you could end up replicating a lot of code in your output CSS. Learn more about the [Sass extend concept](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#extend) to see if you should use that method or mixins. Either way, Grid Coordinates has your back.

`+grid-container`

`+nested-grid-container`

`+grid([columns])`

`+grid-prefix([columns])`

`+grid-suffix([columns])`

`+grid-push([columns])`

`+grid-pull([columns])`

`+grid-full`
