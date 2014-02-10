---
date: 30 August 2011 14:00
categories: news
author: Adam Stacoviak
summary: Twitter responses like this are awesome! We appreciate your responses and interactions with us on Twitter. Please keep it up. :)
---

# Dynamically change text color based on its background with Sass

Let’s say you have three types of buttons on your site; confirm, warning and alert. These three have different background colors, maybe green for the confirm, the warning one is orange and red for the alert button. How do you determine the text color for these buttons? If the warning button has a light shade of orange you want to use a black color on top of it. But what if that orange changes to a darker shade, or a completely different color? Then the black text color might be hard to read.

Thats why it can be smart to dynamically set the text color with the help of the Compass function lightness(). Lightness calculates a colors, you guessed it, lightness and returns a value from 0 to 100. Where 0 is the darkest, and 100 is the lightest.
So if a color (the background of the button in this case) returns a high value, meaning it’s a lighter color, we should set the text color to something dark.

## The HTML

```
<a href="#" class="button button-confirm">Confirmation</a>
<a href="#" class="button button-warning">Warning</a>
<a href="#" class="button button-alert">Alert</a>
```

## The Sass

There we have our three types of buttons; confirm, warning and alert. Let’s create a SASS function that receives a color and returns another one depending on it’s lightness:

```
@function set-button-text-color($color) {
    @if (lightness( $color ) > 40) {
      @return #000000;
    }
    @else {
      @return #FFFFFF;
    }
}
```

Alrighty then. Let’s create the rest of the CSS and call our function.

```
%button {
    text-decoration: none;
    padding: 2em 3em;
    width: 30%;
    margin: 2% auto;
    display: block;
    text-align: center;
    font-size: 1.5em;
    font-family: sans-serif;
    font-weight: bold;
    @include border-radius(10px);
}
.button {
    @extend %button;
}
.button-confirm {
    background: green;
    color: set-button-text-color(green);
}
.button-warning {
    background: orange;
    color: set-button-text-color(orange);
}
.button-alert {
    background: red;
    color: set-button-text-color(red);
}
```
There we have it! We simply call our function with the background color of our button, and the function does the rest. This is a basic example, but we could easily extend the set-button-text-color function to adapt to more lightness values.