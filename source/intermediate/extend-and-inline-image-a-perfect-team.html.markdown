---
date: 2099-02-02 10:00:00 -0600
categories: articles
author: Roy Tomeij
summary: Using Compass' `inline-image()` function it's easy to include images directly in your CSS. When using the same image more than once you're creating needlessly heavy CSS files. Use `@extend` to prevent this and reduce HTTP requests without repeating yourself.
---

# @extend and inline-image(): a perfect team

Using Compass' `inline-image()` function it's easy to include images directly in your CSS. When using the same image more than once you're creating needlessly heavy CSS files. Use `@extend` to prevent this and reduce HTTP requests without repeating yourself.

## Inline images? Huh, what?

Modern browsers (including IE8+) all support images embedded directly in your CSS. Instead of using a file name in your CSS to reference an image you use the base64 encoded string that represents the file.

The upsides: you save an HTTP request, making this especially useful for small files such as icons. On slower connections, like on your cell phone, it works wonders because it's usually faster to download a slightly larger file than negotiate a new transfer. Contrary to sprites you can mix image formats (you may embed png's, gif's, etc) and use background positioning and repeat, which offers a huge advantage.

The downside: the browser will apply all styling once the CSS is downloaded, so a visitor needs to wait longer before anything happens (instead of at least seeing the correct layout and the images appear later). Base64 encoded files also are about 33% larger, so embedding a 10KB image will increase the size of your CSS by 13KB.

The pro's may outweigh the cons, specially on slow connections. Your mileage may vary and you should experiment a bit on your project. You may consider going for a hybrid version, where the images that are most important are in your CSS and use sprites for the rest. This way your logo would be visible immediately, while it's okay if visitors have to wait a few seconds for the background of your footer to appear.

## There's an app for that!

Of course we wouldn't want to go through the tedious process of going to some website, upload our icon, get the base64 encoded string and paste that in our Sass. Just as Compass has a great way to take away the hassle of creating sprites, it does the same for having images inline in your CSS. Surprisingly, that helper is called `inline-image()`, [documented here](http://compass-style.org/reference/compass/helpers/inline-data/). Supply it the location of an image like this, and you're all set: `background-image: inline-image("image.png")` (you could also use it in `background` shorthand, or anywhere else you can use `url()`).

Gotta love Compass!

## Using the same embedded image more than once

Sometimes you have an image, like an icon, you want to use in multiple selectors. Where referencing the same background image or sprite more than once doesn't add extra weight (the browser will download the file once), doing so using embedded images will add the size of the image to the CSS for every occurrence. We don't want the same base64 encoded string in there multiple times; when you find yourself typing the exact same `inline-image("image.png")` multiple times, you're doing it wrong.

## @extend to the rescue

Luckily there's an elegant way to solve the issue of wanting to reuse the embedded image in multiple selectors using the [@extend directive](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#extend) in Sass. Using `@extend` you can reuse a selector by "including" it in some other selector. Contrary to a mixin this doesn't duplicate any code, but solves it by being creative with selectors.

Lets dive into code and show how the same inline image can be used in multiple selectors without embedding it more than once:

    :::scss
    .icon-new {
      background: inline-image("icon-new.png") no-repeat;
    }

    .new {
      text-transform: uppercase;
      @extend .icon-new;
    }

    .some-other {
      font-weight: bold;
      @extend .icon-new;
    }

This will compile to:

    :::css
    .icon-new,
    .new,
    .some-other {
      background: url(data:...) no-repeat;
    }

    .new {
      text-transform: uppercase;
    }

    .some-other {
      font-weight: bold;
    }

I added some extra properties, just to show how Sass handles those when using the @extend directive. Using this technique you do end up with a `.icon-new` selector in your CSS that you don't use in your HTML. I can live with that though, and if I'm not mistaken the great minds behind Sass are currently working on a way that enables us to use a "silent selector" to extend, solving this "issue".

Sass and Compass, what a team!
