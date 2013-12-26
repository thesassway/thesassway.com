---
Date: 22 August 2011
Categories: advanced, guides, mason-wendell
Author: Mason Wendell
about_author: mason_wendell
Summary: Sass gladly lets you add calculations and logic in a way that CSS would never abide. But does that mean you should go around adding and dividing just anywhere? Find out how you can use pure Sass functions to make reusable logic more useful and your working Sass file more readable.
---

# Using pure Sass functions to make reusable logic more useful

Sass gladly lets you add calculations and logic in a way that CSS would never abide. But does that mean you should go around adding and dividing just anywhere? Find out how you can use pure Sass functions to make reusable logic more useful and your working Sass file more readable.

## Sass adds Functions

Sass has [mixins](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#mixins), we all know that. And because they accept arguments I always thought of them as Sass's version of functions. Pretty sweet. But when [Sass 3.1.0](http://sass-lang.com/docs/yardoc/file.SASS_CHANGELOG.html#310) came out it added a feature that blew that notion apart. Yeah, you guessed it ... actual [functions](http://sass-lang.com/docs/yardoc/file.SASS_CHANGELOG.html#sassbased_functions). Instead of outputting lines of Sass the way mixins do, functions return a value. This makes them a super powerful behind-the-scenes player in a lot of my favorite Sass recipes. 

## Mixins and Functions: Kissing Cousins

Functions and mixins are very similar in nature. Because they can both accept variables, you might end up creating a mixin when what you really need is a function. In the following examples, we review the creation, usage and output of both a mixin and a function.

### Exhibit A: Mixin

The following mixin can accept arguments and do calculations. The output of this mixin (in this case) is a CSS rule and will be unfurled where ever you `@include` it.

    :::scss
    @mixin my-padding-mixin($some-number) {
      padding: $some-number;
    }

Now we use the `@include` directive to insert our mixin's code.

    :::scss
    .my-module {
      @include my-padding-mixin(10px);
    }

And here is the output CSS code.

    :::css
    .my-module {
      padding: 10px;
    }

### Exhibit B: Function

A function is very similar to a mixin, however the output from a function is a single value. This can be any Sass [data type](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#data_types), including: numbers, strings, colors, booleans, or lists.

The following function can accept 2 arguements, `$some-number` and `$another-number`. The value returned are those two variables added together.

    :::scss
    @function my-calculation-function($some-number, $another-number){
      @return $some-number + $another-number
    }

This time around we replace the common value of the `padding` property with what a snippet of [SassScript](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#sassscript) to call our function, pass it the arguments and include in our output CSS code.

    :::scss
    .my-module {
      padding: my-calculation-function(10px, 5px);
    }

And here is the output CSS code.

    :::css
    .my-module {
      padding: 15px;
    }

### Readable, DRY Sass

As you can see, functions help you write more readable and DRY Sass by letting you move your reusable logic out of specific declarations and even out of your mixins. This can make all the difference in the world when you're working on something that's even a little bit complex.

## Using Functions

I love how writing Sass lets me think like a programmer when I'm writing CSS. It's very satisfying to refactor and abstract the methods behind successful techniques to make them reusable and portable for the next project.

**Pro tip**: Use functions when you need to calculate a value that may be reused somewhere else.

In Ethan Marcotte's lovely new book [*Responsive Web Design*](http://www.abookapart.com/products/responsive-web-design), he stresses the formula for calculating the percent value for a width so you can achieve a fluid layout based on a reference design made using pixels.

    target / context = result


So if you have a container that's 1000px wide, and a module that's designed to be 650px wide, that calculation becomes: 


    650px / 1000px = 65% 


That's as clear a case for a function as I can imagine. It would be overkill to work that logic into each mixin for a site, and even worse to do those calculations in line. So in a recent project I just created a little function, like so:

    :::scss
    @function calc-percent($target, $container) {
      @return ($target / $container) * 100%;
    }

**Pro tip**: Create short-names for functions and mixins that you will be using often.

For example, for the above function, I created the short-name below. It simply collects the needed arguments, and passes it along to its sister with the longer name, and then returns the value.

    :::scss
    @function cp($target, $container) {
      @return calc-percent($target, $container);
    }

With that in place, I can easily remove the mechanics of that process out of my view, and focus on writing my Sass using the values I already know.

    :::scss
    .my-module {
      width: calc-percent(650px, 1000px);
    }

or     

    :::scss
    .my-module {
      width: cp(650px, 1000px);
    }

Either of which simply output this CSS.

    :::css
    .my-module {
      width: 65%;
    }

This is a simple example, but I think it's a pretty useful one, especially if you'd rather have Sass do the math for you. Once you start pulling a few calculations into Sass functions, you'll start to see how they open up new ways to write lighter, cleaner Sass that's more readable.

## Homework: Dig Deeper by reading the source code

Sass functions have become an indispensable tool for me in all my latest projects. I've heard from many others that is the case for them as well. If you dig into [the](http://compass-style.org/reference/blueprint/grid/) [source](http://compass-style.org/reference/compass/layout/grid_background/) [code](http://compass-style.org/reference/compass/typography/vertical_rhythm/) of [Compass](http://www.abookapart.com/products/responsive-web-design) you will see that a lot of real heavy lifting is done by some well-placed functions.