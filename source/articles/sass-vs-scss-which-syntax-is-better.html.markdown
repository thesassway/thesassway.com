---
date: 12 September 2011 7:00am
categories: articles
author: John W. Long
summary: Since the creation of Sass, it has been plagued by many levels of controversy. It billed itself as "a better CSS" and added brand new features unheard of to CSS authors such as variables, nesting and mixins. Sass also introduced an entirely different indentation-oriented syntax and a brand new perspective on how to author CSS. Then the SCSS syntax (Sassy CSS) was introduced ...
---

# Sass vs. SCSS: Which Syntax is Better?

<div class="editors-note">

  <h4>EDITOR'S NOTE</h4>
  <p>Please read this article in its entirely <em>BEFORE</em> sharing your comments. We ask that you keep things civilized. If you plan to share this on Twitter, we encourage you to use the hashtag <a href="http://twitter.com/#!/search/%23SassvsSCSS" class="link external" target="_blank">#SassvsSCSS</a>. Thank you.</p>

</div>

Since the creation of Sass nearly [5 years ago](http://adamstac.com/99xW), it has been plagued by many levels of controversy. It billed itself as "a better CSS" and added brand new features unheard of to CSS authors such as variables, nesting and mixins. Sass also introduced an *entirely different* indentation-oriented syntax and a brand new perspective on how to author CSS.

## The Sass syntax

The indented syntax of Sass was inherited from its first-born brother [Haml](http://haml-lang.com/). And while Sass and Haml once got along -- Hey, they even shared the same [Ruby Gem](http://rubygems.org/)! -- dissension in the family caused the two languages to split and [go their separate ways](http://nex-3.com/posts/103-haml-and-sass-are-split). Each seeking its own fame and fortune in the land of Open Source opportunity.

One common objection among Sass detractors is that the indented syntax is so foreign to CSS. Why spend the time learning a language that is radically different from CSS? This difference, they fear, will make it hard for them to continue to remain fluent in a language with as many [nuances](http://mattwilcox.net/archive/entry/id/1043/) and [subtleties](http://www.thomasknierim.com/154/web-development/selector-subtleties/) as CSS. What if Sass is just a fad? What if it doesn't last? What if it doesn't gain traction among the masses? What if all their code and newly formed best practices fall by the wayside should the "downfalls" of Sass become a reality? What if ... ah, you get the point.

And the objections trail on ...

## SCSS to the rescue!

In [version 3 of Sass](http://sass-lang.com/docs/yardoc/file.SASS_CHANGELOG.html#3-0-0), the SCSS (Sassy CSS) syntax was introduced as "the new main syntax" for Sass and builds on the existing syntax of CSS. It uses brackets and semi-colons just like CSS. It doesn't care about indentation levels or white-space. In fact, Sass's SCSS syntax is a [superset](http://encyclopedia2.thefreedictionary.com/superset) of CSS -- which means SCSS contains all the features of CSS, but has been expanded to include the features of Sass as well. In layman's terms, any valid CSS is valid SCSS. And in the end, SCSS has the exact same features as the Sass syntax, minus the opinionated syntax.

Those who are new to Sass have less to learn. And as for Sass detractors, well, they can no longer complain about the syntax. As far as I'm concerned, SCSS is the new CSS.

## Which syntax is better?

If you are an old hat at Sass, chances are you've got an opinion about which syntax is better. And there are a lot of good people on both sides of the aisle. Some prefer Sass, the original syntax - while others prefer SCSS. Either way, there's no need for panic or worry because [Sass’s indented syntax has not been and will never be deprecated!](/news/sass-is-here-to-stay)

I'm not even going to pretend to be unbiased in this debate. I myself am a huge fan of SCSS. A recent convert, actually. I was once a die-hard fan of the indented syntax, but I've changed my mind on the matter and I wrote this article to share why.

Before I get to that, let me explain the reasons I loved Sass, and why I *almost* didn't give SCSS a chance.

## Pros for Sass

### Reason #1: The Sass syntax is more concise

It's true. The indented syntax removes the need for semi-colons and braces. It doesn't require that you use the verbose `@include` to mixin your mixins. Instead it uses the `+` operator which requires less typing and makes your code simpler, and easier to read.

### Reason #2: The Sass syntax is easier to read

Because of its rules about indentation, it's kind of hard to write unreadable Sass. Sass forces you to write your code the same way every time. There's no option for venturing off and making your own style of commenting and formatting. It's very strict on how things can be done. On large teams or in situations where you aren't the sole author of all the code, this could be a huge plus. It forces the team into more strict coding practices (much like what XHTML did for HTML) and leaves little room for deviation from the beaten path.

### Reason #3: The Sass syntax doesn't complain about missing semi-colons

Ok, I know this probably belongs with reason #1, but I'm listing it separately because it was one of the major reasons I loved the original syntax. Not only did I not have to type semi-colons at the end of every attribute/value pair, but Sass ensured that my output always had the correct semi-colon placement. This is a *huge win* over writing vanilla CSS which doesn't complain about semi-colons (but, the [CSS validator](http://jigsaw.w3.org/css-validator/) does). When I wrote straight CSS I was always surprised by how many times a misplaced semi-colon was the reason a rule didn't get applied properly.

## This isn't a points war

Now, before I get too far ahead of myself, I just want to say that this article isn't a 3 points for Sass, 8 points for SCSS argument. Sure, I list more points for SCSS, but your feelings on each of the points are going to vary. For some, the three points I've stated above as pros for Sass will be persuasive enough to keep you using it. For many, switching back to something more like CSS after using Sass will seem like lunacy. For me that's exactly what it felt like the first time I tried to do a project in SCSS. The brackets and semi-colons were back. A lot of what I hated about CSS was back. It was like taking a step backwards instead of continuing to push forward (that's the point right?). In fact, like any good citizen of the Internet, I tweeted my hatred of SCSS. I had dipped my toes in the water and found it too chilly for my taste. So I hung up my curly-braces and semi-colons and went on my way. Sass was good enough for me just as it was, *thank you very much*. No need to revert back to the dark ages of CSS just to get a more familiar syntax.

## A change of heart?

So, what changed my heart? To tell you the truth I'm not really sure. A lot of it for sure had to do with the fact that my good friend [Brandon Mathis](http://brandonmathis.com/) had recently made the switch to SCSS and felt it was better. Though he offered a couple of sound arguments, which I've reused below, Brandon really didn't try to persuade me too much. Mainly, he just said that he had found he liked it better. It took him a while, of course, but he was much happier now that he had made the switch.

Now Brandon has probably written more Sass than almost anyone I know. He's on the Compass core team and has been using Sass exclusively in his projects for over 4 years now. Needless to say, his opinion holds a lot of weight with me. Also, [Chris Eppstein](http://chriseppstein.github.com/) (the author of [Compass](http://compass-style.org/)) seems to prefer the SCSS syntax. He likes it so much, that he even rewrote all of Compass in it.

I was beginning to question my resolve. So on my next project, instead of giving it a half-hearted try for a day, I decided to go all in and code the whole project in SCSS to compare the difference. The outcome? I found that it took some getting used to (as expected), but I actually began to prefer the new SCSS syntax to the original Sass syntax.

Here's why ...

## Pros for SCSS

### Reason #1: SCSS is more expressive

No really! I know I argued above that Sass is easier to read because of the way it forces you to write your rules and attributes with indentation, but after coding for a while in SCSS I've realized that I really like having the option to put a couple of attribute/value pairs on the same line. I don't always write it this way. Normally, I write in expanded format with an attribute/value pair per line. But the compressed syntax is helpful when I only have an attribute/value pair or two. I especially like it for changing the color of a font for a hover state or adding an underline to a link.

For me SCSS ends up being more logically grouped than Sass. I can compress code that would take several lines in the Sass syntax into just a couple of lines of SCSS. Typically rules are grouped anyway. And when reading code, the number of lines of code that a bit of code uses tends to indicate its importance.

In SCSS I can compress lines that are fairly standard. And expand across several lines when I'm doing something complicated.

### Reason #2: SCSS encourages proper nesting of rules

One of the huge advantages of Sass in general is that it allows you to nest selectors within selectors. This is awesome because when you change the "name" of an element, you only need to change it in one place (the outer selector) instead of in numerous places like you would when writing CSS.

But to quote Spiderman, with great power comes great responsibility.

And with the Sass syntax it really is true. It is too much power. At least for someone like me. Sass code I write tends to get too deeply nested. Why? Because it's too easy to do. Every-time you nest something in Sass you need to be conscious of the impact that it is having on your output code.

Deeply nested Sass produces CSS with *really* long selectors. Especially if you use the comma operator at a high level (which is probably the most dangerous aspect of nesting). Not only is this bad because it increases the file size of the final CSS, too much specificity can become really hard to override in other rules. Importance is the result. You find yourself using `!important` in anger with fists in the air just to get a rule applied correctly.

### Reason #3: SCSS encourages more modular code with @extend

Because nesting is harder in SCSS I find myself using `@extend` a lot more frequently. I tend to write code that is nested 1 - 2 levels deep underneath an abstract or virtual class name that is then extended by other selectors. Again, the curly braces, which are "ugly", help me recognize when my code is too deeply nested and force me down the path of writing more modular code.

Oh, and if you're not using the `@extend` directive, you are really missing out on the awesome-sauce of Sass! [Experts](http://chriseppstein.github.com/blog/2010/08/02/sass-extend-challenge/) [agree](http://awardwinningfjords.com/2010/07/27/sass-extend-introduction.html). :)

### Reason #4: SCSS allows me to write better inline documentation

It's true that the Sass syntax allows a certain amount of flexibility with comments, but I find myself writing more inline-documentation directly in SCSS than Sass. A lot of this has to do with the way the code hangs together and the flexibility in syntax that SCSS provides. Braces help me group my code and comments in a way that makes more sense to me. I know we are talking aesthetics here, but more flexibility makes a difference when writing documentation.

### Reason #5: Existing CSS tools often work with SCSS

I don't actually use a lot of other tools with my CSS, but one area where this is particularly helpful is syntax highlighting. Depending on your editor preference, it may or may not have support for the indented Sass syntax. But most editors already have built-in support for CSS and tend to work well with SCSS. Also, if you do any blogging, most code highlighters support CSS, but only a handful support the Sass syntax.

### Reason #6: Integration with an existing CSS codebase is much easier

I've often had to integrate with other CSS code when building a web site. It's either code from some jQuery library I'm using, or a pre-existing CSS codebase. In the past I've often converted that code to Sass and lost valuable hours in the conversion process.

For a library, the downside is that it's not code that you really want to maintain. When upgrading the library, the last thing you want to do is to go through the conversion process again. If it's an existing codebase, it's often much better to make smaller changes, than to jump into a megalithic refactoring process right away.

SCSS lets you use the existing code as is, and incrementally re-factor as you go along.

It's true that with the indented syntax the `sass-convert` tool can get you most of the way there, but it's never a completely clean conversion.

### Reason #7: SCSS provides a much lower barrier to entry

From a Sass advocacy perspective, it's much easier to convince someone to use SCSS than Sass. It's easier to introduce them to a couple new concepts (SCSS) rather than an entirely new syntax. Designers can be very stubborn, caggy people. They are opinionated, and wary of change. They tend to do what they know well and while they do experiment with new things, experimentation with new technology is not built into the design community like it is for the programming community.

And don't forget the other barriers to getting started with Sass. Right now you need to be familiar with the command prompt. At least enough to run a couple of commands. The command prompt is scary to the mouse-driven, button clicking designer.

### Reason #8: SCSS could become the next version of CSS

Since its creation Sass and languages like it have attracted the attention of [a lot of smart people](http://www.xanthir.com/blog/b49w0). Some of those people are already thinking about adding some of the features that Sass introduced to CSS. It's possible that the syntax introduced in SCSS could become CSS4!

## Conclusion

I hope I've challenged you a little in your own perspective on both syntaxes. While I'm clearly arguing the advantages of the SCSS syntax, I'd also like to encourage you to go outside of your comfort zone and experiment a little more. If you've only been exposed to the SCSS syntax, perhaps you'd enjoy spending some time with the indented Sass syntax. And if you're an original-flavor-only kinda person -- a purist -- you may benefit from giving the SCSS syntax a serious try.

As I said before, there are a lot of good people on both sides of the line in this debate. Feel free to express your own opinion in the comments below.

#### Editor's Note

We've also setup [a Wrangl](http://wrangl.com/sassvsscss) to make sense of both sides of the argument.
