## Teaser

Sass gladly lets you add calculations and logic in a way that CSS would never abide. But does that mean you should go around adding and dividing just anywhere? Find out how you can use pure Sass functions to make reusable logic more useful and your working Sass file more readable. 



# Pure Sass Functions

Sass has [mixins](http://sass-lang.com/#mixins), we all know that. And because they accept arguments I always thought of them as Sass's version of functions. Pretty sweet. But when Sass version 3.1.0 came out it added a feature that blew that notion apart. Yeah you guessed it, actual [functions](http://sass-lang.com/docs/yardoc/file.SASS_CHANGELOG.html#sassbased_functions). Instead of outputting one or more lines of Sass the way mixins do, functions return a value. This makes them a super powerful behind-the-scenes player in a lot of my favorite Sass recipes. 

## Functons and Mixins: Kissin' Cousins

### *Exhibit A: Mixin*  
Can accept arguments and do calculations. Writes Sass as output.

    @mixin my-padding-mixin($some-number) {
      padding: $some-number;
    }

SCSS
  
    .my-module {
      @include my-padding-mixin(10px);
    }
  
CSS

     .my-module {
       padding: 10px;
     } 
    

### *Exhibit B: Function*  
Same as a mixin, but the output is a single value. This can be any Sass [data type](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#data_types) (numbers, strings, colors, booleans, or lists).

    @function my-calculation-function($some-number, $another-number){
      @return $some-number + $another-number
    }

SCSS

    .my-module {
      padding: my-calculation-function(10px, 5px);
    }

CSS

    .my-module {
      padding: 15px;
    }



This helps you write more readable and DRY Sass, by letting you move your reusable logic out of specific declarations and even out of your mixins. This can make all the difference in the world when you're working on something that's even a little bit complex.

## Using Functions

I love how writing Sass lets me think like a programmer when I'm writing CSS. It's very satisfying to refactor and abstract the methods behind successful techniques to make them reusable and portable for the next project. I use functions when I have to calculate a value that may be reused somewhere else.

For example, in Ethan Marcotte's lovely new book [*Responsive Web Design*](http://www.abookapart.com/products/responsive-web-design), he stresses the formula for calculating the percent value for a width so you can achieve a fluid layout based on a reference design made using pixels.


    target ÷ context = result


So if you have a container that's 1000px wide, and a module that's designed to be 650px wide, that calculation becomes: 


    650px ÷ 1000px = 65% 


That's as clear a case for a function as I can imagine. It would be overkill to work that logic into each mixin for a site, and even worse to do those calculations in line. So in a recent project I just created a little function, like so:


    @function calc-percent($target, $container) {
      @return ($target / $container) * 100%;
    }

Tip: I like to create shortnames for functions and mixins I'll be using often, so for this one I created this little guy. It simply collects the needed arguments, and passes it along to it's sister with the longer name, and then returns the value to my Sass.

    @function cp($target, $container) {
      @return calc-percent($target, $container);
    }

With that in place, I can easily remove the mechanics of that process out of my view, and focus on writing my Sass using the values I already know.


    .my-module {
      width: calc-percent(650px, 1000px);
    }

or     

    .my-module {
      width: cp(650px, 1000px);
    }


Either of which simply output the css: 

    .my-module {
      width: 65%;
    }

This is a simple example, but I think it's a pretty useful one, especially if you'd rather do math in your computer than in your head. And once you start pulling a few calculations into Sass functions, you'll start to see how they open up new ways to write lighter, cleaner Sass.

## Dig Deeper

Sass functions have become an indispensable tool for me on all my latest projects. And that appears to be true for others as well. If you dig into [the](http://compass-style.org/reference/blueprint/grid/) [source](http://compass-style.org/reference/compass/layout/grid_background/) [code](http://compass-style.org/reference/compass/typography/vertical_rhythm/) of in [Compass](http://www.abookapart.com/products/responsive-web-design) you'll see that a lot of real heavy lifting is done by some well-placed functions.
