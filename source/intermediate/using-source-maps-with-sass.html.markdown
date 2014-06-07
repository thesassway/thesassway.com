---
date: 7 June 2014
categories: intermediate, guides
author: Tim Hettler
summary: Tem Hettler shows us how to use source maps to make debugging easier with Sass 3.3 and modern browsers like Safari, Chrome, and Firefox.
---

# Using source maps with Sass 3.3

One of the exciting new features in [Sass 3.3](http://thesassway.com/news/sass-3-3-released) that every developer should take advantage of is source maps.

As CSS pre-processors, minifiers, and [JavaScript transpilers](https://github.com/jashkenas/coffeescript/wiki/List-of-languages-that-compile-to-JS) have become mainstream it is increasingly difficult to debug the code running in the browser because of differences with the original source code.

For example, if you use [CoffeeScript](http://coffeescript.org/) (which compiles to JavaScript) you won't see CoffeeScript while debugging in the browser. Instead, you'll see compiled JavaScript. The same problem exists for Sass which compiles down to CSS.

Source maps seek to bridge the gap between higher-level languages like CoffeeScript and Sass and the lower-level languages they compile down to (JavaScript and CSS). Source maps allow you to see the original source (the CoffeeScript or Sass) instead of the compiled JavaScript or CSS while debugging.

In practice, for Sass users, this means that when you inspect an element with developer tools, rather than seeing the CSS styles associated with that element, you can see the code we *really* care about: the pre-compiled Sass.


## Generating source maps for Sass

To get access to this feature in the browser, you need to generate a source map file for each source file.

For Sass, this is as easy as adding a flag to Sass's command line tool:

    :::bash
    $ sass sass/screen.scss:stylesheets/screen.css --sourcemap

If you look in your output folder after running that command, you'll notice that a comment has been added to the end of the generated CSS file:

    :::css
    /*# sourceMappingURL=screen.css.map */

This points to an additional file that was created during compilation: `screen.css.map`, which - as the name implies - is what maps all of the compiled CSS back to the source Sass declarations. If you're interested in the details of this file and how source maps actually work, check out Ryan Seddon's [*Introduction to JavaScript Source Maps*](http://www.html5rocks.com/en/tutorials/developertools/sourcemaps/) over at HTML5Rocks. (Even though the article implies that it's only about JavaScript, all source maps work the same.)


## Enabling source maps in the browser

The second thing we need to do to take advantage of source maps is to make sure that our browser knows look for them. Chrome, Firefox and Safari all have support for source maps.

### Chrome

If you're using Chrome, source maps are now part of the core feature set, so you don't have to monkey around in `chrome://flags` any more. Simply open up the DevTools settings and toggle the `Enable CSS Source Maps` option:

![Enabling source maps in Chrome](/images/articles/chrome-enable-source-map.gif)

### Firefox

For Firefox users, source maps are only available in [Aurora](https://www.mozilla.org/en-US/firefox/aurora/), the pre-Beta build of Firefox. To enable source maps, right-click anywhere on the inspector's rule view or in the Style Editor to get a context menu, then select the `Show original sources` option. (More info is available at the [Mozilla blog](https://hacks.mozilla.org/2014/02/live-editing-sass-and-less-in-the-firefox-developer-tools/).)

### Safari

Safari is a bit ahead of the curve in terms of source map support. If a map file is detected, references are automatically changed to the source-mapped files, no configuration necessary.

## Another tool in our belt

Once source maps are enabled in your browser of choice, the source reference for every style will change from the generated CSS to the source Sass, right down to the line number. Amazing!

![Viewing Sass in the developer tools](/images/articles/view-original-source.gif)

Just as Firebug and its successors drastically improved our ability to debug in the browser, source maps increase the depth of our diagnostic capabilities. By allowing us to directly access our pre-compiled code, we can find and fix problems faster than ever. Now that I've been using source maps for a few months, I can't imagine working without them.

Now that you have source maps enabled for Sass, you may want to [learn how to use source maps with JavaScript](http://www.html5rocks.com/en/tutorials/developertools/sourcemaps/).
