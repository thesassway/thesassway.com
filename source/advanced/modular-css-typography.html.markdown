---
date: 9 November 2013
categories: advanced, guides
author: John W. Long
summary: Learn how to modularize your typography to create solid foundation for your projects. Use multiple classes and the @extend directive to create a reusable set of typographical styles.
---

# Modular CSS Typography

This is the fourth in a series of articles that I've been writing about Modular
CSS. So far we've covered:

* [The perils of using too much nesting in Sass](http://thesassway.com/intermediate/avoid-nested-selectors-for-more-modular-css)
* [An example of modular CSS](http://thesassway.com/advanced/modular-css-an-example)
* [Modular CSS naming conventions](http://thesassway.com/advanced/modular-css-naming-conventions)

Now I'd like to talk a little bit about modular typography. I'll be venturing
out into some new territory in this article. The subject of typography seems to
be something that has been mostly neglected in discussions of
[SMACSS](http://smacss.com) and [BEM](http://bem.info). From what I can tell
[Nicole Sullivan](http://stubbornella.org) has thought more about it than anyone
else with [OOCSS](https://github.com/stubbornella/oocss/blob/master/oocss/src/components/typography/_typography.scss).
I'm going to key off of her approach and add something I learned from a little
library a co-worker is working on called [Typeset](http://joshuarudd.github.io/typeset.css/).


## On using a reset

For starters I like to reset all of my styles with a CSS reset. Compass provides
a really nice one based in part on [Eric Meyer's approach](http://meyerweb.com/eric/tools/css/reset/)
with a few modifications. It's a very good place to start. You can use it in
Compass with the `global-reset` mixin:

    :::scss
    @import 'compass';
    @include global-reset;

A couple of people have asked me why I don't use [Normalize.css](http://necolas.github.io/normalize.css/).
Normalize<sup>1</sup> is a brilliant project and I have a lot of respect for Nicolas
Gallagher and the team that has put it together. Having a common set of
useable styles is a great starting point for many projects.

However, on my own projects I prefer a reset that changes the defaults for all
tags to use the same formatting because it is more modular.

The first reason I like this approach is that zeroing out styles on all
elements allows me to build-up styles using nothing but classes. This is handy
because I can modify the tag structure of the document at any point (for
semantic reasons) while maintaing the class structure to ensure that the
styling will remain the same. In general I use tags for sematics and classes
for styling.

The other reason to start with a fuller reset is that starting from zero allows
you to layer on styles without worrying about turning off other styles. Read
that one more time. Anytime you have to turn off styles in multiple places in
your stylesheets your are spreading the knowledge of those styles throughout
your stylesheet instead of having them in only one place.

My goal is to reduce the number of dependencies (connections) between rules
spread across my stylesheets. Starting from zero puts me on much better footing
to do that.



## Base styles

After including a reset, I setup the base font settings for a project. Here's
an example of doing this by setting the font on the `body` element:

    :::scss
    body {
      color: $text-color;
      font-size: $base-font-size;
      font-family: $base-font-family;
      font-weight: $base-font-weight;
      line-height: 1.6;
    }

Note that I've explicitly set the line-height of the entire document here. While
things like headings often use a different line-height, this puts the rest of
the document on even footing. Setting it here generally means that I have to
fiddle with it much less frequently when styling.


## OOCSS headings

[Nicole Sullivan](http://www.stubbornella.org/) suggests that you define styles
for headings with additional classes so that you can do things like style `h2`
tags like `h4`s when the occassion demands. A great example where this can be
useful is in a sidebar. In a sidebar smaller headings from the main content are
generally desirable:

    :::html
    <div class="sidebar">
      <h2 class="h4">Heading</h2>
      ...
    </div>

One could argue that HTML5 `section` and `header` tags make this unnecessary
because the actual heading number used is no longer semantic, but this approach
is useful in other places as well. For instance, to style a definition list term
in the same way as a heading:

    :::html
    <dl>
      <dt class="h4">Term</dt>
      <dd>...</dd>
    </dl>

The point is that adding these kinds of classes can make it that much easier
separate the underlying semantic markup from the appearance of the element.


## One step farther

Going back to what I said about the reset, I find it very useful to have zero
styles defined by default so that I can layer on styles using nothing but
classes. Any time I have to spend time overriding default styles I'm actually
duplicating knowledge of those styles in more than one place in my stylesheet.
Duplication of this kind is bad in my opinion.

With this in mind, I like to take Nicole's approach one step farther an not
define any styles for headings, lists, etc. on a global level. Instead I define
them all using modifier classes:

    :::scss
    .h1, .h2, .h3, .h4, .h5, .h6 { font-family: $heading-font-family; font-weight: $heading-font-weight; }
    .h1, .h2 { line-height: 1.1; }
    .h3, .h4 { line-height: 1.3; }
    .h1 { font-size: 400%; letter-spacing: -2px; }
    .h2 { font-size: 250%; letter-spacing: -1px; }
    .h3 { font-size: 200%; }
    .h4 { font-size: 180%; }
    .h5 { font-size: 130%; }

    .fixed { font-family: $fixed-font-family; font-size: $fixed-font-size; line-height: $fixed-line-height; }

    .quiet { font-color: $quiet-color; }
    .loud  { font-color: $loud-color; }

    .italic { font-style: italic; }
    .bold   { font-weight: 700; @extend .loud; }

    .block-margins { margin: 1em 0; }

    .unordered-list { list-style-type: disc; }
    .ordered-list { list-style: decimal; }

This gives me a set of classes that can easily be used to apply the same styles
in any circumstance.


## Typesetting my content

Now before you get all up and arms about _classitis_ in my markup I have one
final trick up my sleeve. For content I like to make use of a `typography` class
which defines default styles for all kinds of tags. This is a trick I learned
from [Typeset](http://joshuarudd.github.io/typeset.css/).

The idea is that anywhere you need your full typographical styles you just apply
them with the `typography` class:

    :::html
    <div class="blog-post typography">
      <h1>Blog post</h1>
      ...
    </div>

Since I already have a ton of helpful modifier classes I can use the Sass
`@extend` directive (learn more about `@extend`
[here](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#extend)) to
make the definition of the `typography` modifier a snap:

    :::scss
    .typography {
      i, em { @extend .italic; }
      b, strong { @extend .bold; }

      h1, .h1 { @extend .h1; margin: 1em 0 0.5em; }
      h2, .h2 { @extend .h2; margin: 1em 0 0.5em; }
      h3, .h3 { @extend .h3; margin: 1em 0 0.5em; }
      h4, .h4 { @extend .h4; margin: 1em 0 0.5em; }
      h5, .h5 { @extend .h5; margin: 1em 0 0.5em; }
      h6, .h6 { @extend .h6; margin: 1em 0 0.5em; }

      p, ul, ol, pre { @extend .block-margins; }

      ul { @extend .unordered-list; }
      ol { @extend .ordered-list; }

      pre, code { @extend .fixed; }
    }


## An example

To illustrate how this can all come together, I've put a full modular
typography demo on Codepen [here](http://codepen.io/jlong/pen/wErcp):

<div data-height="450" data-theme-id="393" data-slug-hash="gtvzG" data-user="jlong" data-default-tab="result" class='codepen'>See the Pen <a href='http://codepen.io/jlong/pen/gtvzG'>Modular Typography</a> by John W. Long (<a href='http://codepen.io/jlong'>@jlong</a>) on <a href='http://codepen.io'>CodePen</a></div>
<script async src="http://codepen.io/assets/embed/ei.js"></script>


## In conclusion

Having a good approach to modular typography will provide a solid foundation
for your projects. This approach has worked well for me on a lot of different
projects and I'm comfortable saying that it's generally useful for anyone who
is trying to structure their projects in a more modular way.

Of course, it's not the only way to write your stylesheets. Your milaege may
vary.

Thoughts or questions? Please share them in the comments below.


## Footnotes

1. [Chris Coyier](http://chriscoyier.net/) was kind enough to point out that
one way of using Normalize is to use it as a starting point for your base
typographical styles and customize it as you see fit. In fact, looking back at
the Normalize [website](http://nicolasgallagher.com/about-normalize-css/) this
seems to be one of the recommended ways of using it. It would be interesting to
take Normalize and use it as the basis for a better reset. Personally, I'd love
to see an HTML meta tag for zeroing out styles on a website, because the
concept of starting from zero and building up from there is so useful.
