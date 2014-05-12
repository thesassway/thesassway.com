---
date: 11 May 2014
categories: intermediate
author: Sebastian Ekström
summary: Learn how to use variables and a custom function to programmatically determine contrasting text colors for different backgrounds.
---

# How to dynamically change text color based on a background color

Designers often choose the text color of an element based on the background color. If the background is dark, light text is chosen. If the background is light, they use dark text. This is because light and dark contrast well with each other and make text easier to read.

So how can we use Sass to choose the appropriate text color for a background?

We'll use notification messages as our example. Let's start with some basic HTML:

    :::html
    <p class="notification notification-confirm">Confirmation</p>
    <p class="notification notification-warning">Warning</p>
    <p class="notification notification-alert">Alert</p>

We have three types of notifications: confirm, warning, and alert. We'd like them to have different color backgrounds. Green for confirmation, yellow for warning, and red for alert. And we want the text contrast well with the background.

Let's create a Sass function to make our lives a little easier:

    :::scss
    @function set-notification-text-color($color) {
      @if (lightness($color) > 50) {
        @return #000000; // Lighter backgorund, return dark color
      } @else {
        @return #ffffff; // Darker background, return light color
      }
    }

Here we've used the Sass `lightness()` function to determine which color is more appropriate for a background. The `lightness()` function is a [built-in Sass function](http://sass-lang.com/documentation/Sass/Script/Functions.html#lightness-instance_method) that returns the lightness of a color's RGB value between 0 and 100. Where 0 is the darkest and 100 the lightest.

So in our function we receive a color, and if that color's lightness value is greater than 50, meaning it's a light color, we return a dark value to ensure a good contrast. Otherwise we return a light color.

Alrighty then. Let's see this in action:

    :::scss
    $notification-confirm: hsla(101, 72%, 37%, 1);  // Green
    $notification-warning: #ffc53a;                 // Yellow
    $notification-alert: rgb(172, 34, 34);          // Red

    %notification {
      border-radius: 10px;
      display: block;
      font-size: 1.5em;
      font-family: sans-serif;
      padding: 1em 2em;
      margin: 1em auto;
      width: 30%;
      text-align: center;
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

And there we have it! We call our function with the background color of our message and the function determines a light or dark value for us!

Here's the final output:

<p data-height="400" data-theme-id="394" data-slug-hash="ktcqw" data-default-tab="result" class='codepen'>See the Pen <a href='http://codepen.io/sebastianekstrom/pen/avDjh'>Dynamic text color based on the background</a> on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//codepen.io/assets/embed/ei.js"></script>

The really wonderful thing about this approach is that if we change our background color variables the text colors will update appropriately.

This is a simplified example of how you can use Sass to generate colors dynamically. I'm sure you can think of other ways of using this. Let me know how you are using Sass color functions in the comments below.

For a more advanced version of this idea with a better `brightness()` function for determining the lightness of a color, see [John W. Long's gist here](https://gist.github.com/jlong/f06f5843104ee10006fe).
