Date: 22 August 2050
Categories: intermediate, guides, adam-stacoviak
Author: Adam Stacoviak
Summary: A brief introduction to ... Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.

# Heading Level 1

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

## Re-factor your code to a simple readable version

This is a snippet of code share with me by Allan Branch. Allan is a n awesome designer, and like most awesome designers he wants to enjoy the CSS authoring experience more. So he's been learning more and more advanced features, giving them a try and sharing the code with me so I can help him learn best practices and new features. It's kinda like Dribbble, but with Sass instead of pixels.

* CSS-tricks: [css-tricks.com/snippets/css/css-triangle](http://css-tricks.com/snippets/css/css-triangle/)
  
    :::sass
    // http://pastie.org/2401738
    
    =triangle($direction :right, $size :12px, $tri_color :#888)
      width: 0
      height: 0
      @if $direction == right 
        border-top: $size solid transparent
        border-bottom: $size solid transparent
        border-left: $size solid $tri_color
      @else if $direction == left 
        border-top: $size solid transparent
        border-bottom: $size solid transparent
        border-right: $size solid $tri_color
      @else if $direction == top 
        border-left: $size solid transparent
        border-right: $size solid transparent
        border-bottom: $size solid $tri_color
      @else if $direction == bottom 
        border-left: $size solid transparent
        border-right: $size solid transparent
        border-top: $size solid $tri_color

    +triangle(top, 22px, green)

These can also be set inline like they were, but they are bit more readable like this. Defaults set to this value unless set elsewhere

    :::sass
    // http://pastie.org/pastes/2402479
    
    // Defaults
    $direction: top !default
    $size: 12px !default
    $color: #888 !default

    =triangle-borders($direction, $size, $color)
      border: $size solid transparent
      border-#{$direction}: $size solid $color

    =triangle($direction, $size, $color)
      height: 0
      width: 0
      +triangle-borders($direction, $size, $color)

    // Example usage
    .arrow-top
      +triangle(top, 22px, green)

    .arrow-right
      +triangle(right, 22px, green)

    .arrow-bottom
      +triangle(bottom, 22px, green)

    .arrow-left
      +triangle(left, 22px, green)
