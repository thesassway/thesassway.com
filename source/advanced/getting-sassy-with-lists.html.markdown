---
date: 24 November 2013
categories: advanced, guides
author: Hugo Giraudel
summary: Hugo Giraudel is back with another article on his new SassyLists library. Learn about how he made it and gain insight into how to build your own Compass extensions.
---

# Getting Sass-y with lists!


Hey guys, I'm very glad to be back at TheSassWay for another post! Today, I'd like to introduce the incoming version of my Sass library called [SassyLists](http://sassylists.com). As you may know, Sass 3.3 is about to be released, and I have quite a couple of awesome things coming up for SassyLists.

But first, let me quickly introduce the project for those of you who don't know what it is about. You have probably noticed how powerful Sass lists can be. [You can do amazing things with them.](http://hugogiraudel.com/2013/07/15/understanding-sass-lists/) The only problem is that Sass doesn't provide a lot of tools to deal with lists. Let's see, we have: `append()`, `length()`, `nth()`, `join()`, `zip()` and `index()`. Okay, that's a good start, but what if we want more?

This is why I created SassyLists. A library of advanced functions to make dealing with lists easy. As of today, it includes almost thirty functions and with more to come. SassyLists profides familiar tools like `replace()`, `remove()`, `insert-nth()`, `slice()`, and even `reverse()` to name just a few. For the complete list of available functions, have a look at [the main table on the site](http://sassylists.com/).

I started this project a couple of months ago. It began with just a few functions, but as time passed, I added more and more. And with the upcoming release of Sass 3.3 I completely rewrote the library.


## Dealing with dependencies

One of my goals for SassyLists was to give users the ability to include small pieces of the library without requring them to import the whole thing. To do this, I created a function that allows me to scan for missing functions so that I can output an appropriate error message. This is now possible because of the new `function_exists()`, `variable_exists()`, `mixin_exists()` functions present in Sass 3.3.

So let's build our own function to help us determine when dependencies are missing. We'll pass it a list of function names we need for a specific case, and it should return true only if all of them are available. Something like this:

``` sass
@function dependencies($functions...) {
  @each $function in $functions {
    @if not function_exists($function) {
      @return false;
    }
  }

  @return true;
}
```

Couldn't be any simpler, right? We loop through the arguments passed to the function and check them with the `function_exists()` function. If any of them doesn't exist, we return `false`. If we get out of the loop (because all dependencies are okay), we return `true`. 

Now let's use it:

``` sass
@function whatever($arg) {
  @if dependencies('insert-nth', 'remove') {
    // Function body ...
  } @else {
    @warn "A function is missing for `whatever`. Please make sure you're including all dependencies.";
    @return false;
  }
}
```

In case either `insert-nth()` or `remove()` doesn't exist in current context, the `whatever()` function will return `false` and will warn us that there is a missing dependency. 

Now what if we want to tell what function is missing in the warning message? That's actually pretty simple, we just have to tweak our `dependencies()` function a little:

``` sass
@function dependencies($functions...) {
  $result: ();

  @each $function in $functions {
    @if not function_exists($function) {
      $result: append($result, $function);
    }
  }

  @return if($result == (), false, $result);
}
```

Instead of simply toggling a boolean, we return `false` if everything is alright or a list of missing dependencies (which is basically `true`). Now we can write our `whatever()` function like this:

``` sass
@function whatever($arg) {
  $missing-dependencies: dependencies('insert-nth', 'remove');

  @if not $missing-dependencies {
    // Function body 
  } @else {
    @warn "#{$missing-dependencies} missing for `whatever`. Please make sure you're including all dependencies.";
    @return false;
  }
}
```

There we go. Now it will output a list of all missing functions. Let's say you forgot to include both `insert-nth()` and `remove()`. The warning message will be: 

> "insert-nth" "remove" missing for `whatever`. Please make sure you're including all dependencies.

Pretty neat, right? Now what if the `dependencies()` function doesn't exist at all? Maybe someone saw a function in my library that they wanted to use and copy and pasted it into a project, but didn't include the necessary functions (including the `dependencies()` function itself). In that case the error message will still be displayed because of the way Sass handles functions that it doesn't understand.

When Sass encounters a function that it doesn't know it leaves it untouched in the source. This is needed so that when newer versions of CSS introduce their own functions Sass itself doesn't need to be updated to know about it. This makes Sass forwards compatible with future versions of CSS that may introduce new functions. (Incidently, this is exactly what happened when `linear-gradient()` was added with CSS3.)

In our case this behavior actually turns out to be useful because the dependency function will be interpreted as a string (`dependencies(...)`) which in turn is interpeted by our `@if` statement as a `true` assertion which causes the error message to display.


## Making a sorting function

The early versions of SassyLists included a sorting function to sort a list of numeric values, but it was not possible to build a function in pure Sass to sort string values. Thankfully, Sass 3.3 has added the features I need to build a string sorting function in pure Sass.

Let's start with the skeleton for our sorting function: 

``` sass
@function sort($list, $order: null) {
  $missing-dependencies: dependencies("_compare", "insert-nth");
  
  @if not $missing-dependencies {
    // Function body 
  } @else {
    @warn "#{$missing-dependencies} missing for `sort`. Please make sure you're including all dependencies.";
    @return false;
  }
}
```

We've used our `dependencies()` function to declare that this function needs `_compare()` and `insert-nth()` from SassyLists.

The first agument `$list` is is the list to sort and the second argument `$order` is a list of characters that determines the sort order.

For example, passing:

    $order: a b c d e f g h i j k l m n o p q r s t u v w x y z

Will declare that words that begin with "a" should appear before words that begin with "b" or "c" and so on.

In the function signature `$order` is an optional parameter with a default value of `null`. I've chosen to set it to `null` by default so that the function signature is a little cleaner. In the body of the function I set the real default value like so:

``` sass
$order: if($order != null, $order, " " "!" "\"" "#" "$" "%" "&" "'" "(" ")" "*" "+" "," "-" "." "/" ":" ";" "<" "=" ">" "?" "@" "[" "\\" "]" "^" "_" "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z");
```

If I didn't do this the function signature would have the entire list in it which would make it harder to read.

Now, getting back to the task at hand: sorting. Here's the rest of the body of the sorting function:

``` sass
// Put a first word in the result list
$result: nth($list, 1);

// Loop through the values from list. Start from the 2nd
// since we just appended the first.
@for $i from 2 through length($list) {
  $item: nth($list, $i);

  // If it's not a list
  @if length($item) == 1 {
    $index: 0;

    // Loop through all sorted values in $result and find the
    // proper place to insert $item.
    @for $j from 1 through length($result) {
      // If the current $item is greater than the item for $result 
      // remember the index.
      @if _compare($item, nth($result, $j), $order) {
        $index: $j;
      }
    }
    // Now we know where to insert $item...
    $result: insert-nth($result, $index + 1, $item);
  }

  // If it's a list, we simply warn the user that we won't deal with it
  @else {
    @warn "List found. Omitted.";
  }
}

// Return result
@return $result;
```

To prevent the `sort` function from being 50 lines long, I created a second function to compare two strings and return `true` if the first comes before the second. This is what `_compare()` does. (I prefixed it with an underscore because it is really just a helper function and is not meant to be used on it's own.)

Here's how the comparison function is defined:

``` sass
@function _compare($a, $b, $order) {
  // Cast both values strings and convert them to lowercase.
  $a: to-lower-case($a + unquote(""));
  $b: to-lower-case($b + unquote(""));

  // Loop through and compare the characters of each string...
  @for $i from 1 through min(str-length($a), str-length($b)) {

    // Get the index of the character in the $order list
    $index-a: index($order, str-slice($a, $i, $i));
    $index-b: index($order, str-slice($b, $i, $i));

    // If the indexes are different, return true if the first
    // is greater than the last.
    @if $index-a != $index-b { @return $index-a > $index-b; }

    // If they are equals, do nothing and move on to next character
  }
  
  // In case they are equals after all chars, return the shortest first
  @return str-length($a) > str-length($b);
}
```
That's pretty much it. Now let's test it:

``` sass
$list: aztr tzep "!taopzt" 21 aztp 3ef "#" 67% fiofa 121 az 4px 4 4p tr fml 454 sglm zmlgk vk321 mletk ez15kmelk z;
$sort: sort($list);
// !taopzt, #, 121, 21, 3ef, 4, 454, 4p, 4px, 67%, az, aztp, aztp, aztp, aztr, ez15kmelk, fiofa, fml, mletk, sglm, tr, tzep, vk321, z, zmlgk
```

Hurray! It works like a charm. We could slightly improve the `compare()` function so that it warns us in case it finds a character that doesn't exist in the `$order` list. As you may guess, it is very simple to do:

``` sass
$index-a: index($order, str-slice($a, $i, $i));
@if not $index-a {
	$index-a: 1;
	@warn "#{str-slice($a, $i, $i)} from #{$a} not found in $order list.";
}

$index-b: index($order, str-slice($b, $i, $i));
@if not $index-b {
	$index-b: 1;
	@warn "#{str-slice($b, $i, $i)} from #{$b} not found in $order list.";
}
```

Not only does it warn the user, but it also prevent the function from failing because of an index set to `false`. If the character is not found, the index is set to 1 so the function can go on. Of course, this may resolve in a slightly wrong order, fixable by editing the $order list of characters.


## Meanwhile

While waiting for the 1.0.0 running on Sass 3.3, you can still use SassyLists (in 0.4.3 as of writing) either by sneaking into the [GitHub repository](https://github.com/Team-Sass/SassyLists) or by installing it as a Compass Extension:

1. `gem install SassyLists`
2. Add `require 'SassyLists'` to your `config.rb`
3. Import it in your stylesheets with `@import 'SassyLists'`

Hope you like it! If you think of anything to improve it, be sure to share.
