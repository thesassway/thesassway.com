---
date: 21 May 2014
categories: advanced
author: Anna Tudor
summary: need to write something here
---

# Inverse trigonometric functions with Sass

## How it all started

While creating various 2D or 3D CSS demos, I found myself needing to compute the values for angles whose sine, cosine or tangent was known. Compass provides `sin()`, `cos()` or `tan()` functions, but not the inverse ones. So I had two options. The first one was to manually compute the values or simply grab them from a mathematical table. The second one was to write my own functions.

How? Well, a couple of months before, I had stumbled onto [an article about writing sine and cosine functions in Sass using Taylor expansions](http://www.japborst.net/blog/sass-sines-and-cosines.html), so I thought I'd use the same method for the inverse ones. Actually, just for the arcsine, because, once I have that one function, I can use it to compute the arccosine and the arctangent.

## Maths basics

Before we get into how to build this function, let's start with a short trigonometry recap.

![right triangle](http://i.imgur.com/1ssIKUT.png)

In the right triangle above, we have that `α + β = π/2` (`π/2` is the radian value for `90°`).

Pythagora's theorem tells us that <code>a<sup>2</sup> + b<sup>2</sup> = c<sup>2</sup></code>.

We also have that: 

    sin(α) = a/c
    cos(α) = b/c
    tan(α) = a/b
    sin(β) = b/c
    cos(β) = a/c
    tan(β) = b/a

We notice a few things from these formulas:

<code>sin<sup>2</sup>(α) + cos<sup>2</sup>(α) = (a/c)<sup>2</sup> + (b/c)<sup>2</sup> = (a<sup>2</sup> + b<sup>2</sup>)/c<sup>2</sup> = 1</code>

`sin(α)/cos(α) = (a/c)/(b/c) = a/b = tan(α)`

`sin(α) = cos(β) = cos(π/2 - α)`.

## The arcsine function

But what's with the arcsine function? Well, if we have `sin(α) = z`, then `α = asin(z)`. If we have `cos(α) = z`, then `α = acos(z)` and if we have `tan(α) = z`, then `α = atan(z)`.

The `asin()` function is the one that we're going to build using its series expansion - which looks something like this:

![arcsine expansion](http://i.imgur.com/RnX5sTf.png)

I know it looks ugly and scary, but let's deconstruct it. `z` is the value of the sine of the `α` angle we want to get and the entire sum is the radian value of `α`. `z` should be a value in the `[-1, 1]` interval, while the sum is going to be in the `[-π/2, π/2]` interval.

Every term - including the first one, which you can also write as `(1)*z` - is made up out of two parts: the first one is the part inside the paranthesis and the second one is the part outside the paranthesis.

For every `i`-th term but the first one, the first part is the first part of the previous term multiplied with `(2*i - 1)/(2*i)`. The numerator of the second part is `z` raised to the power `2*i + 1`, while the denominator is `2*i + 1`.

This may be an infinite sum, but once we get to a certain term, the values for the terms after it become negligible and we can stop adding them to the angle value we already have because the human eye is never going to be able to perceive the really small angular difference that the infinite number of really small terms we leave out adds up to.

But where do we stop? Well, let's say a tenth of a degree. The value of one degree in radians is `π/180 = 3.14/180 = .0175`, so a tenth of that is going to be `.00175`. So when we get to a term that's smaller than `.00175`, we stop and whatever value we got up to that point, it's good enough.

Let's take a few examples.

`z = 0`. This is a really easy one because all the terms are `0`. So the unitless radian value computed with the help of the series expansion is `0` and the degree value is `0*180°/π = 0°`.

`z = 1`. The first term is `1`, the second one `1/6 = .167`, the third one `3/40 = 0.075`, the fourth one `.045`, the fifth one `.030`, the sixth `.022`, the seventh `.017`, the eighth `.014` and we notice we have a problem. While the terms are obviously decreasing, this decrease is really slowing down and we're still pretty far from our threshold value of `.00175` that would allow us to stop.

But how far are we at this point from the correct value? Well, if we sum up the terms we have so far:

`1 + .167 + .075 + .045 + .030 + .022 + .017 + .014 = 1.496`

This radian value translates into `85°`. Not worlds apart from the correct value, which is `90°`, but now it's starting to be increasingly harder to get closer. This leads to too much looping and a slower function. It's one problem that, although to a lesser extent than in this particular case, we have in every situation where the result in absolute value should be in the upper half of the `[0, π/2]` interval.

What can do to solve it is first check if the resulting angle in absolute value is over `π/4` and, if it is, we compute its complement (the `π/2 - |α|`) using this method. Since the sine function is a [monotonically increasing function](http://en.wikipedia.org/wiki/Monotonic_function) over the `[0, π/2]` interval, what we actually check is whether the absolute value of `z` is greater than `sin(π/4)`.

But how do we know the sine of the complement of our `α` in absolute value? Well, it's equal to the cosine of `α` in absolute value: `sin(π/2 - |α|) = cos(|α|)`. And since <code>sin<sup>2</sup>(|α|) + cos<sup>2</sup>(|α|) = 1</code>, we get that <code>cos<sup>2</sup>(|α|) = 1 - sin<sup>2</sup>(|α|) = 1 - z<sup>2</sup></code>.

## Coding the `asin()` function

Alright, let's see how we code all this!

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

      @return $sign*(if($complement, pi()/2 - $sum, $sum));
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

      @return $sign*(if($complement, pi()/2 - $sum, $sum));
    }

At this point, unless the starting value for `$term` happens to be smaller than `$threshold`, our `@while` loop is an infinite one because we're not changing `$term` inside. So let's compute a new one with each iteration. In order to do that, we initialize two more variables before the loop. One is `$i`, the current term's index, while the second one is `$k`, the part inside the paranthesis for the previous term. After that, inside the loop, we keep incrementing `$i` and recomputing `$k` and `$term`.

    :::scss
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

And this is it! We now have a working `asin()` function in Sass!

One thing more we can do to improve it is to check whether `abs($z) <= 1` and throw an error if it returns false because, in such a case, our `$term` won't get under the `$threshold` value and we'll have an infinite loop.

## Coding the `acos()` function

For our `acos()` function, we use the fact that, in the case of an angle `α` in the `[0, π]` interval, `cos(α) = sin(π/2 - α)`. If we know `cos(α) = z`, then `asin(z) = π/2 - α`, which gives us that `α = π/2 - z`.

    :::scss
    @function acos($z, $threshold: $default-threshold) {
      @return pi()/2 - asin($z, $threshold);
    }

## Coding the `atan()` function

For the `atan()` function, we start from the fact that `tan(α) = sin(α)/cos(α)`. We also know that <code>sin<sup>2</sup>(α) + cos<sup>2</sup>(α) = 1</code>, so we have that <code>tan<sup>2</sup>(α) = sin<sup>2</sup>(α)/(1 - sin<sup>2</sup>(α))</code>. From this equality, we extract the sine depending on the tangent:

<code>sin<sup>2</sup>(α) = tan<sup>2</sup>(α)/(1 + tan<sup>2</sup>(α))</code>.

But we know that `tan(α) = z`, so <code>sin<sup>2</sup>(α) = z<sup>2</sup>/(1 + z<sup>2</sup>)</code>. Which means that <code>α = asin(z/sqrt((1 + z<sup>2</sup>)))</code>.

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

    ::scss
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

All these functions can be found in [this pen](http://codepen.io/thebabydino/pen/KHpys/) and I've used them in order to create various pure CSS shapes (for example, [this regular dodecahedron expanding into an icosidodecahedron and then collapsing into an icosahedron](http://codepen.io/thebabydino/pen/qDziw)) or graphical function representations (for example, [this stretchy mesh](http://codepen.io/thebabydino/pen/dlGJI)).
