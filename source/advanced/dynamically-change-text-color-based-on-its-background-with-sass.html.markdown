---
date: 10 January 2014 16:00
categories: advanced
author: Sebastian Ekström
summary: With the help of variables, functions and mixins we can create really dynamic, automatic and clean code, which is one of the big strengths in Sass. In this article I'll show you how you can guarantee a good contrast between a text and its background dynamically with Sass and lightness().
---

# Dynamically change text color based on its background with Sass

With the help of variables, functions and mixins we can create really dynamic, automatic and clean code, which is one of the big strengths in Sass. In this article I'll show you how you can guarantee a good contrast between a text and its background dynamically with Sass and lightness().


## The code

We'll use notification bars as an example of this. So lets start with some basic HTML:

```
<p class="notification notification-confirm">Confirmation</p>
<p class="notification notification-warning">Warning</p>
<p class="notification notification-alert">Alert</p>
```

There's our three types of notifications; confirm, warning and alert. These will have different colors, maybe green for the confirmation, yellow for the warning and red for the alert. And we want its text color to have a good contrast to the background.

So let's start with creating a Sass function that receives a color value and depending on its lightness returns another color.

```
@function set-notification-text-color($color) {
    @if (lightness( $color ) > 50) {
      @return #000000; // Lighter color, return black
    }
    @else {
      @return #FFFFFF; // Darker color, return white
    }
}
```

Lightness() is a [built-in Sass function](http://sass-lang.com/documentation/Sass/Script/Functions.html#lightness-instance_method) that calculates the lightness of a colors RGB value between 0% and 100%. Where 0% is the darkest and 100% the lightest.
So in our function we receive a color, and if that colors lightness value is greater than 50%, meaning it's a lighter color, we return a dark value to ensure a good contrast.

Alrighty then. Let’s create some basic styling and then call our function.

```
$notification-confirm: hsla(101, 72%, 37%, 1);  // Green
$notification-warning: #ffc53a;                 // Yellow
$notification-alert: rgb(172, 34, 34);          // Red

%notification {
    padding: 1em 2em;
    width: 30%;
    margin: 1em auto;
    display: block;
    text-align: center;
    font-size: 1.5em;
    font-family: sans-serif;
    border-radius: 10px;
}

.notification {
    @extend %notification;
}
.notification-confirm {
    background: $notification-confirm;
    color: set-notification-text-color($notification-confirm);
}
.notification-warning {
    background: $notification-warning;
    color: set-notification-text-color($notification-warning);
}
.notification-alert {
    background: $notification-alert;
    color: set-notification-text-color($notification-alert);
}
```

There we have it! We call our function with the background color of our button, and the function returns the appropriate text color. As you can see, the function parameter can take a hex value, rgba, hsl or the name of the color.

So if you want to change the alert notification color, you just change the value of the variable, and the text color changes automatically. This is of course a simplified example of how you can use lightness() for dynamical colors. It can be extended to detect more lightness values, used on different button states and a lot more!

A demo can be [viewed here](http://codepen.io/sebastianekstrom/pen/avDjh).