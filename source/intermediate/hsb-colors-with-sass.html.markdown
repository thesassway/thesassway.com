---
date: 27 June 2014
categories: intermediate
author: Alexander Futekov
summary: Alexander Futekov reviews the option of using another color model - HSB - in our Sass projects.
---

# HSB colors with Sass

Why do we need another color model you might ask? And it is a fair question, considering we already have RGB, HSL, and Hex and we're doing just fine. To convince you, I will tell you why HSB is awesome and how you can easily implement it in any Sass project.


## Why HSB

The [HSB/HSV color model](http://en.wikipedia.org/wiki/HSL_and_HSV) is actually a close kin of HSL. HSB stands for Hue, Saturation, and Brightness, the Hue being identical to the one in HSL.

HSB colors, just like their cousin HSL, have some nice advantages over RGB and Hex - they allow you to quickly identify a color by seeing how saturated and bright it is, [Chris Coyier also tells us why HSL is cooler](http://css-tricks.com/yay-for-hsla/) and [Dudley Storey has a nice visual guide on how to think about HSL colors](http://demosthenes.info/blog/61/An-Easy-Guide-To-HSL-Color-In-CSS3), all of these apply equally well to HSB.

This easy-to-understand-at-a-glance factor isn't present in RGB and Hex - just try to imagine what `rgb(173, 149, 128)` or `#ad9580` look like.

Also, if you need some level of transparency for a color, Hex is no longer an option, you have to choose between RGBa and HSLa (and now HSBa).

HSB colors are also more readily available for use than HSL if you choose/get your colors from graphics software - programs such as GIMP and Adobe's Photoshop and Illustrator all prefer the HSB color model to HSL.


## Building the function

Adding support for HSB colors in your project is incredibly easy. We will define a HSB function, so that later we can use it just like HSL or RGB colors:

```
color: hsb(333, 84, 76)
```

Our new function will have between 3 or 4 parameters, the fourth one being the alpha channel which we will set to 1 by default:

```
@function hsb($h-hsb, $s-hsb, $b-hsb, $a: 1)
```

On the inside, the function will convert the HSB color to HSL (it's the easiest conversion mathematically speaking). Sass will output the color in its Hex equivalent (or rgba if the color has transparency) no matter the format you provide the input color in, other preprocessors work the same way.

The Hue component doesn't need to be converted, since it's the same for HSB and HSL. To get the other components though, we need some math.

The L<sub>HSL</sub> is equal to:

```
$l-hsl: ($b-hsb/2) * (2 - ($s-hsb/100));
```


And this is how we derive S<sub>HSL</sub>:

```
$s-hsl: ($b-hsb * $s-hsb) / if($l-hsl < 50, $l-hsl * 2, 200 - $l-hsl * 2);
```

The `if` statement is there for the proper behavior of the saturation, which starts to decrease once the lightness of the HSL surpasses 50%, here is a more [detailed explanation](http://en.wikipedia.org/wiki/Comparison_of_color_models_in_computer_graphics#HSL).


In the end, we simply return the new value

```
@return hsla($h-hsb, $s-hsl, $l-hsl, $a);
```

This function however will fail if the third parameter (the brightness, or `$b-hsb`) is `0` because in math we cannot divide by zero. Happily for us, having a brightness of `0` in HSB means that the output color will be black no matter what the other two parameters are. The best way to deal with this issue is to make our function automatically output black if the brightness is equal to zero, this approach completely solver the issue of doing complex operations with zero.

After applying the condition for zero brightness, this is the code we end up with:

    :::scss
    @function hsb($h-hsb, $s-hsb, $b-hsb, $a: 1) {
      @if $b-hsb == 0 {
        @return hsla(0, 0, 0, $a)
      } @else {
        $l-hsl: ($b-hsb/2) * (2 - ($s-hsb/100));
        $s-hsl: ($b-hsb * $s-hsb) / if($l-hsl < 50, $l-hsl * 2, 200 - $l-hsl * 2);
        @return hsla($h-hsb, $s-hsl, $l-hsl, $a);
      }
    }

Here is a demo of the function with some test cases:

<p data-height="261" data-theme-id="6947" data-slug-hash="bctAd" data-default-tab="css" class="codepen">See the Pen <a href="http://codepen.io/futekov/pen/bctAd">HSB color function</a> by Alexander Futekov (<a href="http://codepen.io/futekov">@futekov</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//codepen.io/assets/embed/ei.js"></script>


## A note on Precision

Keep in mind that the color picker of Adobe Photoshop (and other graphics software) does some rounding when calculating the equivalent HSB of a certain Hex color. This happens because these different color models allow for different precision for its color components.

An example of the rounding issue is shown in the CodePen above, under `.test-precision`, where a Hex color from Photoshop outputs rounded HSB values, and if you put these rounded values in a HSB to Hex converter (for example the one we just built) we might get a slightly different Hex than the original (the difference however, is imperceptible). If you happen to need precise colors or just want to avoid this rounding issue for Zen reasons you can use this [awesome converter](http://www.colorizer.org/).
