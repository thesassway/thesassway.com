---
date: 5 February 2014
categories: advanced, guides
author: Aleksandar Goševski
summary: Create two sprites, one for retina and one for regular screens, and handle problems about scaling retina screen and calculating new positions for every sprite.
---

# The real retina sprite mixin

I saw menu solutions on this topic, but usually people use regular sprite, and then for retina screens just load image and scale it to 50% of size. That is solution, but that's not real usage of retina sprite.

What I consider for retina sprite mixin is to have 2 sprite maps and to load basic one for non-retina screens, and retina for retina screens.

## Problem

Problem is how to scale sprite, and to preserve positions which compass is calculating. But, it's quite easy. We scale down sprite image, so position of every image (x, y) is the regular one divided by two, because we scaled down sprite width and height by two.

![](https://31.media.tumblr.com/2fcfd6df595ce2f1fcfac4e4999a2a00/tumblr_inline_n0hx6yG8Zs1r8euj7.png)

## Solution

First we need to create sprite maps.

    $icons: sprite-map("icons/*.png", $layout: 'smart');
    $icons2x: sprite-map("icons@2x/*.png", $spacing: 5px);

For regular sprite we want to use optimised version (smart layout). In time I'm writing this, compass is not supporting to use layout and spacing in the same time, so for retina we're using spacing, because when we scale down sprite image, maybe it ends up with odd number of pixels in width or height.

    @import "breakpoint";

    %sprite {
        background-image: sprite-url($icons);
        background-repeat: no-repeat;

        @include breakpoint('retina') {
            background-image: sprite-url($icons2x);
            background-repeat: no-repeat;
            $sprite-width: image-width(sprite-path($icons2x)) / 2;
            $sprite-height: image-height(sprite-path($icons2x)) / 2;
            @include background-size($sprite-width $sprite-height);
        }
    }

    @mixin retina-sprite ( $icon ) {
        $icon-name: "icons/" + $icon + '.png';
        $position: sprite-position($icons, $icon);
        $position-x: round(nth($position, 1));
        $position-y: round(nth($position, 2));
        background-position: $position-x $position-y;
        width: image-width($icon-name);
        height: image-height($icon-name);
        @extend %sprite;

        @include breakpoint('retina') {
            $icon-name: "icons@2x/" + $icon + '.png';
            $position: sprite-position($icons2x, $icon);
            $position-x: round(nth($position, 1)/2);
            $position-y: round(nth($position, 2)/2) + 1px;
            background-position: $position-x $position-y;
            width: round(image-width($icon-name) / 2) + 2;
            height: round(image-height($icon-name) / 2) + 2;
        }
    }


We're extending %sprite placeholder selector, because we don't want to repeat some properties every time we use mixin (background-size, background-image, background-repeat). We also added 2px on width and height of retina sprite to ensure we don't cut any sprite, because maybe when we scale down sprite image it ends up with odd number in width or height.

So we ended up with two sprites, but it's much better then loading every image separately on retina screen.

I hope I explained this well, and that you understand advantages of this technique. My fellow [Kristijan Husak](http://www.twitter.com/kristijan_husak) helped me write this mixin.