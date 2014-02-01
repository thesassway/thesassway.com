---
date: 2012-02-02 10:00:00 -0600
categories: articles
author: Roy Tomeij
summary: Those who don't see any use for pre-processors such as Sass often use the "bad code" argumentation. It creates too specific selectors due to nesting, huge sprites and they hate the way Sass enforces an architectural approach that doesn't work. And it's all true. If you're a poor developer. You know, one who would handcraft too specific selectors, 15MB sprites and doesn't know how to cleanly structure a project.
categories: editorial
---

# Sass doesn't create bad code. Bad coders do.

Those who don't see any use for pre-processors such as Sass often use the "bad code" argumentation. It creates too specific selectors due to nesting, huge sprites and they hate the way Sass enforces an architectural approach that doesn't work. And it's all true. If you're a poor developer. You know, one who would handcraft too specific selectors, 15MB sprites and doesn't know how to cleanly structure a project.

## Debunking the arguments against Sass

With this article I'll try to debunk the arguments against using Sass that create fear, uncertainty and doubt. I believe these arguments to be in error and used by those who don't have actual experience with pre-processors or have worked with people who didn't "get it". I'm sure I can convert any CSS out there to Sass, using substantially fewer characters, while maintaining the exact same output. Whatever Sass compiles to is up to you. Now, bring it on!

## "Nesting leads to overly specific selectors"

Too much nesting sure does. There's a pretty nifty solution for this: don't do it. Mario has written an excellent article about [the inception rule](http://thesassway.com/beginner/the-inception-rule) here on The Sass Way.

I understand it's easy to fall prey to this; [even 37signals does it](http://37signals.com/svn/posts/3003-css-taking-control-of-the-cascade). The basic rule is: don't try to mimic your HTML structure in your Sass. It may seem handy at first, but in the end it will lead to completely non-reusable code due to the extreme specificity of selectors. You'll end up copy/pasting chunks of Sass and cause code duplication. Keep your selectors shallow.

## "Mixins will bloat your CSS by repeating code"

They may. When a mixin holds five lines of code, including it in your Sass ten times will lead to 50 lines of CSS. In most cases you don't want that. My rule of thumb is: mixins without arguments smell. When the return value of your mixin is dependent on arguments you pass to it, it should generate different output with every use. For a mixin that returns the width based on a number of columns when using a grid based layout for instance, that makes complete sense.

For a lot of other uses, the `@extend` directive may be a better choice (as long as you read the next paragraph).

## "The extend directive creates _a lot_ of ugly selectors"

Ask yourself if your compiled CSS is meant to be human readable or machine readable. If you work in Sass, but know the resulting CSS will be hand edited, I would avoid extending selectors. When using `@extend` two times on a single selector, there will be code related to it at three places in the CSS (assuming you aren't nesting extends).

For a browser however, the way the code is formatted doesn't really matter, which is why minifying your code is a best practice. Pretty code is less important than performant code, and extending your selectors can definitely lead to DRY'er code than using mixins. On the other hand, don't overdo it. If you find yourself extending your `.clearfix` class twenty times, you may consider adding it to your HTML (or learn how floats work). Use common sense.

## "You can't use Sass in an OOCSS (or any other architectural) approach"

Sure you can. If you want to use class names on every element in your HTML and define (extreme) shallow selectors in your CSS, Sass has got your back. If you want to take a nested approach, where you only set a class name on a wrapper element and use descendant selectors in your CSS, Sass is a good fit. You could even just take your handcrafted CSS, rename it to SCSS and only use those features in Sass and Compass that brighten up your day. Sass doesn't have anything to do with your architectural approach. Tell it what to do, and it will do it.

## Know your compiler

You don't need to know the internals of Sass to know what will be done to your code. Just open the processed CSS once in a while and see what it looks like. It isn't rocket science to learn to predict what your Sass code will be compiled too. It's a good thing to think "how would I do this in plain ol' CSS" when writing Sass. At least you'll know if a certain use of `@extend` adds a gazillion selectors to your CSS and make an informed decision as to use it or not.

## Sass is just a tool

Just as you can't expect everyone who holds a hammer to be a master carpenter, Sass doesn't automagically turn you into a great front-end developer. In the end, Sass is "just" a powerful tool. And when taking responsibility in this great power, it will help you write and maintain your stylesheets the easy way, whatever approach you to take. Know what you're doing and you'll be fine.
