Date: 28 August 2011 17:00
Categories: intermediate, guides, john-w-long
Author: John W. Long
Summary: Without question, one of the most powerful and valuable features of Sass is the ability to package up existing code into reusable chunks of code called _mixins_.

# Leveraging Sass Mixins for Cleaner Code

Without question, one of the most powerful and valuable features of Sass is the ability to package up existing code into reusable chunks of code called _mixins_.

## Mixins are like macros

Mixins are the Sass equivalent of macros in other programming languages. If you've programmed before you could think of them as functions, procedures, or methods, but they aren't technically any of these concepts because their function is to _generate_ code at compile time not _execute_ code at run time.


## How Mixins Work

The [Compass project](http://compass-style.org/) is chock full of [mixins](https://github.com/chriseppstein/compass/tree/stable/frameworks/compass/stylesheets/compass) to make your life easier. From [CSS3](https://github.com/chriseppstein/compass/tree/stable/frameworks/compass/stylesheets/compass/css3), to [typography](https://github.com/chriseppstein/compass/tree/stable/frameworks/compass/stylesheets/compass/typography), to [layout](https://github.com/chriseppstein/compass/tree/stable/frameworks/compass/stylesheets/compass/layout), to [image manipulation](https://github.com/chriseppstein/compass/tree/stable/frameworks/compass/stylesheets/compass/utilities/sprites), Compass makes it easy to write bullet-proof CSS that works across browsers. We like to think of Compass as the standard library for Sass.

The CSS3 support in Compass is perhaps the most rocking aspect of the project. Compass provides an assortment of CSS3 mixins that make it easy to take advantage of these new features in a way that works across browsers.

For instance. The [border-radius mixin](http://compass-style.org/reference/compass/css3/border_radius/) lets you use the new `border-radius` attribute in a succinct way:

    :::scss
    a.button {
      background: black;
      color: white;
      padding: 10px 20px;
      @include border-radius(5px);
    }

This would output:

    :::css
    a.button {
      background: black;
      color: white;
      padding: 10px 20px;
      -moz-border-radius: 5px;
      -webkit-border-radius: 5px;
      -ms-border-radius: 5px;
      -o-border-radius: 5px;
      -khtml-border-radius: 5px;
      border-radius: 5px;
    }

Looking at the output you can see that the `border-radius` mixin outputs _six lines of code_. These six lines allow you to use [border-radius](http://www.w3.org/TR/css3-background/#corners) across all of the modern web browsers. (The cool part is that if you wrote this code on your own, you probably would not have included support for Opera (-o) or Konquerer (-khtml), but Compass gives you all this for free!)

Above, I used the `@include` directive to tell Sass that I wanted to call out to a mixin. This was followed by the name of the mixin, `border-radius`. Followed by parentheses enclosing the arguments to pass the mixin. The `border-radius` mixin only has one argument. In this case `5px` is passed as the value of the first argument.


## Writing Your Own

Let's look at the source for the border-radius mixin above. For the purpose of illustration I'm going to show you a simplified version of the mixin. [The actual version from Compass](https://github.com/chriseppstein/compass/blob/stable/frameworks/compass/stylesheets/compass/css3/_border-radius.scss) is a bit more complicated, but this will give you a good idea of how to write your own:

    :::scss
    @mixin border-radius($radius) {
      -moz-border-radius: $radius;
      -webkit-border-radius: $radius;
      -ms-border-radius: $radius;
      border-radius: $radius;
    }

The declaration begins with the directive `@mixin` and is followed by the name of the mixin. In this case `border-radius`. The name of the mixin can contain any combination of alpha and numeric characters without spaces. Then comes the list of arguments that the mixin accepts enclosed in parentheses `( ... )`. The mixin above only has one argument `$radius`. Multiple arguments can be used as long as they are separated by commas.

Next comes the definition of the mixin enclosed in braces `{ ... }`. The definition of the mixin can contain any combination of CSS attributes. You can even declare additional rules (with selectors) that will be mixed into your CSS along with the attributes.

In this case, the `border-radius` mixin includes a series of CSS attributes to set the value of the `border-radius` attribute for all of the major browsers who have implemented it with browser-specific prefixes and the final `border-radius` attribute to future-proof the attribute because it has been officially accepted as part of the CSS3 spec.

The `$radius` argument, or _variable_ is used to set the value of each of the CSS attributes. Using this technique you can pass one value to the mixin and it will be repeated four times in the output. This reduces the likelihood that you will miss-type the value for one or more of the browser-specific attributes (if you were to type this out by hand instead of using the mixin) and also saves a lot of typing.


## Default Arguments

You could improve this mixin by adding a default value for the `$radius` argument, like this:

    :::scss
    @mixin border-radius($radius: 5px) {
      ...
    }

This makes the `$radius` argument optional. So you can call the mixin without it like this:

    :::scss
    @include border-radius;

Which would output the attributes with the default value in the argument list of the declaration. In this case `5px` because that's what we declared above.

Another trick that can be quite useful is to declare a variable beforehand and use that as the default value for the mixin:

    :::scss
    $default-border-radius: 5px !default;
    @mixin border-radius($radius: $default-border-radius) {
     ...
    }

This is especially useful for code that you share between projects. Set the default by modifying the global variable, and override the value as needed.

## Keyword Arguments

One final mixin feature that is new as of [Sass 3.1](http://sass-lang.com/docs/yardoc/file.SASS_CHANGELOG.html#310) is _keyword arguments_. Keyword arguments are especially useful when a mixin accepts multiple arguments. If the arguments are defaulted, you can use the name of the argument to set the specific value for an argument, without passing the values of the other arguments.

Used with `@if` conditionals, we can make an even better version of the `border-radius` mixin:

    :::scss
    @mixin border-radius($radius: 5px, $moz: true, $webkit: true, $ms: true) {
      @if $moz    { -moz-border-radius:    $radius; }
      @if $webkit { -webkit-border-radius: $radius; }
      @if $ms     { -ms-border-radius:     $radius; }
      border-radius: $radius;
    }

The code above conditionally outputs the code for Firefox, Safari, and Internet Explorer based on the values of `$moz`, `$webkit`, and `$ms`, respectively. Since all of the arguments have default values, you could turn off support for just Internet Explorer by calling the mixin like this:

    :::scss
    @include border-radius($ms: false);

This is much simpler than calling the mixin with each of the arguments without names:

    :::scss
    @include border-radius(5px, true, true, true);

With keyword arguments, you don't even have to call out to the mixin with the arguments in the same order that they were declared:

    :::scss
    @include border-radius($ms: false, $radius: 10px);


## Conclusion

That about wraps up this overview of Sass mixins. To get a better idea of how you can use them in your code, I recommend taking a look at the source code for a mature Sass project like [Compass](https://github.com/chriseppstein/compass) which includes over 200 mixins you can use to learn a lot of great techniques from. Also, [the Compass docs](http://compass-style.org/reference/compass/) actually include "View Source" links that make it easy to check out the code for any mixin to see what it does. You can start by checking out [the actual implementation of border-radius](http://compass-style.org/reference/compass/css3/border_radius/#mixin-border-radius-source).
