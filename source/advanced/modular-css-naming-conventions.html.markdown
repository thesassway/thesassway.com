---
date: 31 August 2013
categories: advanced, guides
author: John W. Long
summary: The more you write your own stylesheets, the more you begin to value using good names in your code. Naming is by far one the most difficult and debated activities of a developer. To many, naming is an art form.
---

# Modular CSS naming conventions

The more you write your own stylesheets, the more you begin to value using good
names in your code. Naming is by far one the most difficult and debated activities
of a developer. To many, naming is an art form.

Rather than making up my own names I sometimes consult a
pattern library like Dan Cederholm's [Pears](http://pea.rs/) or a front-end framework like
[Bootstrap](http://getbootstrap.com/) to find a good name for a concept.

Naming conventions can help us here as well. They provide an orderly structure
for our names. Naming conventions for classes are the major part of what a
methodology like [SMACSS](http://smacss.com/), [BEM](http://bem.info/), or
[OOCSS](https://github.com/stubbornella/oocss) provides.

In this article I'd like to talk about a couple of my own naming conventions.
These are mostly based on SMACSS and BEM, but have my own twist.


## Learning to think in Objects

Modular CSS is all about learning to think about your CSS in terms of objects.
You could call these objects _modules_ (like SMACSS does), but I prefer to call
them _objects_ in Sass because we often use the term _module_ to refer to [a
library of mixins and
functions](http://thesassway.com/intermediate/a-standard-module-definition-for-sass).

Objects are small little chunks of functionality. You can think of them as
interface elements like headers, footers, buttons, and content areas.

I like to define my objects using only class selectors. ID and tag selectors can
complicate things because [CSS specificity](http://coding.smashingmagazine.com/2007/07/27/css-specificity-things-you-should-know/)
[is a pain](http://csswizardry.com/2011/09/when-using-ids-can-be-a-pain-in-the-class/).
So I avoid using ID or tag selectors in my stylesheets.

Here's an example of a button object in Sass:

    :::scss
    .button {
      background: linear-gradient(#eee, #ccc);
      border: 1px solid #999;
      border-top: 1px solid #aaa;
      border-bottom: 1px solid #888;
      @include border-radius(3px);
      @include box-shadow(white 0 1px 0 inset, rgba(black, 0.1) 0 1px 0 0);
      color: #333;
      cursor: pointer;
      padding: 4px 10px 5px;

      &:hover {
        background: linear-gradient(#fff, #ddd);
        color: #111;
      }
    }

The Sass [ampersand operator](http://thesassway.com/intermediate/referencing-parent-selectors-using-ampersand)
makes it easy to define different states for an object. In this case I defined a
hover state for the button above.


## Parent-Child relationships

Adopting a naming convention for parent-child relationships between objects can
really help clean up your CSS. I talked about this in my earlier article on [the
advantages of avoiding nesting](http://thesassway.com/intermediate/avoid-nested-selectors-for-more-modular-css)
in Sass.

To continue the example from my earlier article:

    :::scss
    .post {
      margin: 2em;

      .title {
        font-size: 2em;
        font-weight: normal;
      }
    }

Would be better written as:

    :::scss
    // Posts
    .post {
      margin: 2em 0;
    }
    .post-title {
      font-size: 2em;
      font-weight: normal;
    }

The chief advantage of this approach is avoiding errors that may occur with
similarly named objects. In the first example, if a title object was declared in
another context it could conflict with the post title. Not so in the second
example. Because the child object is prefixed with the parent object's name it
is less likely that an accidental conflict will occur. Win and win.

This example uses what I like to call the *Parent-Child Pattern* for declaring
this relationship. To use it simply prefix the name of the of the child object
with the name of the parent object. I like to separate with a single dash.

There is one other pattern that can be used for declaring a parent-child
relationship. It's especially handy for a set of objects and their container. I
call it the *Plural Parent Pattern*. Here it is in action for marking up a group
of tabs:

    :::scss
    .tabs {
      border-bottom: 1px solid silver;
      text-align: center;
    }

    .tab {
      background: #e5e5e5;
      border: 1px solid silver;
      @include border-top-radius(3px);
      color: #666;
      display: inline-block;
      padding: 7px 18px 7px;
      text-decoration: none;
      position: relative;
      top: 1px;
    }

To use the *Plural Parent Patern*, simply pluralize the name of the parent object (the
container).


## Subclassing objects

Most object-oriented systems have another concept for declaring that an object is
a kind of another object. It's called subclassing. It's useful for inheriting the
properties of another object while adding additional behavior. It can be used to
better model objects in the real world. For example, a Prius is a kind of car.
It inherits the generic properties of a car (a stearing wheel, four tires,
an engine, etc) and makes a few modifications (hybrid technology).

We can use the same concept in CSS. Let's extend our button example to provide
for dropdown buttons:

    :::scss
    .button {
      background: linear-gradient(#eee, #ddd);
      border: 1px solid #999;
      @include border-radius(5px);
      color: #666;
      cursor: pointer;
      padding: 4px 10px 5px;

      &:hover {
        background: linear-gradient(#fff, #eee);
        color: #111;
      }
    }

    .dropdown-button {
      &::after { content: " \25BE"; }
    }

Here, we've added a subclass for dropdown buttons. To use it, apply both classes
to a button element:

    :::html
    <button class="button dropdown-button">
      Dropdown
    </button>

If you prefer to only use one class in your markup, you can use the Sass
`@extend` directive, as shown in the example below:

    :::scss
    .dropdown-button {
      @extend .button;
      &::after { content: " \25BE"; }
    }

The naming convention I like to use for sub-classes is to preceed the name of
the object with the type of object. In this case, `dropdown-button`.

## Using modifiers

The fourth type of class that I use is called a _modifier_. A modifier can be
used to indicate that the object is in a certain state or to make small
modifications on existing behavior.

For state, I like to use the SMACSS naming convention of prefixing state
classes with `is-`. A common example of a state class is to indicate that
something is selected.

Review the example below, to continue our tabs example from earlier:

    :::scss
    .tab {
      background: #e5e5e5;
      border: 1px solid silver;
      @include border-top-radius(3px);
      color: #666;
      display: inline-block;
      padding: 7px 18px 7px;
      text-decoration: none;
      position: relative;
      top: 1px;

      &.is-selected {
        background: white;
        border-bottom-color: white;
        color: #333;
      }
    }

Notice how I'm using the Sass [ampersand operator](http://thesassway.com/intermediate/referencing-parent-selectors-using-ampersand)
again. In this case I'm using it to tightly associate the `is-selected` modifier
with the `tab` object. This is important because I don't want the rules declared
here to have ramifications on other objects. This tends to be true for most
state modifiers, so I'd recommend trying to always declare them inside of the
original class definition with the ampersand operator (like we've done in the
example above).

The second way that a modifier can be used is to make small changes to existing
behavior.

Here's an example using modifers to allow for different size
textboxes:

    :::scss
    .textbox {
      font: 13px sans-serif;
      border: 1px solid #ccc;
      border-top: 1px solid #999;
      border-radius: 2px;
      padding: 2px 4px;

      &:focus { outline: none; border: 1px solid #69e; }

      &.large { font-size: 18px; }
      &.small { font-size: 11px; padding: 1px 2px; }
    }

Notice that by applying a `large` or `small` modifier to the textbox object we
can now change the size of the textbox. In this case, we also wanted to force
these modifiers to only apply to the `textbox` object so we used ampersand
operator again.

There are times when it makes perfect sense to make a modifer a global modifier.
Here are a couple of examples:

    :::scss
    .clearfix { @include clearfix; }

    .is-hidden    { display:    none !important; }
    .is-invisible { visibility: none !important; }

    .block        { display: block        !important; }
    .inline       { display: inline       !important; }
    .inline-block { display: inline-block !important; }

    .left  { float: left  !important; }
    .right { float: right !important; }

    .text-left   { text-align: left   !important; }
    .text-center { text-align: center !important; }
    .text-right  { text-align: right  !important; }

    .mt0 { margin-top:    0   !important; }
    .mt1 { margin-top:    1em !important; }
    .mb0 { margin-bottom: 0   !important; }
    .mb1 { margin-bottom: 1em !important; }

Global modifers are generally best when they only change a single property.
Often you will need to also use the `!important` flag to declare that they
should override other rules. Also you should be careful about overusing
modifiers like `.mt1` to adjust the top margin of an element. They are useful
for one-offs, but when used frequently for the same purpose they should probably
be rolled into an object definition or subclass.


## Nouns and Adjectives

Now before all of this gets too confusing let me share something that may help
the English-minded folks among us.

**Objects** traditionally are nouns. They take the form of:

    :::scss
    .noun {}            // examples: .button, .menu, .textbox, .header

**Parent-Child** relationships are also nouns:

    :::scss
    .noun {}            // parent: .post
    .noun-noun {}       // child:  .post-title

**Subclasses** are often preceeded by a adjective describing the type of object:

    :::scss
    .adjective-noun {}  // example: .dropdown-button

And **Modifiers** are almost always adjectives (or are used descriptively):

    :::scss
    .is-state {}        // state: is-selected, is-hidden
    .adjective {}       // examples: .left, .right, .block, .inline


## A word on file structure

I've written about [how to structure a Sass project](http://thesassway.com/beginner/how-to-structure-a-sass-project)
in the past. Let me show you how it applies within my own modular CSS
methodology. My `partials` directory is generally filled with files broken out
by object. Here's an incomplete directory listing from a more recent project:

    partials/
    |-- _alerts.scss
    |-- _buttons.scss
    |-- _checkboxes.scss
    |-- _choices.scss
    |-- _countdowns.scss
    |-- _footer.scss
    |-- _forms.scss
    |-- _icons.scss
    |-- _menus.scss
    |-- _messages.scss
    |-- _modifiers.scss
    |-- _panes.scss
    |-- _ratings.scss
    |-- _results.scss
    |-- _selectboxes.scss
    |-- _tableviews.scss
    |-- _textboxes.scss
    |-- _throbbers.scss
    `-- _typography.scss

I like to pluralize my file names because each partial contains the object
defintition along with any of the associated child objects, subclasses, and
modifiers.


## Conclusion

So there you have it: a simple set of naming conventions for more modular CSS.
Again, for my own method I've borrowed a lot from [SMACSS](http://smacss.com/),
[BEM](http://bem.info/), and [OOCSS](https://github.com/stubbornella/oocss).
If you're not familiar with any of these approaches they are well worth reading
up on. You don't have to do modular CSS the way I do. Some folks prefer to use
[different types of separators](http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/)
to distiguish between different types of classes. But the core of the approach
outlined here is common between the major methodologies.
