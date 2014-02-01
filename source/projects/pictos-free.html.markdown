---
date: 2011-10-16 10:00:00 -0500
categories: projects
author: Adam Stacoviak
summary: Pictos Free is a free version of Pictos-style Tumblr icons from Drew Wilson, thanks to his collaboration with WooThemes, that I've packaged it up as a simple Compass extension that leverages Compass's spriting feature.
---

# Pictos Free + Spriting with Compass

Pictos is awesome! And thanks to WooThemes, Drew Wilson released a free version to compliment blog designs called Pictos Free. Thanks Drew.

<a href="http://pictosfree.heroku.com/"><img src="/attachments/pictos-free.jpg" class="full"/></a>

## The Backstory.

So, I have been wanting to play with [Compass Spriting](http://compass-style.org/reference/compass/utilities/sprites/) and I needed an excuse to play with something real world. Since I'm a fan of Drew Wilson (see also Founders Talk episodes [#19](http://5by5.tv/founderstalk/19) and [#20](http://5by5.tv/founderstalk/20)) I decided to pull down a copy of the free version of Pictos and use that to play with Compass's spriting feature. A little while later, and with the help of my [Compass Extension Bootstrap](https://github.com/adamstac/compass-extension-bootstrap), [Pictos Free](https://github.com/adamstac/pictos-free) was born.

### What is Pictos? What is Pictos Free, and why is it free?

[Pictos](http://pictos.drewwilson.com/) is a very well done, royalty-free, icon set for interface designers by Drew Wilson. There's a [paid version](http://pictos.drewwilson.com/) as well as a [free version](http://www.woothemes.com/2010/05/pictos/) of Tumblr icons, thanks to Drew's collaboration with [WooThemes](http://www.woothemes.com/).

After [WooThemes](http://www.woothemes.com/) discovered [Drew Wilson](http://www.drewwilson.com/) and his amazing work on [Dribbble](http://dribbble.com/shots/17846-Pictos-Free), they decided to contact him about working with the WooTeam to bring some of that Pictos awesomeness over there. The result is a free, vector icon set which contains 21 icons perfectly suited for your blogging needs. By the way, you can [follow me](http://dribbble.com/adamstac) as well on Dribbble.

## Pictos Free + Demo + Code

To show off Pictos Free, I've created a demo at [pictosfree.heroku.com](http://pictosfree.heroku.com/). Dive into [the demo code](https://github.com/adamstac/pictosfree.heroku.com) and follow along with how to use it in the next sections.

### Install Pictos Free

The very first thing we need to do is install Pictos Free.

    :::bash
    (sudo) gem install pictos-free

Next, we need to require Pictos Free in our project's Compass config file.

    :::bash
    require 'pictos-free'

Once we have Pictos Free required by Compass, we can see that it is added to the list of available frameworks and patterns in Compass's framework list.

We can run `compass frameworks` in our project to see a list of frameworks we have access to.

    :::bash
    adamstacoviak@as-mbp-i7 [11:39:29] [~/Code/OS/sass/pictos-free/demo] [master]
    -> % compass frameworks
    Available Frameworks & Patterns:

      * blueprint
        - blueprint/basic      - A basic blueprint install that mimics the actual blueprint css.
        - blueprint/buttons    - Button Plugin
        - blueprint/link_icons - Icons for common types of links
        - blueprint/project    - The blueprint framework.
        - blueprint/semantic   - The blueprint framework for use with semantic markup.
      * compass
        - compass/ellipsis     - Plugin for cross-browser ellipsis truncated text.
        - compass/extension    - Generate a compass extension.
        - compass/pie          - Integration with http://css3pie.com/
        - compass/project      - The default project layout.
      * pictos-free
        - pictos-free/icons    - Pictos Free icons

### Installable Frameworks & Patterns?

By far one of the coolest and most useful features of Compass is the ability to package up your coding best practices, frameworks, etc into extensions. But, it doesn't end there.

What you may not know is that Compass allows you to package other assets for the framework such as images, fonts, text files, and more in your extension to provide installable patterns and templates.

As you can see from the output of `compass frameworks` above, we have access to pictos-free and we can install the `pictos-free/icons` pattern.

With Pictos Free, I've included a template that includes the `License.txt` file provided by Drew -- as well as 72px black and white .png versions of all 21 icons. It's quite possible that Drew and I will work together on this extension to make it more flexible as well as include other sizes, but for now, 72px black and white versions is what it ships with.

For another framework example that ships with installable patterns, take a look at [Zocial Buttons](/projects/zocial-buttons).

### Install the icons pattern

So let's install the icons templates from the extension. Run this command from the root of the project you're installing Pictos Free to.

    :::bash
    # execute at the root of your project
    compass install pictos-free/icons

You should see something like this.

    :::bash
    -> % compass install pictos-free/icons
    create public/images/pictos-free-black/icn1.png 
    ...
    create public/images/pictos-free-white/icn6.png 
    create public/images/pictos-free-white/icn7.png 
    create public/images/pictos-free-white/icn8.png 
    create public/images/pictos-free-white/icn9.png 
    create License.txt 
    remove .sass-cache/ 
    remove public/stylesheets/stylesheet.css 
    create public/stylesheets/stylesheet.css 

Once you've done this, your project will now have the images for Pictos Free installed in your images directory and you are ready to use Pictos Free!

The next step is to `@import` Pictos Free with Compass, and here's how simple that is.

    :::sass
    // Pictos Free (white)
    $pictos-free-white-spacing: 50px
    @import "pictos-free-white"

If you look at the partial file [\_pictos-free-white.sass](https://github.com/adamstac/pictos-free/blob/master/stylesheets/_pictos-free-white.sass) in the extension, you will see that all I am doing is following the Compass way of importing all the images from a folder and using the "magic sprite mixin" to add the all the icons' required styles to our CSS stylesheet.

    :::sass
    @import "pictos-free-white/*.png"
    +all-pictos-free-white-sprites
    
Which compiles to this CSS. This code snippet has been truncated because this single line of Sass compiles to approximately 174 lines of CSS for us.

    :::css
    .pictos-free-white-sprite, .pictos-free-white-icn1, .pictos-free-white-icn10 ... {
      background: url('/images/pictos-free-white-s0e3c56a72c.png') no-repeat;
    }

    .pictos-free-white-icn1 {
      background-position: 0 0;
    }

    .pictos-free-white-icn10 {
      background-position: 0 -122px;
    }

    ...

    .pictos-free-white-icn8 {
      background-position: 0 -2332px;
    }

    .pictos-free-white-icn9 {
      background-position: 0 -2455px;
    }

## Conclusion

Spriting with Compass can be pretty easy. It really does all the heavy lifting for you and all of the math as well. I also LOVE to package up code like this into reusable Compass extensions as well as provide the templates like I did here with the icons. It really makes adding a new feature or design asset to my projects that much easier. Plus, I can version that code and share it with others which is a HUGE win over the copy and paste scenario of vanilla CSS and using frameworks and patterns like this.

## Links

* [Picto Free (Compass extension)](https://github.com/adamstac/pictos-free)
* [pictosfree.heroku.com (demo)](http://pictosfree.heroku.com/)
* [pictosfree.heroku.com (demo code)](https://github.com/adamstac/pictosfree.heroku.com)
* [Picto Free (WooThemes)](http://www.woothemes.com/2010/05/pictos/)
* [Spriting with Compass (docs)](http://compass-style.org/help/tutorials/spriting/)
* [Compass Extension Bootstrap](https://github.com/adamstac/compass-extension-bootstrap)
