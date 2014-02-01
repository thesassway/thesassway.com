---
date: 1 February 2014
categories: advanced
author: Hugo Giraudel
summary: Hugo takes a page from his SassyLists playbook and teaches us how to build a string sorting function in pure Sass.
---

# Building a sorting function in pure Sass

Several months ago someone asked me on Twitter if it was possible to sort a list of numeric values in Sass. They were trying to derive a [modular scale](http://alistapart.com/article/more-meaningful-typography) in Sass and needed a sorting function. After a little bit of work I came up with a way to do it for numbers. However, because of limitations in Sass, there was no way to build a sorting function for other Sass types (like Strings).

Fast forward to the present day. Sass 3.3 has been released and with it [a ton of new features](http://davidwalsh.name/future-sass). Today, I'd like to show you how to use some of these features to build a sorting function in Sass.


## Comparing strings

The heart of any sorting function is the ability to compare two strings and determine which one should go before the other. Most programming languages make this fairly easy, but to do this in Sass we have to build our own string comparison function.

For starters, we need to teach Sass the correct order to sort strings in based on the characters each string contains. Let's define this in a variable:

    :::scss
    // Declare the default sort order. Use Sass's !default flag so this
    // value doesn't override the variable if it was already declared.
    $default-sort-order: a b c d e f g h i j k l m n o p q r s t u v w x y z !default;

This can be used to declare that strings that begin with `a` should appear before strings that begin with `b` or `c` and so on. In real life you'd probably want to include other characters in your sort order string (like numbers, characters with accents, and other symbols), but `a-z` works for our example.

Now for the meat of our comparison function:

    :::scss
    @function str-compare($string-a, $string-b, $order: $default-sort-order) {
      // Cast values to strings
      $string-a: to-lower-case($string-a + unquote(""));
      $string-b: to-lower-case($string-b + unquote(""));      

      // Loop through and compare the characters of each string...
      @for $i from 1 through min(str-length($string-a), str-length($string-b)) {

        // Extract a character from each string
        $char-a: str-slice($string-a, $i, $i);
        $char-b: str-slice($string-b, $i, $i);
        
        // If characters exist in $order list and are different
        // return true if first comes before second
        @if $char-a and $char-b and index($order, $char-a) != index($order, $char-b) {
          @return index($order, $char-a) < index($order, $char-b);
        }
      }
      
      // In case they are equal after all characters in one string are compared,
      // return the shortest first
      @return str-length($string-a) < str-length($string-b);
    }

What's going on here? We are basically looping through the characters in each string (`$string-a` and `$string-b`) and looking up the location of each in the `$order` list with the Sass `index()` function. This gives us two numbers that can be compared to see which character goes before the other. If the numbers are the same we loop around to the next set of characters, but if they are different we've found which one goes first.

The `str-compare()` function returns `true` if `$string-a` goes before `$string-b` and `false` if it does not.


## Swapping two values

For the sake of our example, I'm going to implement the sorting function using the [Bubble Sort](http://en.wikipedia.org/wiki/Bubble_sort) algorithm because it's easy to understand.

Since Bubble Sort relies on swapping two values in a list we need one more function to make this easy for us:

    :::scss
    @function swap($list, $index-a, $index-b) {
      @if abs($index-a) > length($list) or abs($index-b) > length($list) {
        @return $list;
      }
      $tmp: nth($list, $index-a);
      $list: set-nth($list, $index-a, nth($list, $index-b));
      $list: set-nth($list, $index-b, $tmp);
      @return $list;
    }

Our new `swap()` function accepts a list along with two indexes (`$index-a` and `$index-b`) that indicate the positions of the two items in the list to swap. To avoid cycling through the list to swap values, I've taken advantage of the `set-nth()` function (new in Sass 3.3) which simply updates the list instead of building a fresh one (which is far better for performance).


## The string sorting function

Armed with `str-compare()` and `swap()` we now have everything we need to build a proper string sorting function:

    :::sass
    @function sort($list, $order: $default-sort-order) {

      // Cycle through each item in the list
      @for $i from 1 through length($list) {

        // Compare the item with the previous items in the list
        @for $j from $i * -1 through -1 {

          // abs() trick to loop backward
          $j: abs($j);

          // Compare both values
          @if $j > 1 and str-compare(nth($list, $j), nth($list, $j - 1), $order) {
            // If the item should go before the other, swap them
            $list: swap($list, $j, $j - 1);
          }
        }
      }

      // Return the sorted list
      @return $list;
    }

Bubble Sort basically loops through the list, compares items with each other and swaps them once compared until the list is completely sorted.

Now let's test it:

    :::scss
    $list: oranges pears apples strawberries bananas;
    $sort: sort($list);
    // => apples bananas oranges pears strawberries

Hurray! It works like a charm.


# Learning more

My first attempts to create a sorting function in Sass used a much slower algorithm. But thanks to some prompting by [Sam Richards](http://twitter.com/snugug) (he got me started with QuickSort) I eventually explored a number of different sorting algorithms. I've now implemented several of these in Sass. You can find the code and tests in the [SassySort](https://github.com/HugoGiraudel/Sass-sort) repository.
