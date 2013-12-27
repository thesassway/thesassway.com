---
date: 2011-09-27 10:12:43 -0500
categories: projects, adam-stacoviak
author: Adam Stacoviak
summary: How far is too far when it comes to CSS text shadows? Be prepared to cross that line and then some with Mason Wendell in his project Sassy Text Shadows -- the response is to the call put forth by Paul Irish's Mother Effing Text Shadow, and an answer to the burning question, "Why would you want to use trigonometry in CSS?"
---

# Sassy Text Shadows

How far is too far when it comes to CSS text shadows? Be prepared to cross that line and then some with [Mason Wendell](/mason-wendell) in his project [Sassy Text Shadows](http://sassymothereffingtextshadow.com/).

<a href="http://sassymothereffingtextshadow.com/"><img src="/attachments/sassy-text-shadow.png" class="full" /></a>

## What is Sassy Text Shadows?

Sassy Text Shadows is a response to the call put forth by Paul Irish's [Mother Effing Text Shadow](http://mothereffingtextshadow.com/). It's also an answer to the burning question, "Why would you want to use trigonometry in CSS?"

## Shadows in a Circle

Mason is the first to admit that the practical uses of this technique are probably limited. Most of the time when CSS shadows are piled more than a few levels deep it's likely so that we can explore and test what's possible. That's no different here, and Mason has some fun playing with that concept.

On his [Sassy Mother Effing Text Shadows](http://sassymothereffingtextshadow.com/) site, he shows how you can use Sass to generate a string of text shadow variables that can be manipulated in many ways to create waves and shapes.

The basic concept is fairly simple:

* Loop thru a series iterations on a variable
* Create a new text-shadow string on each iteration
* Then add those together as the final, long, text shadow

### Sassy Text Shadows gem

The [gem](https://rubygems.org/gems/sassy-text-shadow) allows you to do this yourself, and adds trigonometry into the mix. Out of the box you get a pretty nice circular text shadow (as shown above). You can also pass various arguments to the function for some very interesting results.

See [the readme](https://github.com/canarymason/sassytextshadow#readme) for install details

    :::scss
    // Basic Red Circle
    h1 { 
      @include text-shadow(sassy-text-shadow(#b80000)); 
    }
    
    // Ranbow Wave
    h1 {
      @include text-shadow(sassy-text-shadow(#b80000, 100, 80, 120, 90, -45, 0.09));
    }
    
The arguments are (in order):

* `$color` -- the starting color of the shadow $iterations: how many shadows to generate  
* `$rad` -- the radius of the curve   
* `$deg` -- how far around the curve to go  
* `$cos-i` -- the multiplier for cos()   
* `$sin-i` -- the multiplier for sin() 
* `$color-multiplier` -- an amount to shift the hue of the color as it iterates


## A Lorenz Attractor Text Shadow

<a href="http://sassymothereffingtextshadow.com/"><img src="/attachments/sassy-text-shadow-lorenz.png" class="full" /></a>

Mason also wrote a [Lorenz Attractor](http://en.wikipedia.org/wiki/Lorenz_Attractor) in Sass. Just for fun, and to see how long and impractical this really is, [view the final CSS code of lmao.css](http://sassymothereffingtextshadow.com/stylesheets/lmao.css). It's quite possible that generating 5000 text shadows is a bit off the deep end, but the results are pretty interesting.

### Sassy Lorenz Attractor

    :::scss
    // Sassy Lorenz Attractor
    @function lmao($orig-color, $iterations, $sx, $sy, $sz) {
      $output: '';
      $end: $iterations;

      $x0: $sx / 10;
      $y0: $sy;
      $z0: $sz;
      $h: 0.01;
      $a: 10.0;
      $b: 28.0;
      $c: 8.0 / 3.0;

      @for $i from 0 through $end {
        $x1: $x0 + $h * $a * ($y0 - $x0);
        $y1: $y0 + $h * ($x0 * ($b - $z0) - $y0);
        $z1: $z0 + $h * ($x0 * $y0 - $c * $z0);

        $xval: $x1 * -50;
        $yval: $y1 * -20;
        $spread: $z1 * .1;

        $color: rgba($orig-color, ($i / $end));
        $color: adjust-hue($color, $z1);

        $output: $output + '#{$color} #{$xval}px #{$yval}px #{$spread}px';
         @if $i < $end {
           $output: $output + ', ';
         }

         $x0: $x1;
         $y0: $y1;
         $z0: $z1;

      }

      @return unquote($output);
    }

    h1 {
      @include text-shadow(lmao(#b80000, 5000, 6, 4, 6));
    }


### Links

* [Sassy Mother Effing Text Shadows](http://sassymothereffingtextshadow.com/)
* Paul Irish's [Mother Effing Text Shadow](http://mothereffingtextshadow.com/), also mentioned on [The Changelog 0.6.7](http://thechangelog.com/post/9123518427/episode-0-6-7-html5-boilerplate-modernizr-and-more-with)
* [Source on GitHub](https://github.com/canarymason/sassytextshadow)
* [Ruby Gem](https://rubygems.org/gems/sassy-text-shadow)