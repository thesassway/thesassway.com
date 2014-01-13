---
date: 2011-12-02 17:00:00 -0600
categories: intermediate, guides
author: Mason Wendell
summary: In part one we talked about how Sass can help with fluid layouts and images. Now we'll turn our attention to the new kid in town. Media queries are the tool that takes a design from fluid to truly responsive.
---

# Responsive Web Design in Sass Part 2: Media Queries in Sass

<div class="editors-note">

  <h4>EDITOR'S NOTE</h4>
  <p>Mason followed up this article with <a href="/intermediate/responsive-web-design-in-sass-using-media-queries-in-sass-32">Responsive Web Design in Sass: Using Media Queries in Sass 3.2</a></p>

</div>

In [part one](/intermediate/responsive-web-design-part-1) we talked about how Sass can help with fluid layouts and images. Now we'll turn our attention to the new kid in town. Media queries are the tool that takes a design from fluid to truly responsive.

## I Resisted Fluid Layouts (too)

Fluid or elastic layouts allow your site's content to grow and shrink to fit the screen, so that solves the problem right? OK. See you later.

I didn't think so either. As much as I wanted to, I just couldn't get on board with all the rage of fluid and elastic layouts. Personally, I resisted them for for one primary reason.

Not ***all*** layouts work at ***all*** sizes.

When a layout of mine grew or shrank outside the "sweet spot" of my design I felt that it usually ruined the balance and composition of the design. At least when I made a fixed layout I could place the burden of having a big enough screen on the user.

It's clear to me now that with the explosion of newly connected devices, placing the burden of having the right size screen on the user is no longer a suitable solution. It's a recipe for failure.

    :::html
    <q class="smug-designer">
      "It wasn't <em>my</em> fault they were on a netbook.
      I'm concerned with "mainstream" (desktop) users."
    </q>

But, I knew designing to a fixed layout was a cheat and I hated horizontal scroll bars as much as my users and clients did. I just didn't know of a way to do fluid layouts without compromising my design.

And then, my jaw dropped along with all the other web nerds when I read [Ethan Marcotte’s article](http://www.alistapart.com/articles/responsive-web-design/) on A List Apart. All hail media queries!

## What are media queries and why should I care?

If you've ever created a print style sheet you've used media-specific CSS. In that case you called a separate CSS file just for print by setting the `media` attribute of a link:

    :::html
    <link rel="stylesheet" href="paper.css" media="print" />

This gave us some control over media types, but that's it. Then CSS3 introduced the concept of using a query in that space as well. You can add your query in the `<link>` tag, or join the cool kids and use the `@media` rule in CSS. More on that later.

First let's look at what kind of queries we can write. If you look at the [W3C Spec](http://www.w3.org/TR/css3-mediaqueries/#media1) you'll see a dazzling array of different properties you can check. The ones I'm most interested in are the ones concerning width, height, orientation, and ratio. By swapping out different rules based on these properties you can change the size and shape of your design to truly fit the viewing area.

Here's a simple query in the `<link>` tag that will load a css file for small screens.

    :::html
    <link rel="stylesheet" media="screen and (max-width: 480px)" href="small.css" />

This is great, but if we want to manage a lot of different options these files can add up quickly. Fortunately we have the `@media` rule. You can use these inside any CSS file to apply specific rules only when the query expression is true.

Here I'm setting the `font-size` of an `<h1>` to be larger on a large screen.

    :::scss
    // set a variable for the font size
    $h1-size: 36px

    h1 {
      font-size: $h1-size;
    }

    // this will only affect wide screens
    @media screen and (min-width: 1024px) {
      h1 {
        font-size: $h1-size * 1.5;
      }
    }

Which compiles to:

    :::css
    h1 {
      font-size: 36px;
    }
    @media screen and (min-width: 1024px) {
      h1 {
        font-size: 54px;
      }
    }

You can use these in Sass just fine, and inside a query you can use all the Sass features you like. In the above example I used and manipulated a variable. You should note, however, that you can't use variables in the query declaration itself. It would be nice to write the following, but it won't work.

    :::scss
    $breakpoint: 1024px;

    @media screen and (min-width: $breakpoint) {
      content: "this won't work :(";
    }

*[Skip ahead](#the_future_of_media_queries_in_sass) to see how the upcoming Sass 3.2 release will help with this.*

## @media Bubbling

Sass does provide what I consider to be a pretty ***killer feature*** for authoring @media when you nest them inside other selectors. If you add a @media query by nesting it inside a selector Sass will "bubble" that @media query and the new rule outside of the nest and back out to the root of your style sheet.

I use @media un-nested (as mentioned above) when I'm setting up large-scale changes like a responsive master grid, but I find that I need to make small adjustments much more often. For example, lets say you have a profile picture that looks great large and floated to the left on a desktop, but needs to shrink on a smaller screen. It also needs to stop floating on a really wide screen.

In Sass we can write that like this.

    :::scss
    .profile-pic {
      float: left;
      width: 250px;
      @media screen and (max-width: 320px) {
        width: 100px;
      }
      @media screen and (min-width: 1200px) {
        float: none;
      }
    }

Sass will see this and know that you want to apply that query to the selector it's nested in. It compiles to CSS like so:

    :::css
    .profile-pic {
      float: left;
      width: 250px;
    }
    @media screen and (max-width: 320px) {
      .profile-pic {
        width: 100px;
      }
    }
    @media screen and (min-width: 1200px) {
      .profile-pic {
        float: none;
      }
    }

I really like how this lets me keep my rules for the different options adjacent to both the original rule and to each other. It really speeds up the process, especially when you turn to the details of your responsive project.

When I was designing the homepage for [The Coding Designer's Survival Kit](http://thecodingdesigner.com/) I made a module where the elements laid out in a circle that took up a lot of space in the wide screen version of the design. However in any width lower than 900px they overflowed the boundary and the circle no longer made sense. In this case the best design decision was to lay those elements out in another way, and I chose a grid. If you're curious you can [view my source](https://github.com/canarymason/The-Coding-Designer-s-Survival-Kit-Site/blob/master/sites/all/themes/badge/css/src/_design.sass#L328) sass for that project.

## The Future of Media Queries in Sass

<div class="editors-note">

  <h4>EDITOR'S NOTE</h4>
  <p>Mason followed up this article with <a href="/intermediate/responsive-web-design-in-sass-using-media-queries-in-sass-32">Responsive Web Design in Sass: Using Media Queries in Sass 3.2</a></p>

</div>

Sass 3.2 is about to make all this calculating absolutely trivial. At the moment, Sass 3.2 is only available as [an Alpha release](https://rubygems.org/gems/sass/versions/3.2.0.alpha.35). There's [a milestone](https://github.com/nex3/sass/issues/milestones) on [Sass's GitHub project](https://github.com/nex3) as well that's at the 33% mark.

In my examples above you may have noticed that all the media queries were written out and included the pixel value for each break point, in every media query I used. "What? Where are the variables?", you asked? Well it turns out that until 3.2, which is yet to be released, Sass didn't support variables in media queries. Well, strictly speaking it still doesn't. But, Sass 3.2 introduces the ability to pass content blocks to functions. Chris Eppstein [published a gist](https://gist.github.com/1215856#file_6_media_queries.scss) showing how you might use this. I'll use these new mixins to redo my profile picture example:

    :::scss
    @mixin respond-to($media) {
      @if $media == handhelds {
        @media only screen and (max-width: 320px) { @content; }
      }
      @else if $media == medium-screens {
        @media only screen and (min-width: 321px) and (max-width: 1024px) { @content; }
      }
      @else if $media == wide-screens {
        @media only screen and (min-width: 1024px) { @content; }
      }
    }

    .profile-pic {
      float: left;
      width: 250px;
      @include respond-to(handhelds) { width: 100% ;}
      @include respond-to(medium-screens) { width: 125px; }
      @include respond-to(wide-screens) { float: none; }
    }

And the compiled css:

    :::css
    .profile-pic {
      float: left;
      width: 250px;
    }
    @media only screen and (max-width: 320px) {
      .profile-pic {
        width: 100%;
      }
    }
    @media only screen and (min-width: 321px) and (max-width: 1024px) {
      .profile-pic {
        width: 125px;
      }
    }
    @media only screen and (min-width: 1024px) {
      .profile-pic {
        float: none;
      }
    }

This makes it possible to set up a mixin for all your @media breakpoints and reuse that as often as you need. This makes it incredibly easy to keep track of all the different ways your styles may fracture as you do specific styling in each breakpoint. I have to say it got me salivating. I can tell you are too. Once that feature is in place we should be able to create some very smart mixins and templates for media queries (and other tricks too!) and responsive grid frameworks.

### Sass 3.2 Alpha

You can try out the new Sass 3.2 features I've talked about in this article before its official release by installing it with this command:

    gem install sass --pre

Or, if you use [Bundler](http://gembundler.com/), simply add this to your `Gemfile` and `bundle install`.

    gem "sass", "~> 3.2.0.alpha.35"
