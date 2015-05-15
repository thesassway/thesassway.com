---
date: 2015-05-15 02:00:00 -0600
categories: projects
author: John W. Long
summary: If you like animation and are looking for a way to spice up your latest project, you might want to grab a spinner from the CSS Spinners project. It's an open source effort by myself to create a common set of pure CSS spinners.
---

# Pure CSS Spinners

If you like animation and are looking for a way to spice up your latest project, you might want to grab a spinner from the [CSS Spinners](http://css-spinners.com) project. It's an open source effort by myself to create a common set of pure CSS spinners. That's right! No images to download!

The project has a range of loading indicators, from the more common three quarters spinner:

<figure class="figure outlined-figure">
<a href="http://www.css-spinners.com/spinner/three-quarters"><img class="figure-image" src="/images/articles/css-spinners/three-quarters-loader.gif" alt="three quarters spinner"></a>
</figure>

To the more advanced Google Plus loader:

<figure class="figure outlined-figure">
<a href="http://www.css-spinners.com/spinner/plus"><img class="figure-image" src="/images/articles/css-spinners/plus-loader.gif" alt="Google Plus loader"></a>
</figure>

There are over 15 spinners in the collection, with more to come:

<figure class="figure outlined-figure">
<a href="http://www.css-spinners.com"><img class="figure-image" src="/images/articles/css-spinners/css-spinners.png" alt="Lots of spinners"></a>
</figure>

One of the goals of the project is to keep the markup as simple as possible. This means each loading indicator is created with a single element:

    :::html
    <div class="throbber-loader">
      Loading...
    </div>

The text inside the element is displayed by browsers that don't support CSS animation (like IE9).

Oh, and the spinners are all coded in your favorite preprocessor, <i>Sass</i>! This means that you can easily customize the size and color of each spinner. Check out the [Sass source files](https://github.com/jlong/css-spinners/tree/master/sass/spinner) to see how easy they are to customize.

Want to contribute your own spinner to the project? Contributions are welcome! [Just send me a pull request on GitHub.](https://github.com/jlong/css-spinners)

Visit, [www.css-spinners.com](http://css-spinners.com) to see them all in action.
