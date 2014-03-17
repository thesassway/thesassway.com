---
date: 4 March 2014
categories: intermediate, guides
author: Aleksandar Goševski
summary: Definitive guide for using sprites in compass.
---

# Spriting in Compass

Compass has a tool for creating and maintaining sprites and it's doing very good job and saves you a big time. It's calculating position for each icon, giving you an option to set spacing around it, or to change layout of icons on the canvas, etc.

## Notice
Every folder you import need to be inside folder you specified for images in your config.rb file. So folder structure should look like this:

```
img
├── my-icons
│   ├── camera.png
│   ├── home.png
│   ├── logo.png
│   └── pencil.png
├── social
│   ├── dribbble.png
│   ├── github.png
│   └── twitter.png
├── my-icons-s7cbd13913b.png
└── social-s2621d719d4.png
```

And your images route should be: `images_dir = "img"`.

## Using sprites
There are two ways using sprites. You can achieve pretty much the same with both, but there are differences in the way you using them. First one is to import icons, and second one is to create sprite-maps.

## Quick up and runing
The easies way to instatly get sprite image and classes for each icon, is to import icons, and to call mixin that will create classes for you.

```
@import "my-icons/*.png";
@include all-my-icons-sprites;
```

output is:

```
.my-icons-sprite, .my-icons-camera, .my-icons-home, .my-icons-pencil {
  background-image: url('../img/my-icons-s1f1c6cbfd0.png');
  background-repeat: no-repeat; }

.my-icons-camera {
  background-position: 0 -32px; }

.my-icons-home {
  background-position: 0 -128px; }

.my-icons-pencil {
  background-position: 0 -160px; }
```

But if you want little more control, you will skip including all-[FOLDER NAME]-sprites.

## Control
To control classes of your icons, you can use functions and mixins compass provided for you.

So, if you're importing icons, you can manage it on this way:

```
@import "my-icons/*.png";

.camera { @include my-icons-sprite(camera); }
.home { @include my-icons-sprite(home); }
.pencil { @include my-icons-sprite(pencil); }
```

Or if you're creating sprite-map, you can achieve the same thing on this way:

```
$icons: sprite-map("my-icons/*.png");

.camera { background: sprite($icons, camera); }
.home { background: sprite($icons, home); }
.pencil { background: sprite($icons, pencil); }
```

#### Spacing
To set a spacing around each icon:

Import:

```
$my-icons-spacing: 5px;
@import "my-icons/*.png";
```

Sprite-map:

```
$icons: sprite-map("my-icons/*.png", $spacing: 5px);
```

#### Layout
There are 4 types of layout: horizontal, vertical, diagonal and smart. To set layout of positioning icons on canvas:

Import:

```
$my-icons-spacing: 5px;
$my-icons-layout: 'smart';
@import "my-icons/*.png";
```

Sprite-map:

```
$icons: sprite-map("my-icons/*.png", $spacing: 5px, $layout: diagonal);
```

**Note:** In current version of Compass, you can't use spacing and smart layout in the same time. For all layouts check out link in last section of article about sprite layouts.

#### Position
You can even set manually position of some image, if you want to repeat it, or to place it on center, or something like that. Format for that variable is `$[FOLDER NAME]-[ICON NAME]-position: [VALUE];`

```
$my-icons-spacing: 10px;
$my-icons-home-position: 500px;
@import "my-icons/*.png";
```

**Note:** This works only for vertical and horizontal layout. For vertical layout value is x position, and for horizontal it is y position.

## Functions and mixins
Compass is providing you lot of helper mixins and functions.

`sprite-url($icons)` - Returns a url of sprite image <br />
`sprite-position($icons, camera)` - Return x and y of icon on sprite image <br />
`@include sprite-dimensions($icons, camera)` - Set width and height of icon

Usage

```
.camera-icon {
    background-image: sprite-url($icons);
    background-position: sprite-position($icons, camera);
    @include sprite-dimensions($icons, camera);
}
```

## Best practices
I found the best way using sprite is to place it inside of some pseudo element - before or after. Just create pseudo-element with width and height of icon, and place it where ever you want.

```
.home-btn {
    display: inline-block;
    padding: 10px 20px;
    background: #333;

    &:before {
        content: "";
        display: inline-block;
        vertical-align: middle;
        background: sprite($icons, home);
        @ionclude sprite-dimensions($icons, home);
    }
}
```

## Useful links
As you probably noted, Compass doesn't shine when it comes to documentation, so I created list of useful links for you.

- [Spriting Tutorial](http://compass-style.org/help/tutorials/spriting/)
- [Sprite maps](http://compass-style.org/reference/compass/helpers/sprites/)
- [Mixins](http://compass-style.org/reference/compass/utilities/sprites/base/)
- [More mixins](http://compass-style.org/reference/compass/utilities/sprites/sprite_img/)
- [Sprite layouts](http://compass-style.org/help/tutorials/spriting/sprite-layouts/)
- [Sprite variables](http://compass-style.org/help/tutorials/spriting/customization-options/)