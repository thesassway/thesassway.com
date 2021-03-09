---
date: 12 October 2013
categories: advanced, guides
author: Kitty Giraudel
summary: A fun experiment by Kitty Giraudel that demonstrates advanced usage of functions. Learn about the fibonacci sequence in Sass and more!
---

# Math sequences with Sass

A couple of weeks ago, I've been playing around math sequences in Sass, especially the [Fibonacci number](http://en.wikipedia.org/wiki/Fibonacci_number), the [Juggler sequence](http://en.wikipedia.org/wiki/Juggler_sequence) and the [Look-and-say sequence](http://en.wikipedia.org/wiki/Look-and-say_sequence) also known as _Conway's number_.

Even if there is no practical application for such things, those were definitely fun Sass experiments and people seemed to be interested on Twitter so here is the how-to.

If you're not interested in learning how I did it and just want to see the code, you can play around those pens: [Fibonacci number](https://codepen.io/KittyGiraudel/pen/krAes), [Juggler sequence](https://codepen.io/KittyGiraudel/pen/GnzfB), [Look-and-say sequence](https://codepen.io/KittyGiraudel/pen/tBhzs).

## Fibonacci number

The [Fibonacci number](http://en.wikipedia.org/wiki/Fibonacci_number) is one of those math sequences that follow simple rules. The one ruling the Fibonacci sequence is that **each subsequent number is the sum of the previous two**. Here are the 10 first entries of this sequence:

    0 1 1 2 3 5 8 13 21 34 55

Pretty simple, isn't it? Of course there is no end to this sequence, so we need to fix a limit, like the number of entries we want; we'll call this number `$n`. Okay, let's build the skeleton. To start the sequence we need 2 numbers, right?

    :::scss
    @function fibonacci($n) {
      $fib: 0 1;
      @for $i from 1 through $n {
        $fib: append($fib, $new);
      }
      @return $fib;
    }

We're almost done! We only need to work this `$new` variable. It's actually really simple:

    :::scss
    $last: nth($fib, length($fib));
    $second-to-last: nth($fib, length($fib) - 1);
    $new: $last + $second-to-last;

And there you have it, the Fibonacci number in Sass. Here is the whole function and a usecase:

    :::scss
    @function fibonacci($n) {
      $fib: 0 1;
      @for $i from 1 through $n {
        $new: nth($fib, length($fib)) + nth($fib, length($fib) - 1);
        $fib: append($fib, $new);
      }
      @return $fib;
    }

    $fib: fibonacci(10);
    // -> 0 1 1 2 3 5 8 13 21 34 55 89
 
## Juggler sequence

I'll be totally honest with you guys: I'm not sure what's the [Juggler sequence](http://en.wikipedia.org/wiki/Juggler_sequence) is meant for. All I know is how it works. First of all, it is not an infinite sequence; secondly, it's different for each initial number.

Basically, every new entry in the sequence is the previous one either raised to `1/2` if it's even or raised to `3/2` if it's odd. Let's take an example with `3` as a starter:

    :::scss
    3  // initial 
    5  // 3^3/2  = 5.196...
    11 // 5^3/2  = 11.180...
    36 // 11^3/2 = 36.482...
    6  // 36^1/2 = 6
    2  // 6^1/2  = 2.449...
    1  // 2^1/2  = 1.414...

What's interesting about this sequence is it will eventually always end up with `1`. This is actually pretty cool because it means we know when to stop: when we reach 1. Ready?

> First time ever I use a while loop. So proud! \o/

    :::scss
    @function juggler($n) {
      $juggler: ($n);
      @while nth($juggler, length($juggler)) != 1 {
        // What's $new?
        $juggler: append($juggler, $new);
      }
      @return $juggler;
    }

Anyway, I think the code is pretty self-explanatory. We append new values to the list until the last one is `1`, in which case we stop. All we have to do is to find `$new`.

It is actually pretty simple. We only have to check whether the last number is odd or even:

    :::scss
    $last : nth($juggler, length($juggler));
    $x    : if($last % 2 == 0, 1/2, 3/2);
    $new  : pow($last, $x);

Simple, isn't it? Here is the whole function and a usecase:

    :::scss
    @function juggler($n) {
      $juggler: ($n);
      @while nth($juggler, length($juggler)) != 1 {
        $last    : nth($juggler, length($juggler));
        $x       : if($last % 2 == 0, 1/2, 3/2);
        $new     : pow($last, $x);
        $juggler : append($juggler, $new);
      }
      @return $juggler;
    }

    $juggler: juggler(77);
    // -> 77 675 17537 2322378 1523 59436 243 3787 233046 482 21 96 9 27 140 11 36 6 2 1`

## Look-and-say sequence

The [Look-and-say sequence](http://en.wikipedia.org/wiki/Look-and-say_sequence) is a little bit less mathematical than the Fibonacci number. Its name is self explanatory: to generate a new entry from the previous one, read off the digits of the previous one, counting the number of digits in groups of the same digit.

    :::scss
    $look-and-say: 1, 11, 21, 1211, 111221, 312211;

Starting with `1`, here is what happen:

### Fun facts

In case you're interested, there are numbers of fun facts regarding this sequence:

* There won't be any number greater than 3
* Except for the first entry, all entries have an even number of characters
* Except for the first entry, odd entries end with `21` and even entries end with `11`
* The average number of `1` is `50%`, of `2` is `31%`, of `3` is `19%`.

You can even start the sequence with another digit than 1. For any digit from 0 to 9, this digit will indefinitely remain as the last digit of each entries:

    d 1d 111d 311d 13211d 111312211d 31131122211d

### Look-and-say in Sass

To build this sequence with Sass, I got inspired by [an old pen of mine](https://codepen.io/KittyGiraudel/pen/wDkvc) where I attempted to do the sequence in JavaScript. The code is dirty as hell and definitely waaaay too heavy for such a thing, but it works.

Since Sass isn't as powerful as JavaScript (no regular expression, no replace...), I don't think there are many ways to go. If anyone has a better idea, I'd be glad to hear it! :)

As for the Fibonacci number, there is no end so we have to define a limit. Again, this will be `$n`.

    :::scss
    @function look-and-say($n) {
      $sequence: (1);
      @for $i from 1 through $n {
        // We do stuff
      }
      @return $sequence;
    }

Before going any further, I think it's important to understand how we are going to store the whole sequence in Sass. Basically, it will be a list of lists. Like this:

    :::scss
    $sequence: 1, 1 1, 2 1, 1 2 1 1, 1 1 1 2 2 1;

So the upper level (entries) are comma separated while the lower level (numbers in each entry) are space separated. Two-levels deep list. Alright back to our stuff.

For each loop run, we have to check the previous entry first. Then, here is what we do:

1. Start from last character
2. Check the number of identical characters previous to and including this one (basically 1, 2 or 3)
3. Prepend this count and the character to the new entry
4. Start back to next unchecked character  

Let's see:

    :::scss
    @function look-and-say($n) {
      $sequence: (1);
      @for $i from 1 through $n {
        $last-entry : nth($sequence, length($sequence));
        $new-entry  : ();
        $count     : 0;
        @for $j from length($last-entry) * -1 through -1 { 
          $j      : abs($j);
          $last   : nth($last-entry, $j);
          $last-1 : null;
          $last-2 : null;

          @if $j > 1 { $last-1: nth($last-entry, $j - 1); }
          @if $j > 2 { $last-2: nth($last-entry, $j - 2); }

          // We do stuff
        }
      }
      @return $sequence;
    }

We use the dirty old negative hack to make the loop decrement instead of increment since we want to start from the last character (stored in `$last`).

Since second-to-last and third-to-last characted don't necessarily exist, we first define them to `null` then we check if they can exist, and if they can, we define them for good.

Now we check if `$count = 0`. If it does, it means we are dealing with a brand new character. Then, we need to know how long is the sequence of identical numbers (1, 2 or 3). Quite easy to do:

* if `$last`, `$last-1` and `$last-2` are identical, it's `3`
* if `$last` and `$last-1` are identical, it's `2`
* else it's 1

Once we've figured out this number, we can **prepend** (remember we're starting from the end of the line) it and the value to the new entry.

Then, we decrement `$count` from 1 at each loop run. This is meant to skip numbers we just checked.

    :::scss
    @if $count == 0 {
      @if $last == $last-1 and $last == $last-2 { 
        $count: 3; 
      }
      @else if $last == $last-1 { 
        $count: 2; 
      }
      @else { 
        $count: 1;
      }

      // Prepend new numbers to new line
      $new-line: join($count $last, $new-entry        
    }  

    $count: $count - 1;

Once we're done with the inner loop, we can append the new entry to the sequence and start a new entry again, and so on until we've run `$n` loop runs. When we've finished, we return the sequence. Here is the whole function:

    :::scss
    @function look-and-say($n) {
      $sequence: (1);
      @for $i from 1 through $n {
        $last-entry : nth($sequence, length($sequence));
        $new-entry  : ();
        $count     : 0;
        @for $j from length($last-entry) * -1 through -1 { 
          $j      : abs($j);
          $last   : nth($last-entry, $j);

          $last-1 : null;
          $last-2 : null;
          @if $j > 1 { $last-1: nth($last-entry, $j - 1); }
          @if $j > 2 { $last-2: nth($last-entry, $j - 2); }

          @if $count == 0 {
            @if $last == $last-1 and $last == $last-2 { 
              $count: 3; 
            }
            @else if $last == $last-1 { 
              $count: 2; 
            }
            @else { 
              $count: 1;
            }
            // Prepend new numbers to new line
            $new-line: join($count $last, $new-entry);  
          }  
          $count: $count - 1;
        }
        // Appending new line to result
        $sequence: append($sequence, $new-entry);
      }  
      // Returning the whole sequence
      @return $sequence;
    }

And here is how you use it:

    :::scss
    $look-and-say: look-and-say(7);
    // -> 1, 1 1, 2 1, 1 2 1 1, 1 1 1 2 2 1, 3 1 2 2 1 1, 1 3 1 1 2 2 2 1, 1 1 1 3 2 1 3 2 1 1`

**Caution!** This sequence is pretty heavy to generate, and the number of characters in each entry quickly grow. On CodePen, it's getting too heavy after like 15 iterations. You could push it further locally but if your browser crashes, you won't tell you hadn't be warned!

## Displaying those sequences 

One equally interesting thing is how I managed to display these sequences with line breaks and reasonable styles without any markup at all.

First things first: to display textual content without any markup, I used a pseudo-element on the body. This way, I can inject text into the document without having to use an extra element.

Now to display it with line-breaks, I had to get tricky! The main idea is to convert the list into a string and to join elements with a line-break character.

Thankfully, I recently wrote an article about [advanced Sass list functions](https://kittygiraudel.com/2013/08/08/advanced-sass-list-functions/), and one of those is `to-string()`.

I think you can see where this is going now: to display the Fibonacci number line by line, I simply did this:

    :::scss
    body:before {
      content: quote(to-string(fibonacci(100), ' \A '));
      white-space: pre-wrap;
    }

Here is what we do (from middle to edges):

1. We call the fibonacci function to run 100 times
2. We convert the returned list into a string, using the `\A` line-break character
3. We quote this string so it's a valid content value

There you have it: displaying a whole list of data with line-breaks all through CSS. Pretty neat, isn't it?

Note: for the Look-and-say sequence, it takes one extra step to convert nested lists into strings first. You check how I did it directly on [the pen](https://codepen.io/KittyGiraudel/pen/tBhzs).

## Final words

This is pointless but definitely fun to do. And interesting. Now what else could we do? Do you have anything in mind? :)
