# Simple grid mixin

I'm not a big fan of grids, and robust grid systems. I prefer creating layout as it is with semantic classes, floats, etc. But, I can't unsay that grids are sometimes very useful.

So i wanted to create simple mixin, which will allow me to use semantic classes. Also, I didn't wanted to use floats, because sometimes I need to vertically center two columns. And of course, I want to grid be responsive. Let's start!

```
@mixin row () {
    font-size: 0;
}

@mixin col ($align: top) {
    font-size: 16px;
    display: inline-block;
    vertical-align: $align;
}
```

This is little hack to kill default margin of inline-block elements. So you set font-size to zero on parent of elements. Then you need to set default font-size again in children to text be visible. Let's continue.

How do we want to pass width of column? I would like to say, make it one third. For example `@include col(1, 3);` where 1 is numerator, and 3 is denominator.

```
@mixin col ($col, $sum, $align: top) {
    width: percentage($col/$sum);
    font-size: 16px;
    display: inline-block;
    vertical-align: $align;
}
```

Now we have base that we can extend. We need to make it responsive and to add gaps. For gaps we can use padding, because it's easier to make calculations. Make sure your `box-sizing` is set to `border-box`. This method has one flaw, and that is if you want to set background of column, you will not see padding, so if you need background, make sure you set background in el which you will wrap with column. We'll also add breakpoint, and make this grid mobile first.

```
@mixin col ($col, $sum, $gap: 1em, $align: top) {
    width: 100%;
    display: inline-block;
    font-size: 16px;
    padding: 0 $gap;

    @media only screen and (min-width: 768px) {
            width: percentage($col/$sum);
            vertical-align: $align;
    }
}
```

We can add helper class if we want to our column stay fluid on mobile.

```
@mixin col ($col, $sum, $gap: 1em, $align: top) {
    width: 100%;
    display: inline-block;
    font-size: 16px;
    padding: 0 $gap;

    @media only screen and (min-width: 768px) {
            width: percentage($col/$sum);
            vertical-align: $align;
    }

    &.fluid { width: percentage($col/$sum); }
}
```

And what about first and last column? If we want them to don't have side padding, we can add new params.

```
@mixin col ($col, $sum, $gap: 1em, $align: top, $first: false, $last: false) {
    width: 100%;
    display: inline-block;
    font-size: 16px;
    padding-left: if($first, 0, $gap);
    padding-right: if($last, 0, $gap);

    @media only screen and (min-width: 768px) {
            width: percentage($col/$sum);
            vertical-align: $align;
    }

    &.fluid { width: percentage($col/$sum); }
}
```

Ok, so our grid is possible to:

- be responsive
- have custom gaps (padding based)
- vertically center columns
- stay fluid on small resolutions
- kill gaps on first and last column

And we achieved that in less than 20 lines of code. You can see [demo](http://codepen.io/goschevski/full/Awuyz).