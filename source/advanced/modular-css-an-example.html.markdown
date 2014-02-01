---
date: 06 August 2013
categories: modular-css, advanced, guides
author: John W. Long
summary: If avoiding nested selectors in favor of a flatter class-based CSS scares you, maybe this example will help you embrace some of the principles of modular CSS.
---

# Modular CSS, an example

If my last article about [avoiding nested selectors for more modular CSS](http://thesassway.com/intermediate/avoid-nested-selectors-for-more-modular-css) left your head spinning, you are not alone. After all, one of the coolest things about Sass is that you can nest selectors. Why would you want to give that power up?

I'm glad you asked. Perhaps an example would help. For myself, these principles really started to make sense when I was building a menubar that looked something like this:

<p data-height="300" data-theme-id="394" data-slug-hash="jJhbI" data-user="jlong" data-default-tab="result" class='codepen'>See the Pen <a href='http://codepen.io/jlong/pen/jJhbI'>Simple menu</a> by John W. Long (<a href='http://codepen.io/jlong'>@jlong</a>) on <a href='http://codepen.io'>CodePen</a></p>
<script async src="http://codepen.io/assets/embed/ei.js"></script>

To build this menubar, I started out with the following HTML:

    :::html
    <ul class="menubar">
      <li>
        <a href="#">File</a>
        <ul>
          <li><a href="#">Open</a></li>
          <li><a href="#">Save</a></li>
          <li><a href="#">Save as&#8230;</a></li>
          <li><a href="#">Close</a></li>
          <li class="separator"></li>
          <li><a href="#">Exit</a></li>
        </ul>
      </li>
      <li>
        <a href="#">Edit</a>
        <ul>
          <li><a href="#">Cut</a></li>
          <li><a href="#">Copy</a></li>
          <li><a href="#">Paste</a></li>
        </ul>
      </li>
      <li>
        <a href="#">Help</a>
        <ul>
          <li><a href="#">About</a></li>
        </ul>
      </li>
    </ul>

This is fairly standard markup for a dropdown menu system. Lists within lists seem to be the semantic method of choice. To minimize the impact on my HTML I decided to try to code it with only one class ("menubar") which I applied to the outer element.


## Using nested selectors

I then styled it using nested selectors:

    :::scss
    ul.menubar {
      background: white;
      list-style: none;
      padding: 0 10px;

      > li {
        display: inline-block;
        position: relative;

        > a {
          color: black;
          display: block;
          padding: 10px 14px;
          text-decoration: none;

          &:hover { background: #29a7f5; color: white; }
        }

        > ul {
          display: none;
          position: absolute;
          top: 100%;
          background: white;
          padding: 10px 0;

          > li > a {
            color: black;
            display: block;
            padding: 8px 20px;
            text-decoration: none;

            &:hover { background: #29a7f5; color: white; }
          }
        }

        &.is-selected {
          > a { background: #29a7f5; color: white; }
          > ul { display: block; }
        }
      }
    }

To get it to work correctly, I found myself using a lot of child selectors (">"). This was necessary because of the lists within lists. I didn't want the same styles for the menubar to be applied to the dropdown menus, so I had to explicitly indicate which "li" or "a" tag I was refering to. Child selectors let me do this. Without child selectors it's actually an even bigger mess to style a menu like this because you must turn off styles that were set for parent "li" elements on decendants. Which makes it much harder.


## A more modular approach

The menu system I was working on was actually much more complicated than the code shown above. In fact, the code spanned several screens which made it even harder to follow with all of the nesting. To maintain my own sanity I decided to add a couple of classes to the HTML to make it easier to style and evolved my CSS to something more like this:

    :::scss
    .menubar {
      list-style: none;
      font-size: 14px;
      background: white;
      padding: 0 10px;

      > li {
        display: inline-block;
        position: relative;
      }
    }
    .menubar-item {
      color: black;
      display: block;
      padding: 10px 14px;
      text-decoration: none;

      &:hover, .is-selected & { background: #29a7f5; color: white; }
    }

    .menu {
      display: none;
      position: absolute;
      top: 100%;
      background: white;
      list-style: none;
      width: 15em;
      padding: 10px 0;

      .is-selected & { display: block; }
    }
    .menu-item {
      color: black;
      display: block;
      padding: 8px 20px;
      text-decoration: none;

      &:hover { background: #29a7f5; color: white; }
    }

By flattening the structure of the CSS I was able to make it much easier to understand and modify. It also helped me conceptually to think about my styles in terms of objects instead of lists. In this example I have a "menubar" and a "menu". Each of those objects have their own child objects called "items" which are distinguished with the "menubar-item" and "menu-item" classes.

Not only is my CSS easier to read, but I was also able to combine two of the rules into one:

      &:hover, .is-selected & { background: #29a7f5; color: white; }

Above I was able write one rule for the hover and selected states of "menubar-item". Before I had written two rules because it was easier with all of the nesting. Keeping your selectors simple will make it easier for you to combine rules when necessary.

Another thing to note is with a tiny bit of modification I could probably make the "menu" styles work for context menus, not just menubars. Which is what modularity is all about.


## Striking a balance

Some of you may have noticed that in the code above I still have a couple of nested selectors. In particular the pseudo class for hover and the class for the selected case. These are both state classes and are a very good use of nesting.

But I also have one selector that is still referencing a child "li" element ("> li"). I wrote it this way because it seemed to be the best balance between the number of classes required and the added weight to my markup. Not everyone would agree with me that this is the best way to mark it up. Some would say that you should ONLY style using classes and avoid tag names entirely. You'll have to find your own balance for your own projects. My point is simply that avoiding nesting can make your Sass code easier to read and maintain.


## The Examples

To write this article I created several [CodePen](http://codepen.io) projects to illustrate various levels of modularity:

* [Simple menu 1](http://codepen.io/jlong/pen/LlCrx) - the non-modular, nested approach.
* [Simple menu 2](http://codepen.io/jlong/pen/wpbzq) - a more modular approach.
* [Simple menu 3](http://codepen.io/jlong/pen/AmwrK) - an ultra-modular approach (using only class selectors).

Let me know which approach you like the best.
