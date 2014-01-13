---
date: 29 June 2011
categories: beginner, guides
author: Adam Stacoviak
summary: So your friend, co-worker, web-buddy or whomever told you about Sass, Compass ... or both. Great! Now what? In this beginner guide we take you through the first steps of getting started with Sass and Compass. We walk you through installation, creating a test project, compiling your first lines Sass to CSS and we even "mixin" a little Sass history.
---

# Getting started with Sass and Compass

So your friend, co-worker, web-buddy or whomever told you about Sass, Compass ... or both. Great! Now what? In this beginner guide we take you through the first steps of getting started with Sass and Compass. We walk you through installation, creating a test project, compiling your first lines of Sass to CSS, and we even "mixin" a little Sass history.

## Install Sass and Compass

Sass and Compass get installed as Ruby gems so you'll need to have Ruby on your machine.

If you're on Windows, you can run the [Ruby Installer](http://rubyinstaller.org/). On Linux, [Rails Ready](https://github.com/joshfng/railsready) provides several Ruby essentials. On OS X, Ruby is already installed by default so Ruby just works.

Getting Ruby in place is beyond the scope of this article, so, if you hit any snags hit up [the mailing list](http://groups.google.com/group/sass-lang) if you need help finding the right resources for getting Ruby on your machine.

### Install Sass

Ok, let's install Sass! Open up your [Terminal.app](http://en.wikipedia.org/wiki/Apple_Terminal) and type:

#### Windows:

    :::bash
    gem install compass

#### Linux / OS X:

    :::bash
    sudo gem install compass

For Linux and OS X folks, depending on your setup, you may or may not need to install gems under the `sudo` user. For example, if you are using [RVM](http://beginrescueend.com/), you won't need to install your gems under the `sudo` user.

Ok, I know what you're thinking. I just said that we are going to install Sass, but I just told you to install Compass based on that directive. The truth is, Compass requires Sass and when you run that command you should see something like this:

    :::bash
    $ sudo gem install compass
    Fetching: sass-3.1.3.gem (100%)
    Fetching: compass-0.11.3.gem (100%)
    Successfully installed sass-3.1.3
    Successfully installed chunky_png-1.2.0
    Successfully installed fssm-0.2.7
    Successfully installed compass-0.11.3
    4 gems installed

If that's not what you saw when you ran that command, you may not have Ruby or Ruby Gems on your machine. Covering this in detail is a bit beyond where I want to go in this post, so seek help at [the mailing list](http://groups.google.com/group/sass-lang) if you encounter any issues.

If you are intimidated by [the command line](http://en.wikipedia.org/wiki/Command-line_interface), don't be. [John Long](http://twitter.com/johnwlong) has written an awesome guide titled, ["The Designer’s Guide to the OSX Command Prompt"](http://wiseheartdesign.com/articles/2010/11/12/the-designers-guide-to-the-osx-command-prompt/), that should get you up to speed on the subject.

Also, there are 2 GUI apps for Sass/Compass, but we'll be assuming command-line usage for this guide.

* [Scout](http://mhs.github.com/scout-app/) (cross-platform) from [Mutually Human](http://mutuallyhuman.com/)
* [Compass.app](http://compass.handlino.com/) (Windows/Linux/Mac OS X) from Handlino.

### CSS Parser

I also like to install [css_parser](http://rubygems.org/gems/css_parser) to take advantage of all the features of `compass stats` which outputs statistics of my Sass stylesheets. It outputs a report that gives a count of the Sass rules, properties, mixins defined and mixins used as well as the CSS rules and properties that get output from your Sass-stylesheets.

Run this command to install `css_parser`

    :::bash
    gem install css_parser

Now you are ready for some hardcore Sass and Compass action!

## Create a test project

The easiest way to get started with something new is to just jump right in. On that note. Head to the place you store you codes (or where ever you'd like to store this test project) and run this command.

    :::bash
    compass create sass-test

Alternatively you can pull down [the test project](https://github.com/thesassway/sass-test) from GitHub using this:

    :::bash
    git clone https://github.com/thesassway/sass-test.git

But that would completely defeat the purpose of learning how to do this on your own.

Moving on. Change directory (<a href="http://en.wikipedia.org/wiki/Cd_(command)">cd</a>) into the newly created `/sass-test` directory and open it up in your favorite editor. I use [TextMate](http://macromates.com/), but I've been contemplating trying out [Vim](http://www.vim.org/) or [Sublime Text 2](http://www.sublimetext.com/2). We've covered Vim quite a bit on The Changelog, so take a peek at [the search results for Vim on The Changelog](http://www.google.com/search?q=site%3Athechangelog.com+Vim) and dig in.

## Compile Sass to CSS

This is the easiest part. Sass and Compass does all the hard work, so run this command and let Compass do its thing.

    :::bash
    compass watch

You should see something like this if you've done well with following along.

    :::bash
    $ sass-test git:(master) compass watch
    FSSM -> An optimized backend is available for this platform!
    FSSM ->     gem install rb-fsevent
    >>> Compass is polling for changes. Press Ctrl-C to Stop.

If that's the case go ahead and let out a loud "yee" and pat yourself on the back because you are now ready to start writing your CSS ... The Sass Way!

The `compass watch` command does exactly what you would think it would do &ndash; it watches your Sass files for changes (saved changes) and automatically compiles your Sass to CSS. How does it know where the Sass is and where the CSS should be compiled to? That's a great question, and one that I'll cover in more detail in a future post titled "Configuring Compass".

In the meantime, take a look at [config.rb](https://github.com/thesassway/sass-test/blob/master/config.rb) located in the root of our sass-test project. The [Compass configuration](http://compass-style.org/help/tutorials/configuration-reference/) is essentially the brain of Compass and defines a number of variables letting Compass know where your Sass, CSS, images and JavaScript files are located, what extensions to require, what syntax you prefer, the output style and much more.

## Write some Sass

Ok, before we actually write some Sass, it's important to know that Sass has some history to it. In fact, one of the hardest things to grasp is that Sass actually has two [syntaxes](http://en.wikipedia.org/wiki/Syntax) &ndash; and that's often what either confuses or intimidates people and deters them from even giving it a try. How do I know? Because that's exactly how I felt BEFORE I bit the bullet and took the proverbial plunge. But let's not get off track here.

Sass is like CSS. Ok, that's misleading. Sass CAN BE like CSS.  I mentioned that Sass has some history to it and actually has not one, but two syntaxes. One of the syntaxes is even named "Sass" which adds even more confusion to the mix. The main syntax is referred to as "SCSS" (for "Sassy CSS") and is new as of Sass 3. The older syntax (part of that history I mentioned) is referred to as the indented syntax (or just "Sass").

Now that we've covered a bit of the history of Sass and the fact that it has two syntaxes, I believe we are ready to write some code. Or should I say SCSS &ndash; because the SCSS syntax is like CSS and was designed to be a superset of CSS3's syntax. This means that every valid CSS3 stylesheet is valid SCSS. In fact, you can copy the contents of a CSS file and paste it into a SCSS file and Sass will compile it to clean CSS.

Let's test out this "theory" and copy the contents of [our css file](http://thesassway.com/css/master.css) from this blog and paste it into [screen.scss](https://github.com/thesassway/sass-test/blob/scss-is-like-css/sass/screen.scss) in our test project and run `compass compile`. Take a look at [screen.css](https://github.com/thesassway/sass-test/blob/scss-is-like-css/stylesheets/screen.css) now and you'll see that Sass and Compass have compiled that compressed un-readable CSS to readable, perfectly indented CSS along with comments of where the code came from for debugging purposes.

## Conclusion and next steps

This example is obviously not the most practical example, and technically we didn't write *any* code. I just wanted to prove to you that there can be next to zero effort in transitioning to Sass because you just did it.

The next step is to take advantage of the features of [Sass](http://sass-lang.com/tutorial.html#features) and [Compass](http://compass-style.org/) that are now available to you, when you choose to use them. That's the best part of this transition. You can incrementally step into what Sass and Compass have to offer. There's no reason to be *intimidated* or feel it will "take weeks" to do.

Do it. Do it now.
