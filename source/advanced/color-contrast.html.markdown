---
date: 2016-03-05 21:59:03 +0100
categories: advanced
author: Tobias Bengfort
summary: Color contrast is essential for legibility. But calculating it correctly is not as simple as it may seem, especially if you consider transparent colors.
---

# Color contrast in web design

Color contrast is essential for legibility in web design. The web content
accessibility guidelines (WCAG) therefore include [strict requirements on
minimum contrast](https://www.w3.org/TR/WCAG20/#visual-audio-contrast).

In this article I want to explain some details about color contrast and propose
a new algorithm that supports transparency and can be implemented in existing
libraries without losing backwards compatibility. I will also discuss the
current state of implementation in CSS preprocessors such as
[Less](http://lesscss.org/) or [Sass](http://sass-lang.com/). Out of these, I
personally prefer Sass, so all examples are written in that language.

One final note: I assume that you have a basic understanding of working with
colors, especially in CSS.

## Solid colors

### Definition

So what is color contrast? There are [many
definitions](https://en.wikipedia.org/wiki/Color_contrast), but the W3C chose
one. As a first step, they decided that contrast should not factor in hue or
saturation in order to make it meaningful for people with different kinds of
color deficiencies. So their contrast formula is purely based on *luma*.

So what is luma? More precisely: What is the difference between luma and the
related concepts *brightness* and *luminance*?

Brightness is simply the average of the red, green and blue channels. Luma and
luminance on the other hand factor in the fact that humans perceive some colors
as brighter than others. Compare for example yellow and blue. This can be done
by using the [following
formula](https://www.w3.org/TR/WCAG20/#relativeluminancedef):

    :::sass
    $l = 0.2126 * $r + 0.7152 * $g + 0.0722 * $b

This formula, as well as everything that follows, assumes that the RGBA values
are in the range from 0 to 1.

The difference between luminance and luma is that the former is based on raw
RGB values; the latter factors in [*gamma
correction*](https://en.wikipedia.org/wiki/Gamma_correction).

Humans are better at distinguishing dark colors than bright colors. Gamma
correction is a method that takes advantage of that. The gamma correction
usually used on the web is taken from the
[sRGB](https://en.wikipedia.org/wiki/Srgb) standard and can be calculated like
this:

    :::sass
    @function srgb($channel) {
        @if $channel <= 0.03928 {
            @return $channel / 12.92;
        } @else {
            @return pow(($channel + 0.055) / 1.055, 2.4);
        }
    }

Putting both formulas together we get this code for calculating the luma:

    :::sass
    @function luma($color) {
        $r: srgb(red($color) / 255);
        $g: srgb(green($color) / 255);
        $b: srgb(blue($color) / 255);
        @return 0.2126 * $r + 0.7152 * $g + 0.0722 * $b;
    }

Back to contrast: It is now simply defined as a [ratio of
lumas](https://www.w3.org/TR/WCAG20/#contrast-ratiodef):

    :::sass
    @function contrast($color1, $color2) {
        $l1 = luma($color1);
        $l2 = luma($color2);
        @return (max($l1, $l2) + 0.05) / (min($l1, $l2) + 0.05);
    }

Note that the contrast can have values between 1 and 21. I am not sure what the
rationale for the 0.05 is. It prevents the formula from going to infinity
for near-black colors, but I find that it still produces overly high results
for those.

### Implementations

I have seen three types of functions that you may wish to have in your CSS
preprocessing code:

-   A function that calculates the contrast
-   A function that warns you if the contrast is below a certain threshold
-   A function that picks the color with the best contrast to a base color out
    of a list of alternatives

Less contains a [function to calculate
luma](http://lesscss.org/functions/#color-channel-luma).  It also contains a
function of the third type called
[`contrast()`](http://lesscss.org/functions/#color-operations-contrast). This
function is not based on the W3C definition of contrast, but there is a [pull
request](https://github.com/less/less.js/pull/2754) to fix that.

Sass, on the other hand, does not contain any of these functions. It even lacks
a `pow()` function needed to calculate gamma correction. However, compass (a
popular Sass library) has a function of the third type called
[`contrast-color()`](http://compass-style.org/reference/compass/utilities/color/contrast/)
that is not based on the W3C definition. There is also a more specialised
library called [sass-a11y](https://github.com/at-import/sass-a11y) which
contains a function of the second type called `a11y-contrast()`. This one seems
to be correct.

## Transparent colors

So now that we know how to calculate color contrast of solid colors, let's turn
to transparent colors. This topic has been raised by [Lea
Verou](http://lea.verou.me/2012/10/easy-color-contrast-ratios/) in 2012. She
also suggested an algorithm that I will discuss in this article. The standard
does not mention transparent colors and most tools are not capable of working
with them, but in theory they work a lot like solid colors.

The one additional step you have to do is [*alpha
blending*](https://en.wikipedia.org/wiki/RGBA), i.e. combine the transparent
color with its background color to get the combination:

    :::sass
    @function alpha-blend($fg, $bg) {
        $a: alpha($fg);

        $r: red($fg)   * $a + red($bg)   * (1 - $a);
        $g: green($fg) * $a + green($bg) * (1 - $a);
        $b: blue($fg)  * $a + blue($bg)  * (1 - $a);

        @return rgb($r, $g, $b);
    }

So we can simply apply alpha blending, then calculate the contrast and we are
done, right? Unfortunately, there are two major issues with this:

-   In order to apply alpha blending, we need to know which color is in the
    foreground and which one is in the background. This did not make any
    difference before.
-   If the background color is transparent itself we need to know (or guess) a
    third color (called backdrop) that it will be blended on.

### Transparent backgrounds

Let's turn to the issue of the unknown backdrop color first. These are some
approaches I could think of:

-   **Ignore the transparency.** The result of the algorithm should be that
    colors with low alpha channel are considered to have a low contrast to
    almost everything. So ignoring the transparency completely does not sound
    like the right thing to do, though it would save us a lot of headaches.

-   **Use white as a backdrop color as it is the default background color on
    most websites.** Using a white background might seem like a good idea, but
    using a transparent background on a solid backdrop color is not actually a
    common use case and should be advised against (just use the blended color
    directly in these cases).  [Almost all
    examples](http://tympanus.net/codrops/2012/11/26/using-transparency-in-web-design-dos-and-donts/)
    I saw used transparent backgrounds to increase contrast when displaying
    text over images. So there is really no basis for assuming a white
    backdrop.

-   **Calculate the minimum or maximum possible contrast or some combination of
    them.** This is what Lea does. The difficulty with this approach is that
    using minimum or maximum seems to be a bit biased against or in favour of
    transparency.  And there are so many possible ways to combine them that it
    is not clear which one to choose.

-   **Calculate the expected value.** This might be the proper approach from a
    purely theoretical perspective. It basically means that we choose some
    random backdrop colors, calculate the contrast, and use the average of the
    results.  The big issue with this approach is that we would need to know
    how probable each color is as a backdrop. How would we define that? Do a
    field study or just assume that all colors are equally probable? This
    sounds like overkill.

Taking into account that the backdrop is most likely not a single color but an
image, I think the most sensible approach out of these is to use the minimum
possible contrast.  So how is it calculated?

The luma is strictly increasing in relation to every color channel. So the
minimum luma can be achieved by using black as a backdrop color, while the
maximum can be achieved with white. The luma is also continuous, meaning that
for every possible luma between minimum and maximum there is a backdrop color
that can produce it.

This means that the minimum contrast is 1 if the foreground luma is somewhere
in that range. Otherwise, it is the minimum of the white/black cases:

    :::sass
    @function contrast-min($fg, $bg) {
        $bg-black: alpha-blend($bg, black);
        $bg-white: alpha-blend($bg, white);

        @if luma($bg-white) < luma($fg) {
            @return contrast($fg, $bg-white);
        } @else if luma($bg-black) > luma($fg) {
            @return contrast($fg, $bg-black);
        } @else {
            @return 1;
        }
    }

### Background/foreground

In the case of solid colors, it was not relevant which of the colors was
background and which was foreground. Now it is: When a transparent foreground
is overlayed on the background, it is mixed with it, resulting in a slightly
decreased contrast. A transparent background can have much more extreme effect
depending on the backdrop. For example, the background may have a lower luma
than the foreground, but when overlayed on white the result has a higher luma.

This effect is unfortunate, because it makes the API much more complicated and
is largely incompatible with existing implementations. So are there any ways
around it?

Let's first look at the actual impact. In order to do that we swap foreground
and background colors and compare the results of different algorithms.

In the case of minimum contrast, the regular and the swapped functions are
correlated (I calculated a correlation of 0.88 in a set of 10000 random
colors). This makes sense because the contrast goes down for both transparent
foreground and transparent background.

In the case of maximum contrast, they are negatively correlated (-0.23). This
makes sense because the contrast goes down for transparent foreground while it
goes up for transparent background.

Given the high cost this would have and the high correlation between minimum
contrast and its swapped version, I think it is a sensible approach to use a
"symmetric minimal contrast" that is the average of the two:

    :::sass
    @function contrast-min-symmetric($color1, $color2) {
        $c1 = contrast-min($color1, $color2);
        $c2 = contrast-min($color2, $color1);
        @return ($c1 + $c2) / 2;
    }

### Implementations

-   Lea Verou created a [tool](https://leaverou.github.io/contrast-ratio/)
    written in JavaScript that reports a range of possible contrasts for
    transparent background colors. It requires you to know which of the colors
    will be the fore-/background.
-   Less ignores the alpha channel completely in its `contrast()` function.
-   Compass also ignores the alpha channel in its `contrast-color()` function.
-   sass-a11y implements the algorithm proposed by Lea.

## Conclusion

This whole topic turned out to be surprisingly complicated, touching topics
such as psycho-visual effects, maintaining backwards compatibility, and a
significant amount of math.

We discussed ways to ensure a minimum color contrast. Note, however, that this
may not be sufficient to ensure good legibility: Typography and font size are
other key factors. Also note that too much contrast can be hard on the eyes,
especially very bright colors on dark background.

While writing this I created several bug reports and pull requests.
Unfortunately, some projects mentioned are no longer maintained, e.g. Compass
and sass-a11y. The symmetric minimal contrast algorithm is now available in a
Sass library called [sass-planifolia](https://github.com/xi/sass-planifolia).
