---
date: 2011-09-23 08:30:00 -0500
categories: projects, adam-stacoviak
author: Adam Stacoviak
summary: If you're a fan of the classic Penner equations by Robert Penner, made famous by Flash and jQuery. You are going to love Compass Ceaser Easing by Jared Hardy, also known for his Sassy Buttons project.
---

# Compass Ceaser Easing Animation

Create CSS3 transitions and animations in Sass with ease, based on the classic Penner equations, made famous by Flash and jQuery.

<a href="https://github.com/jhardy/compass-ceaser-easing"><img src="/attachments/compass-ceaser.png" class="full" /></a>

## CSS3 transitions and animations made easy

If you're a fan of the hawtness of CSS3 animations and transitions, you are going to love [Jared Hardy's](http://twitter.com/#!/jaredhardy) Compass Ceaser Easing. Jared is also known for his [Sassy Buttons project](/projects/sassy-buttons).

Compass Ceaser Easing is a Compass extension based on the [ceasar css easing animation tool](http://matthewlein.com/ceaser/) by [@matthewlein](http://twitter.com/#!/matthewlein) and provides transitions based on the classic [Penner equations](http://robertpenner.com/easing/) by [Robert Penner](http://robertpenner.com/).

The Ceaser easing extension provides a sass function and a mixin called ceaser to make creating animations super easy!

### Ceaser easing function

    :::scss
    // Transition
    #transition {
      transition: all 1.2s ceaser("ease-in");
    }

    // Animation
    #animation-shorthand {
      animation: animateMe 10s ceaser("easeInSine") infinite;
    }

### Ceaser easing mixin

    :::scss
    // Create a 500 millisecond transition on only the width w/ a delay of 1 second
    @include ceaser(easeInOutExpo, width, 500ms, 1s);
    
    #box {
      width: 500px;
      @include ceaser(easeInOutExpo, width, 500ms, 1s);
    }

    #box:hover {
      width: 700px;
    }

### Ease types

All 26 available easing types. See an example of each on [the original demo page](http://matthewlein.com/ceaser/).

    linear
    ease (default)
    ease-in
    ease-out
    ease-in-out

    easeInQuad
    easeInCubic
    easeInQuart
    easeInQuint
    easeInSine
    easeInExpo
    easeInCirc

    easeOutQuad
    easeOutCubic
    easeOutQuart
    easeOutQuint
    easeOutSine
    easeOutExpo
    easeOutCirc

    easeInOutQuad
    easeInOutCubic
    easeInOutQuart
    easeInOutQuint
    easeInOutSine
    easeInOutExpo
    easeInOutCirc

### Links

* [Source on GitHub](https://github.com/jhardy/compass-ceaser-easing)
* [Ceaser Easing Animation Tool](http://matthewlein.com/ceaser/)