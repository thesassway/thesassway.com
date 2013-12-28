---
date: 30 June 2011
categories: intermediate, guides, adam-stacoviak
author: Adam Stacoviak
summary: Referencing parent selectors by using the ampersand (&amp;) can be a powerful tool, if used right. There are simple uses of this feature as well as some very complex uses of this feature. In this post we will cover the basic uses of the ampersand (&amp;) as well as link you to a post by Joel Oliveira that goes much deeper on the subject.
---

# Referencing parent selectors using the ampersand character

Referencing parent selectors by using the ampersand (&amp;) can be a powerful tool, if used right. There are simple uses of this feature as well as some very complex uses of this feature. In this post we will cover the basic uses of the ampersand (&amp;) as well as link you to a post by Joel Oliveira that goes much deeper on the subject.

## Intro to the ampersand (&) character

If you've been using Sass for any length of time, then you're likely to be familiar with being able to reference parent selectors using the ampersand (&amp;) character.

A simple Sass example looks like this:

    :::sass
    h3
      font-size: 20px
      margin-bottom: 10px
      &.some-selector
        font-size: 24px
        margin-bottom: 20px

And here's how the output CSS looks.

    :::css
    h3 {
      font-size: 20px;
      margin-bottom: 10px;
    }
    h3.some-selector {
      font-size: 24px;
      margin-bottom: 20px;
    }

Pretty neat huh, how we didn't have to write out the h3 again. With Sass all we have to do is nest the next ruleset and attach the `&` in place of the repeating selector and we're golden.

## Wait. There's more.

This is something I stumbled onto today while working with some Sass written by my bud, and fellow staff writer, [Wynn Netherland](http://wynnnetherland.com/). Though, I don't see this mentioned in [the Sass documentation](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#referencing_parent_selectors_). You do [read documentation](http://en.wikipedia.org/wiki/RTFM) don't you?

So, what if I wanted to style all my `h3` headings a certain way, but for this one `h3`, that is also a child of a certain selector, I want to style it slightly different than the others? Well, with CSS we know how that goes, we'd have to write it all out. Verbose. Bah ...

But with Sass ... what options do we have? Check this out ...

    :::sass
    h3
      font-size: 20px
      margin-bottom: 10px
      .some-parent-selector &
        font-size: 24px
        margin-bottom: 20px

And here's how the output CSS looks.

    :::css
    h3 {
      font-size: 20px;
      margin-bottom: 10px;
    }
    .some-parent-selector h3 {
      font-size: 24px;
      margin-bottom: 20px;
    }

Based on this code, you can place a trailing ampersand (&amp;) character at the end of your selector declaration in place of the repeating selector, and sit back and enjoy the awesomeness of Sass.

## Link to a more advanced usage example

My example, is very simplistic but [Joel Oliveira](https://twitter.com/jayroh) goes deeper on the subject with his post, [_The ampersand &amp; a killer Sass feature_](http://joeloliveira.com/2011/06/28/the-ampersand-a-killer-sass-feature/). We highly recommend it.
