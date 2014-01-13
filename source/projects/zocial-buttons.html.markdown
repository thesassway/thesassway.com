---
date: 2011-10-14 00:30:00 -0500
categories: projects
author: Adam Stacoviak
summary: Zocial Buttons is a CSS3 buttons Sass framework that makes adding "Follow me on Twitter", "Find us on Facebook" and "Fork this on GitHub" buttons to your site TOO EASY.
---

# Zocial: CSS3 Buttons, Sass framework.

Zocial Buttons is a CSS3 buttons Sass framework that makes adding "Follow me on Twitter", "Find us on Facebook" and "Fork this on GitHub" buttons to your site TOO EASY.

<a href="http://zocialbuttons.com/"><img src="http://zocialbuttons.com/images/zocial-lite-preview.jpg" class="full"/></a>

## Credits

HUGE thanks to [Sam Collins](http://twitter.com/smcllns) for all his hard work on the original CSS3 button set and the Zocial icons font! Without his work, this project would not exist. This free and open source version includes a now free subset of the font sold [here](http://zocial.smcllns.com/).

Zocial Buttons as a Sass framework was developed by me, Adam Stacoviak. Sam and I are working together to make Zocial the awesomest "all CSS" social buttons set. Feedback is very much welcome!

## Vector Icon Font + CSS3 + Sass and Compass

I can't tell you how much time I've wasted in the past creating these buttons in Photoshop and creating sprites for the various states. Now there's no need to waste that time anymore! It's frameworks like this that REALLY make me appreciate the power of Sass and Compass.

## Compass FTW!

By far, one of the coolest features of Compass for extension developers (and extension users) is the ability to package up other assets for the framework such as HTML, images, fonts or even starter Sass stylesheets -- they then can be installed via the Compass command-line.

For example, once you've installed Zocial and you've required it in your Compass config, most often `config.rb`, you can run the Compass install command to install the fonts.

    :::bash
    compass install zocial/fonts
    
When you run this, Compass will install the Zocial lite fonts into your project.

    :::bash
    -> % compass install zocial/fonts
    directory fonts/zocial/ 
      create fonts/zocial/zocial-lite-regular-webfont.eot
      create fonts/zocial/zocial-lite-regular-webfont.svg
      create fonts/zocial/zocial-lite-regular-webfont.ttf
      create fonts/zocial/zocial-lite-regular-webfont.woff
      
## Installation and Usage
      
For full installation and usage details, please see [the project's readme](https://github.com/adamstac/zocial/blob/master/README.mdown).

## Links

* [Source on GitHub](https://github.com/adamstac/zocial)
* [Homepage](http://zocialbuttons.com/)
* [Buy the full Zocial font](http://zocial.smcllns.com/)
