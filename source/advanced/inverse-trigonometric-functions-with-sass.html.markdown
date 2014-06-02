---
date: 21 May 2014
categories: advanced
author: Ana Tudor
summary: Ana Tudor kicks off her first article for The Sass Way with some crazy CSS demos and a lot of advanced math. Learn how to create `asin()`, `acos()`, and `atan()` functions in pure Sass.
---

# Inverse trigonometric functions with Sass

You might think that math doesn't have a lot to do with writing stylesheets, but you can actually do some amazing things with a little math in CSS. Math (particularly trigonometry) can help you model the real world. You'll need it if you want to do something complicated with 3D transforms. And it can be a lot of fun if you just want to impress your friends.

Here's an example:

<p data-height="544" data-theme-id="394" data-slug-hash="kpCyx" data-default-tab="result" class='codepen'>See the Pen <a href='http://codepen.io/thebabydino/pen/kpCyx'>Pure CSS 3D animated icosidodecahedron (pentagonal gyrobirotunda)</a> by Ana Tudor (<a href='http://codepen.io/thebabydino'>@thebabydino</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//codepen.io/assets/embed/ei.js"></script>

This rotating [icosidodecahedron](http://en.wikipedia.org/wiki/Icosidodecahedron) is an advanced example of what you can do with a trigonometry in CSS. If that's over your head check out [Mason Wendell](https://twitter.com/codingdesigner)'s [*Sassy Mother Effing Text Shadow* demos](http://sassymothereffingtextshadow.com/). Mason makes great use of Compass's `sin()` and `cos()` functions to do some fun stuff with CSS shadows.

I'm a bit of a trigonometry nerd. (Okay, that's probably an understatement!) Sometimes the standard trig functions aren't enough for me. While working on a couple of 2D and 3D CSS demos, I found myself needing to compute the values for angles whose sine, cosine, or tangent was known. I needed `asin()`, `acos()`, and `atan()`. Unfortunately, Compass doesn't provide these functions so I was left with two options:

1. Manually compute the values I needed with a calculator (boring!)
2. Write my own functions with Sass!

Naturally, I chose number two!

Fortunately for me, I stumbled across [an article about writing sine and cosine functions in Sass using Taylor expansions](http://www.japborst.net/blog/sass-sines-and-cosines.html). It occured to me that I could adapt the same method to create the functions I needed.

**Disclaimer:** This is about to get super Math heavy. If you just want to see how the final implementation, skip ahead and look at this [pen](http://codepen.io/thebabydino/pen/KHpys/).


## Trigonometry 101

Before we get too far let's go back and review some basic high school math.

<figure class="figure">
<img class="figure-image" src="/images/articles/basic-trigonometry.svg" alt="right triangle">
<figcaption class="figure-caption">A right triangle</figcaption>
</figure>

This diagram should look somewhat familiar. (If it doesn't, check out MathBFF's video on YouTube: [*Basic Trigonometry: Sin, Cos, Tan*](http://www.youtube.com/watch?v=X5uFqpypDy4).)

Let's review a couple of formulas. In the right triangle diagram above:

$$ α + β = 90° $$

In radians, that's:

$$ \alpha + \beta = \frac{\pi}{2} $$

Most people will also remember that the [Pythagorean theorem](http://en.wikipedia.org/wiki/Pythagorean_theorem) tells us:

$$ a^2 + b^2 = c^2 $$

Our basic trigonometry functions are defined as follows:

$$
\begin{align}
\sin(\alpha) &= a/c\\
\cos(\alpha) &= b/c\\
\tan(\alpha) &= a/b\\
\sin(\beta) &= b/c\\
\cos(\beta) &= a/c\\
\tan(\beta) &= b/a
\end{align}
$$

Knowing this, we can derive a few additional formulas:

$$ \sin^2(\alpha) + \cos^2(\alpha) = \left(\frac{a}{c}\right)^2 + \left(\frac{b}{c}\right)^2 = \frac{a^2 + b^2}{c^2} = 1 $$

$$ \frac{\sin(\alpha)}{\cos(\alpha)} = \frac{(a/c)}{(b/c)} = \frac{a}{b} = \tan(\alpha) $$

$$ \sin(\alpha) = \cos(\beta) = \cos\left(\frac{\pi}{2} - \alpha\right) $$

Head spinning yet? Hold on to your horses...


## The arcsine function

So what is an arcsine? Well, if:

$$ \sin(\alpha) = z $$

Then, the arcsine is the inverse of this:

$$ \arcsin(z) = \alpha $$

In other words, given an angle's sine, arcsine can tell you the angle. Arccosine and arctangent are similar in that they give you the angle based on a cosine or tangent.

We are going to build an `asin()` function in Sass to give us the arcsine. And we're going to do it using series expansion. Taylor series expansion is complicated if you are not a math wiz. I'll do my best to explain. For arcsine it looks something like this:

$$ z + \left(\frac{1}{2}\right)\frac{z^3}{3} + \left(\frac{1\cdot3}{2\cdot4}\right)\frac{z^5}{5} + \left(\frac{1\cdot3\cdot5}{2\cdot4\cdot6}\right)\frac{z^7}{7} + \cdots $$

Now don't freak out on me. Let's deconstruct this: =$z$= is the value of the sine of the =$\alpha$= angle we want to get. The entire sum is the radian value of =$\alpha$=. =$z$= should be a value in the =$[-1, 1]$= interval, while the sum is going to be in the =$[-\pi/2, \pi/2]$= interval.

Every term - including the first one, which you can also write as =$(1) \cdot z$= - is made up out of two parts: the first one is the part inside the paranthesis and the second one is the part outside the paranthesis.

For every =$i$=-th term but the first one, the first part is the first part of the previous term multiplied with =$(2i - 1)/(2i)$=. The numerator of the second part is =$z$= raised to the power =$2i + 1$=, while the denominator is =$2i + 1$=.

This may be an infinite sum, but once we get to a certain term, the values for the terms after it become so small they are really negligible which (for our purposes) means we can safetly ignore them.

But where do we stop? Let's say at a tenth of a degree. The value of one degree in radians is =$\pi/180 \approx 3.14/180 \approx .0175$=. So a tenth of that is =$.00175$=. So when we get to a term that's smaller than =$.00175$=, we stop and whatever value we got up to that point is good enough.

Let's take a few examples.

=$z = 0$=. This is a really easy one because all the terms are =$0$=. So the unitless radian value computed with the help of the series expansion is =$0$= and the degree value is =$0\cdot180°/\pi = 0°$=.

=$z = 1$=. The first term is =$1$=, the second one =$1/6 = .167$=, the third one =$3/40 = 0.075$=, the fourth one =$.045$=, the fifth one =$.030$=, the sixth =$.022$=, the seventh =$.017$=, the eighth =$.014$= and we notice we have a problem. While the terms are obviously decreasing, this decrease is really slowing down and we're still pretty far from our threshold value of =$.00175$= that would allow us to stop.

But how far are we at this point from the correct value? Well, if we sum up the terms we have so far:

$$ 1 + .167 + .075 + .045 + .030 + .022 + .017 + .014 = 1.496 $$

This radian value translates into =$85°$=. Not worlds apart from the correct value, which is =$90°$=, but now it's starting to be increasingly harder to get closer. This leads to too much looping and a slower function. It's one problem that, although to a lesser extent than in this particular case, we have in every situation where the result in absolute value should be in the upper half of the =$[0, π/2]$= interval.

What can do to solve it is first check if the resulting angle in absolute value is over =$\pi/4$= and, if it is, we compute its complement (the =$\pi/2 - \|\alpha\|$=) using this method. Since the sine function is a [monotonically increasing function](http://en.wikipedia.org/wiki/Monotonic_function) over the =$[0, \pi/2]$= interval, what we actually check is whether the absolute value of =$z$= is greater than =$\sin(\pi/4)$=.

But how do we know the sine of the complement of our =$α$= in absolute value? Well, it's equal to the cosine of =$\alpha$= in absolute value: =$\sin(\pi/2 - \|\alpha\|) = \cos(\|\alpha\|)$=. And since =$\sin^2(\|\alpha\|) + \cos^2(\|\alpha\|) = 1$=, we get that =$\cos^2(\|\alpha\|) = 1 - \sin^2(\|\alpha\|) = 1 - z^2$=.


## Coding the `asin()` function

Whew! That's a lot of math! Let's take a look at some code.

First of all, we set a default threshold value for the terms of our sum:

    :::scss
    $default-threshold: pi()/180/10;

Then we start to write our function:

    :::scss
    @function asin($z) {
      $sum: 0;

      @if abs($z) > sin(pi()/4) {
        $z: sqrt(1 - pow($z, 2));
      }

      @return $sum;
    }

We set the sum to be initially `0` and make sure we'll compute the complement if our angle in absolute value is greater than `π/4`. But after that, how do we know we've computed the complement in order to switch to our initial angle?

In order to keep track of that, we introduce a boolean variable, `$complement`, which is initially `false`, but gets switched to `true` inside the `@if` block. Also, before returning `$sum`, we check if the `$complement` variable is `true` and, if it is, we return `pi()/2 - $sum`.

    :::scss
    @function asin($z) {
      $sum: 0;
      $complement: false;

      @if abs($z) > sin(pi()/4) {
        $complement: true;
        $z: sqrt(1 - pow($z, 2));
      }

      @return if($complement, pi()/2 - $sum, $sum);
    }

But this only works right for positive values, so we need to introduce a `$sign` variable that can be `1` or `-1`. We also make `$z` equal to its absolute value for all intermediate computations and multiply with the sign at the end. So our code becomes:

    :::scss
    @function asin($z) {
      $sum: 0;
      $complement: false;
      $sign: $z/abs($z);
      $z: abs($z);

      @if $z > sin(pi()/4) {
        $complement: true;
        $z: sqrt(1 - pow($z, 2));
      }

      @return $sign * (if($complement, pi()/2 - $sum, $sum));
    }

Now let's start to actually add up terms to the sum and set the condition that we stop once we got to a term whose value is smaller than the threshold value which we pass to the function. The first term is `$z`, so we set that before our `@while` loop.

    :::scss
    @function asin($z, $threshold: $default-threshold) {
      $sum: 0;
      $complement: false;
      $sign: $z/abs($z);
      $z: abs($z);

      @if $z > sin(pi()/4) {
        $complement: true;
        $z: sqrt(1 - pow($z, 2));
      }

      $term: $z;

      @while $term > $threshold {
        $sum: $sum + $term;
      }

      @return $sign * (if($complement, pi()/2 - $sum, $sum));
    }

At this point, unless the starting value for `$term` happens to be smaller than `$threshold`, our `@while` loop is an infinite one because we're not changing `$term` inside. So let's compute a new one with each iteration. In order to do that, we initialize two more variables before the loop. One is `$i`, the current term's index, while the second one is `$k`, the part inside the paranthesis for the previous term. After that, inside the loop, we keep incrementing `$i` and recomputing `$k` and `$term`.

    :::scss
    @function asin($z, $threshold: $default-threshold) {
      $sum: 0;
      $complement: false;
      $sign: $z/abs($z);
      $z: abs($z);

      @if $z > sin(pi()/4) {
        $complement: true;
        $z: sqrt(1 - pow($z, 2));
      }

      $term: $z;
      $i: 0;
      $k: 1;

      @while $term > $threshold {
        $sum: $sum + $term;

        $i: $i + 1;
        $k: $k*(2*$i - 1)/(2*$i);
        $j: 2*$i + 1;

        $term: $k*pow($z, $j)/$j;
      }

      @return $sign * (if($complement, pi()/2 - $sum, $sum));
    }

And this is it! We now have a working `asin()` function in Sass!

One thing more we could do to improve this is to check whether `abs($z) <= 1` and throw an error if it returns false because, in such a case, our `$term` won't get under the `$threshold` value and we'll have an infinite loop.


## Coding the `acos()` function

Now that we have a function to calculate the arcsine, it's actually pretty easy to code an `acos()` function. We can  use the fact that, in the case of an angle =$\alpha$= in the =$[0, \pi]$= interval, =$\cos(\alpha) = \sin(\pi/2 - \alpha)$=. If we know =$\cos(\alpha) = z$=, then =$\arcsin(z) = \pi/2 - \alpha$=, which gives us that =$\alpha = \pi/2 - z$=.

    :::scss
    @function acos($z, $threshold: $default-threshold) {
      @return pi()/2 - asin($z, $threshold);
    }


## Coding the `atan()` function

For the `atan()` function, we start from the fact that =$\tan(\alpha) = \sin(\alpha)/\cos(\alpha)$=. We also know that =$\sin^2(\alpha) + \cos^2(\alpha) = 1$=, so we have that =$\tan^2(\alpha) = \sin^2(\alpha)/(1 - \sin^2(\alpha))$=. From this equality, we extract the sine depending on the tangent:

$$ \sin^2(\alpha) = \frac{\tan^2(\alpha)}{(1 + \tan^2(\alpha))} $$

But we also know that =$\tan(\alpha) = z$=, so:

$$ \sin^2(\alpha) = \frac{z^2}{1 + z^2} $$

Which can be simplified to:

$$ \alpha = \arcsin\left(\frac{z}{\sqrt{(1 + z^2)}}\right) $$

So our `atan()` function is:

    :::scss
    @function atan($z, $threshold: $default-threshold) {
      @return asin($z/sqrt(1 + pow($z, 2)), $threshold);
    }


## Making these functions easier to use in CSS

Remember, the values returned by these functions are unitless radian values. We can't use them as they are in our CSS, we need to at least multiply with `1rad` or even do some sort of unit conversion. But what if we could specify the unit when we call the function? For example:

    :::scss
    transform: rotate(asin(.5, 'deg'));

In order to do that, we first need an angle conversion function that takes a unitless radian value and converts it to a unit we specify. For example:

    :::scss
    $in-degrees: convert-angle(pi()/4, 'deg');
    $in-turns: convert-angle(pi()/2, turn); // works with both the unit name quoted or unquoted


## Coding an angle conversion function

We start by creating a table of conversion factors from the unitless radian value to the CSS angular units. With Sass, this table becomes a map:

    :::scss
    $factors: (
      rad: 1rad,
      deg: 180deg/pi(),
      turn: .5turn/pi(),
      grad: 200grad/pi()
    );

Then we only need to multiply our initial unitless radian value to the appropriate factor. Which means that our function is just:

    :::scss
    @function convert-angle($value, $unit-name) {
      $factors: (
        rad: 1rad,
        deg: 180deg/pi(),
        turn: .5turn/pi(),
        grad: 200grad/pi()
      );

      @return $value*map-get($factors, $unit-name);
    }

This fails if `$unit-name` isn't a key of the `$factors` map and isn't valid in our CSS if `$value` already has a unit, so let's take care of that as well.

    :::scss
    @function convert-angle($value, $unit-name) {
      $factors: (
        rad: 1rad,
        deg: 180deg/pi(),
        grad: 200grad/pi(),
        turn: .5turn/pi()
      );

      @if not unitless($value) {
        @warn '`#{$value}` should be unitless';
        @return false;
      }

      @if not map-has-key($factors, $unit-name) {
        @warn 'unit `#{$unit-name}` is not a valid unit - please make sure it is either `deg`, `rad`, `grad` or `turn`';
        @return false;
      }

      @return $value*map-get($factors, $unit-name);
    }


## Improving the inverse trigonometric functions

Now we just need to change our inverse trigonometric functions to take care of unit conversion as well:

    :::scss
    @function asin($z, $unit-name: deg, $threshold: $default-threshold) {
      // same as before, nothing changes here

      @return convert-angle($sign*(if($complement, pi()/2 - $sum, $sum)), $unit-name);
    }

    @function acos($z, $unit-name: deg, $threshold: $default-threshold) {
      @return convert-angle(pi()/2, $unit-name) - asin($z, $unit-name, $threshold);
    }

    @function atan($z, $unit-name: deg, $threshold: $default-threshold) {
      @return asin($z/sqrt(1 + pow($z, 2)), $unit-name, $threshold);
    }

I've chosen to use degrees as the default because that's probably the one most people understand best and use. I've also placed it before `$threshold` because it's still more likely that somebody might want to change the unit.


## Final words

Well, you've been a real trooper if you've made it this far! The complete functions can be found in this pen:

<p data-height="544" data-theme-id="394" data-slug-hash="KHpys" data-default-tab="css" class='codepen'>See the Pen <a href='http://codepen.io/thebabydino/pen/KHpys'>Inverse trigonometric functions</a> by Ana Tudor (<a href='http://codepen.io/thebabydino'>@thebabydino</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//codepen.io/assets/embed/ei.js"></script>

I'll leave you with two additional CodePen demos to inspire you:

* [A regular dodecahedron expanding into an icosidodecahedron and then collapsing into an icosahedron](http://codepen.io/thebabydino/pen/qDziw)
* [A stretchy graphical mesh](http://codepen.io/thebabydino/pen/dlGJI)

More can be found on [my CodePen page](http://codepen.io/thebabydino/).
