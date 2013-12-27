---
date: 2011-11-20 10:30:00 -0600
categories: beginner, guides, mario-ricalde
author: Mario Ricalde
summary: It's well known that Sass is an *efficient*, *realiable* and *precise* tool which gives us great power and freedom to make CSS fun and less of a pain to author; however with great power comes *responsibility*.
---

# Nested Selectors: The Inception Rule

It's well known that Sass is an *efficient*, *realiable* and *precise* tool which gives us great power and freedom to make CSS fun and less of a pain to author; however with great power comes *responsibility*.

## The Problem

We've all been there, in the CSS realm, where all code lives at a "root level" and writing nested selectors means writing a lot of code for each CSS declaration.

Today we're going to dive into the most basic rule in the Sass universe. It's called, "The Inception Rule." This rule will help you survive [the most common mistake](http://37signals.com/svn/posts/3003-css-taking-control-of-the-cascade) that many Sass developers, beginners and advanced make.

Take this code for example:

    :::css
    .post {
      border-radius: 3px;
      background: #FFF8FF;
      border: 1px solid #EFC6F3;
      padding: 15px;
      color: #333333;
    }
    .post .title, .post .alt-title  {
      color: #000000;
      font-size:20px;
    }
    .post .alt-title {
      border-bottom:1px solid #EFC6F3;
    }

Odds are that while you were stuck in the CSS realm you began taking the approach of making loads of classes and then stuffing them in your HTML like no tomorrow. Have you ever added 5 classes to a single DOM element?

    :::html
    <div class="post complete highlight rounded clearfix">...</div>

That was the everyday bread and butter. We all thought we wouldn't be able to enjoy writing CSS. However, as soon as Sass appeared in your life, you discovered this was **the way** to go when working with CSS.

And just as easy as it is to get going with Sass, it's also easy to use it incorrectly.

When you begin working with Sass, the first feature you fall in love with is "nested selectors". Being able to nest selectors under another is a wonderful feature which saves keystrokes and possibly Carpal Tunnel Syndrome as well.

Let's look at an example of nesting selectors in Sass.

    :::scss
    $border: 1px solid #EFC6F3;
    .post {
      border-radius: 3px;
      background: #FFF8FF;
      border: 1px solid $border;
      padding: 15px;
      color: #333333;
      .title {
        color: #000000;
        font-size:20px;
      }
      .alt-title {
        @extend .title;
        border-bottom:1px solid $border;
      }
    }

The above code will output the exact same code as the code you didn't like to write when you were writing CSS because of all repetition.

Here's the output of the above Sass just so you can see how this translates to CSS.

    :::css
    .post {
      border-radius: 3px;
      background: #FFF8FF;
      border: 1px solid 1px solid #efc6f3;
      padding: 15px;
      color: #333333;
    }
    .post .title, .post .alt-title {
      color: #000000;
      font-size: 20px;
    }
    .post .alt-title {
      border-bottom: 1px solid 1px solid #efc6f3;
    }

And so, like a child with a new toy, we begin to use this feature in *-what we think-* is its "max potential". But actually what's taking happening is some may call, a "CSS Selector Nightmare."

## CSS Selector Nightmare

The so called **nightmare** between front-end engineers is when the styles are bloated and tightly coupled to the DOM to a point where modifying anything about the structure ends up breaking the front-end.

Let's look at this not-so-pretty piece of HTML.

    :::html
    <body>
      <div class="container">
        <div class="content">
          <div class="articles">
            <div class="post">
              <div class="title">
                <h1><a href="#">Hello World</a>
              </div>
              <div class="content">
                <p></p>
                <ul>
                  <li>...</li>
                </ul>
              </div>
              <div class="author">
                <a href="#" class="display"><img src="..." /></a>
                <h4><a href="#">...</a></h4>
                <p>
                  <a href="#">...</a>
                  <ul>
                    <li>...</li>
                  </ul>
                </p>
              </div>
            </div>
          </div>

        </div>
      </div>
    </body>

Because Sass offers you the ability to nest your selectors, and you know that having your code encapsulated is the "good way to avoid collisions with other styles", you might find yourself mimicking the DOM in your Sass (bad idea).

Let's look at some Sass you might craft for our not-so-pretty piece of HTML.

    :::scss
    body {
      div.container {
        div.content {
          div.articles {
            & > div.post {
              div.title {
                h1 {
                  a {
                  }
                }
              }
              div.content {
                p { ... }
                ul {
                  li { ... }
                }
              }
              div.author {
                a.display {
                  img { ... }
                }
                h4 {
                  a { ... }
                }
                p {
                  a { ... }
                }
                ul {
                  li { ... }
                }
              }
            }
          }
        }
      }
    }

This is "all good", right? Using the above code, you can predict 100% of the time what's going to happen with your stylesheet. There is *no cascading* that can beat the [specificity](http://www.htmldog.com/guides/cssadvanced/specificity/) ...

After compiling the Sass, we take a look at the result on to find that we've created a CSS monster. Ugh!

    :::css
    body { ... }
    body div.content div.container { ... }
    body div.content div.container div.articles { ... }
    body div.content div.container div.articles > div.post { ... }
    body div.content div.container div.articles > div.post div.title { ... }
    body div.content div.container div.articles > div.post div.title h1 { ... }
    body div.content div.container div.articles > div.post div.title h1 a { ... }
    body div.content div.container div.articles > div.post div.content { ... }
    body div.content div.container div.articles > div.post div.content p { ... }
    body div.content div.container div.articles > div.post div.content ul { ... }
    body div.content div.container div.articles > div.post div.content ul li { ... }
    body div.content div.container div.articles > div.post div.author { ... }
    body div.content div.container div.articles > div.post div.author a.display { ... }
    body div.content div.container div.articles > div.post div.author a.display img { ... }
    body div.content div.container div.articles > div.post div.author h4 { ... }
    body div.content div.container div.articles > div.post div.author h4 a { ... }
    body div.content div.container div.articles > div.post div.author p { ... }
    body div.content div.container div.articles > div.post div.author p a { ... }
    body div.content div.container div.articles > div.post div.author ul { ... }
    body div.content div.container div.articles > div.post div.author ul li { ... }

There are so many reasons why this is just plain **wrong**, from [rendering performance](http://code.google.com/speed/page-speed/docs/rendering.html#UseEfficientCSSSelectors) to file-size performance. Just think about how many bytes this will add to your CSS. But, the odds are you may say:

> "Hey, computers are faster now! and also the internet download speeds are better!" - User who hates Front-End Engineering.

But that's not the only problem! Since your styles are so specific to the DOM, *maintainability* is now a problem.

Any change you make to your markup will need to be reflected into your Sass and vice versa. It also means that the styles are bounded for life to the those elements and that HTML structure which completely defeats the purpose of the "Cascade" part of "Cascading Style Sheets."

If you follow this path, you might as well go back to writing your CSS inline in your HTML (please don't).

## Meet The Inception Rule

To prevent you from falling into this nightmare, I created a simple rule. Until now, this rule has remained unwritten, but many followed.

The Inception Rule: **don’t go more than four levels deep**.

This basically means that you shouldn't be too specific or mimicking the DOM at any point. If you find yourself more than four levels deep, that's a red flag. Of course there are times when you'll be forced to go there, but it's not something you should be doing too much.

## Making it fit in the Four or Less principle.

Once you understand the problem behind being too specific with selectors, you need to understand how to make your code more general by improving your understanding of *contexts*, *objects* and *interaction states*.

### Site Context

If you're styling something that lacks completely of classes or ids, then odds are you're going to need at most just one level. Good examples of this would be the default styling of `h1 - h6`, `ul`, `p`.

There may be cases where it makes sense to add several selectors such as a CSS reset. Please, use common sense when crafting site context styles.

### Page Context (layouts, sidebar widths, heights)

If you're styling the layout (sidebar and content dimensions, elements that vary depending on the page) then you're talking about page context. Usually you'll need at least two levels of indentation to achieve this. However, remember that you should *only* assign styles things that change on a page basis, not the objects themselves. I'll cover objects in the next section.

Here's an example of what I mean.

    :::scss
    .cart {
      #sidebar { width: 150px; }
      #content { width: 850px; }
    }

### Objects

An object is an element, alone or with children, that is identified by a `class` or an `id`. Usually, this is going to be the most common type of styling you should have in your code. Objects can be anything that should be delivered to the view as a whole. You can use objects as basic styling and then modify them using "page context" styles when needed.

Here's a list of elements commonly styled as objects.

    :::text
    #sideabr
    #content
    #footer
    .blog-post
    .comment
    .widget
    .logo
    .user
    .button

You'll usually set one top class to identify the object and set that as a base for the selector, from there you should style using the most general selector available.

    :::scss
    ul.special-deal {
      ...
      li {...}
      a {...}
    }

Note that objects should have at most 4 levels. Most of the time you'll stay around the 2-3 level range, and the fourth would be the interaction state.

### Interaction State

The interaction state covers anything that changes when you interact with an *object*. You'll usually get close to the fourth indentation limit when adding interaction states. This is expected and is acceptable.

## Remember

**Be smart**: Think about how the compiler will build your code and ask yourself if the code it's generating is really needed in your CSS. I always ask myself, can this style be achieved with less selectors?

**Be crafty**: Use everything the compiler provides to you. For example, using the `@extend` directive or a mixin. Each has it's own implications on the output.

**Be expressive**: If you are adding a declaration that affects global html tags, document it with comments. Commenting your code can be huge when coming back to code weeks or months later. Comments are your friend. If you're nesting `article` `aside` `section` or `h3`, you better have a good reason!

**Be creative**: Is there a way to make the HTML code easier to work with CSS without adding extra classes? If there is and it doesn't affect semantics. Do it. Examples of what I mean could be using adjacent selectors, targeting direct child elements and so forth. Get to know the rules of CSS before just nesting your Sass to the nth degree.

**Be moderate**: Abusing anything is bad. Use your common sense when in doubt.
