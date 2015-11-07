---
date: 7 Nov 2015
categories: intermediate, guides
author: Aleksandar Goševski
summary: Aleksandar is back! This time with an article on simple grid mixins. Learn how to create your own grid system with a few lines of Sass. It's actually not that hard.
---

# Simple grid mixins

Grid systems can be quite complicated. [960.gs](http://960.gs/), the mother of all grid systems, contains over 600 lines of code! And it's one of the simpler pure-CSS grid systems. I'm not a huge fan of scattering classes throughout your markup. Some people do like this approach, of course, but it's possible to build a grid system in Sass that doesn't require gratuitous use of classes. Instead, we can use mixins and style using existing classes and markup.

Let's build a set of mixins that will allow us to do this. For our grid system I don't want to use floats, because sometimes I need to vertically center columns. Instead, I'll use the inline-block method which allows for vertical centering. And of course, I want the grid to be responsive.

Let's get started.

## The basic mixins

First, we'll create the row mixin. Our grid will require a container which will include content for the grid. This is called a row. Here's a simple mixin to turn an element into a row:

    :::scss
    @mixin row() {
      font-size: 0;
    }

Next, we'll create a simple column mixin for grid cells:

    @mixin col($align: top) {
      font-size: 16px;
      display: inline-block;
      vertical-align: $align;
    }

You'll notice that I set the font-size to zero for the row mixin and then back to 16px for the column mixin. This is little hack to kill the default margin of inline-block elements. (Inline-block elements appear in the normal text flow of the document, left-to-right, but unlike block elements that are floated, they still need to deal with the text nodes on either side which create unwanted margin. This hack of setting the font-size to zero makes the space disappear.)

The column mixin also contains a handy parameter that will allow you to set the vertical alignment of a cell. This is extremely handy for aligning the cells in a row.

## Making the column mixin robust

Let's extend the column mixin to include a way of setting the width of the column. When it comes to column width, for me it's easiest to think in terms of fractions. To create three cells that are of equal width they each need to be 1/3 the width of the containing element (the row).

We can extend our column mixin to allow us to pass the width as a fraction like this:

    :::scss
    @mixin col($col, $sum, $align: top) {
      width: percentage($col/$sum);
      font-size: 16px;
      display: inline-block;
      vertical-align: $align;
    }

This will allow us to set the width of a cell to 1/3 with `@include col(1,3)`. Quite simple, eh?

Now let's extend this further to so that we can specify the gap between cells:

    :::scss
    @mixin col($col, $sum, $gap: 1em, $align: top) {
      width: percentage($col/$sum);
      font-size: 16px;
      display: inline-block;
      vertical-align: $align;
      box-sizing: border-box;
      padding: 0 $gap;
    }

This is almost what we want. We can now specify the `$gap` between cells by passing it as a parameter to the column mixin: `@include col(1, 2, $gap: 2em)` (the default `$gap` is `1em`), however it won't work well for the first and last columns because they will get `$gap` padding applied before and after which isn't quite what we want.

To accommodate the first and last columns we can add two additional parameters:

    :::scss
    @mixin col($col, $sum, $gap: 1em, $align: top, $first: false, $last: false) {
      width: percentage($col/$sum);
      font-size: 16px;
      display: inline-block;
      vertical-align: $align;
      box-sizing: border-box;
      padding-left: if($first, 0, $gap);
      padding-right: if($last, 0, $gap);
    }

Now we can call `@include col(1, 3, $first: true)` for the first cell, or `@include col(1, 3, $last: true)` for the final cell and it will work correctly.

Our final step is to make the column mixin responsive:

    :::scss
    @mixin col($col, $sum, $gap: 1em, $align: top) {
      width: 100%;
      font-size: 16px;
      display: inline-block;
      box-sizing: border-box;
      padding-left: if($first, 0, $gap);
      padding-right: if($last, 0, $gap);

      @media only screen and (min-width: 768px) {
        width: percentage($col/$sum);
        vertical-align: $align;
      }
    }

Now, on screens less than 768 pixels wide (mobile devices) elements that use the column mixin will be as wide as their parent element, however on screens greater than 768px wide (like desktop computers) cells will display at their appropriate widths.

## Conclusion

Okay, so with just a few lines of Sass we've created a grid system that:

- Can accommodate cells of any width
- Can display optional gaps between cells
- Handles gaps correctly for first and last columns
- Has cells snap to the full-width of the container on mobile devices

And we achieved all of this in just 16 lines of code! You can see a full demo how these mixins are used, on [CodePen](http://codepen.io/goschevski/full/Awuyz).
