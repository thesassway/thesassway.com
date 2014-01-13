---
date: 2011-11-22 09:30:00 -0600
categories: intermediate, guides
author: John W. Long
summary: Most people who use Sass are familiar to some degree with the command line. While programs like Compass.app and Scout.app are making it easier to use Sass and Compass without using the command line, hidden gems await those who are willing to do so.
---

# Interactive Sass: Having Fun On The Terminal

Most people who use Sass are familiar to some degree with the command line. While programs like [Compass.app](http://compass.handlino.com/) and [Scout.app](http://mhs.github.com/scout-app/) are making it easier to use Sass and Compass without using the command line, hidden gems await those who are willing to do so.

## The Interactive Sass Interpreter

One of these little gems is the interactive Sass interpreter. Many modern programming languages (like Python and Ruby) ship with an interactive version that can be used from the command prompt. These programs read a line of code in from the user, evaluate it, and output the result. It's called a Read-Eval-Print loop, also known as [REPL](http://en.wikipedia.org/wiki/Read–eval–print_loop).

To use the interactive interpreter for Sass, open up the [command prompt](http://wiseheartdesign.com/articles/2010/11/12/the-designers-guide-to-the-osx-command-prompt/) and type:

    :::bash
    sass --interactive

Or, if you like, use the short version of the same command:

    :::bash
    sass -i

Once started in interactive mode, the `sass` command will output a prompt ">>" asking for input. Enter any valid [Sass Script](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#sassscript) expression and it will output the result on the line below:

    >> 12 * 4 - 6
    42
    >> 1px + 1px + 1px
    3px
    >> lighten(#333, 10%)
    #4d4d4d

*Sass Script* is a small subset of the Sass language. It mostly includes the mathematical parts of Sass and functions. You can't use Sass features like mixins or variables. But even with this small amount of functionality, you can still use interactive Sass to learn some interesting things about the Sass language. For instance:

    >> 1em + 1px
    SyntaxError: Incompatible units: 'em' and 'px'

Oh! That should have been obvious. Sass has no way of adding ems and pixels. So it will throw an error if you try to add them.

And this one:

    >> #333 + #666
    #999999

Wow! Did you know that you can add colors in Sass? And that's not all, you can also subtract, multiply and divide!

    >> #999 - #333
    #666666
    >> #333 * #030303
    #999999
    >> #999 / #030303
    #333333

Now I don't use color math with Sass every day, mostly because Sass color functions have replaced the need for it, but you can get an idea of how they work using interactive Sass.

Speaking of Sass color functions, I often use interactive Sass to reduce a series of complex color functions to a color value:

    >> saturate(#113, 10%)
    #0e0e36
    >> adjust-hue(green, 10deg)
    #008015
    >> adjust-color(blue, $lightness: -20%, $hue: 20deg)
    #330099

This allows me to design in the browser tweaking color values with functions. When I arrive at a color I like, I can simplify it to it's actual color value using the `sass` command in interactive mode.

To quit once you've entered interactive mode, just type `Ctrl+D`.

## Conclusion

As you can see, the interactive Sass interpreter is an nice way to play with many Sass Script functions, math, color functions and more. If you're a Compass user (as you should be), it's also worth mentioning Compass includes it's own version of interactive Sass which will give you access to an array of additional functions that Compass provides. Just execute `compass interactive` on the command prompt.
