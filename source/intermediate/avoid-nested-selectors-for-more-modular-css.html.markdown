---
date: 2013-05-24
categories: modular-css, intermediate, guides
author: John W. Long
summary: We've written before about the dangers of nesting your CSS selectors too deeply. The Inception Rule is a good one for getting you to avoid some mangled CSS selectors. But there's actually a lot of benefit to taking this concept a couple of steps farther. What happens when you avoid nesting for almost all of your major selectors?
---

# Avoid nested selectors for more modular CSS

We've written before about the dangers of nesting your CSS selectors too deeply. The [Inception Rule](/beginner/the-inception-rule) is a good one for getting you to avoid some mangled CSS selectors. But there's actually a lot of benefit to taking this concept a couple of steps farther. What happens when you avoid nesting for almost all of your major selectors?


## Contextual selectors

First, let's talk about why this might be a good idea. One of the most powerful things about CSS is the ability to style elements differently based on different contexts. For example:

    :::scss
    .post {
      margin: 2em 0;

      .title {
        font-size: 2em;
        font-weight: normal;
      }
    }

    .sidebar .post {
      margin: 1em 0;

      .title {
        font-size: 1.2em;
        font-weight: bold;
      }
    }

The code above is a basic example of how you might style a blog post differently based on whether it is within the sidebar or not.

At first this kind of contextual power may seem like a very good idea. You can use the same HTML in the sidebar of your site as you do in the main body of the site and get very different stylistic results.

But what happens when you want to use the styles that you've written for posts in your sidebar in an archive index or something similar? Whoops! Our contextual code will have to be updated for the new context.

Now Sass provides many powerful tools that can make sharing styles in different contexts easy, but this often comes with an added cost of complexity. If you care at all about writing maintainable code you will avoid complexity at all costs.


## A more modular way

Let's write these styles in a more modular way:

    :::scss
    .post {
      margin: 2em;

      .title {
        font-size: 2em;
        font-weight: normal;
      }
    }

    .summary {
      margin: 2em;

      .title {
        font-size: 1.2em;
        font-wieght: bold;
      }
    }

Hot dog! That's better. Now we've made our rules more generic and aren't styling as much on context. We've got two separate CSS "modules" now. Post and summary. Summary can be used for sidebar items or in our archive index.

But we can improve this code further. The title class is still used in a contextual way. All it takes is for someone to declare a more generic title rule and your styles can be thrown off.


## Clashing worlds

Suppose you decided to make a page title, and declared the rule like this:

    :::scss
    .title {
      font-size: 3em;
      font-weight: bold;
      color: red;
    }

Without thinking about how you've used title already in other contexts you've created a rule that will effect all other elements that also use a class of "title". Now this example is a bit contrived, but in the real world this kind of style clash is common. On projects I've worked on in the past that use this style of coding it is a common occurrence that someone adds a new rule somewhere else that blows out styles in other contexts. On large projects these kinds of "bugs" can be hard to catch before code is moved into production.

So how can we simplify our code and at the same time add clarity? Like this:

    :::scss
    .page-title {
      font-size: 3em;
      font-weight: bold;
      color: red;
    }

    // Posts
    .post {
      margin: 2em 0;
    }
    .post-title {
      font-size: 2em;
      font-weight: normal;
    }

    // Summaries
    .summary {
      margin: 1em 0;
    }
    .summary-title {
      font-size: 1.2em;
      font-weight: bold;
    }

Ah! Much better! This minimizes the chance that other rules will clash with the ones we've just defined and helps ensure that our CSS modules will look the same in any context.


## Context and modularity

The key word here is **context**. If you value modularity you will strive to avoid contextual styles. There are times when context can be useful. Responsive designs and themes often require them. But you should be very intentional when choosing to use contextual styles. If you use them without thinking you may find that your code is extremely hard to maintain and accidental bugs surface more regularly than you would like.

It's also worth noting that if you find yourself using nesting regularly, you should consider if removing it could simplify your code.


## Conclusion

Hopefully you don't find these ideas too controversial. If you are interested in learning more about modular CSS I highly recommend taking a look at Jonathan Snook's [ebook on the subject](http://smacss.com) and following Harry Roberts over at [CSS Wizardry](http://csswizardry.com).
