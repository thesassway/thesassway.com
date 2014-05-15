---
date: 2014-05-14 16:15:00 -0500
categories: intermediate, modular-css
author: Jaime Caballero
summary: Tired of all those meaningless classes sprinkled all over your HTML? Well, don't worry, at the end of this post you will know how to write clean, object-oriented CSS.
---

#Introduction to OOCSS

Tired of all those meaningless classes sprinkled all over your HTML? Well, don't worry, at the end of this post you will know how to write clean, object-oriented CSS. And if you combine it with Sass you get best of both worlds: modular, maintainable and scalable CSS. 

<abbr title="Object Oriented CSS">OOCSS</abbr> is not that different from other CSS methodolgies like [SMACSS](http://smacss.com/) or [BEM](http://bem.info/). All of them aim to separate content from structure by placing CSS styles in reusable modular blocks of code. In fact, I usually mix SMACSS with OOCSS. You should already be using [a standard module definition for Sass](/intermediate/a-standard-module-definition-for-sass). But let's get to the point.

##What is a CSS object?

> &ldquo;It's a repeating visual pattern, that can be abstracted into an independent snippet of HTML, CSS and possibly JavaScript.&rdquo; -  Nicole Sullivan

Abstraction is the very first thing you have to consider when buildin a CSS object. But how do we separate and organize the code? [Nicole Sullivan](https://github.com/stubbornella), who presented OOCSS back at Web Directions North in Denver, defined **two main principles**:

- **Separate structure and skin**: You should keep the structure and positioning in a base object and the visual features (like `background` or `border`) in extender clases. This way you'd never have to overwrite visual properties.
- **Separate container and content**: Never rely on HTML structure to write your CSS. So don't use tags or IDs for your objects. Instead, try to create and apply a class that describes the use of the tag in question. This also assures you that any unclassed tags will look the same.

##Let's do a quick example
Applying these principles can be difficult at first. Let's see how this would apply in a real piece of code like this one:

    :::scss
	/* The bad way */
	.box-1 {
		border: 1px solid #CCC;
		width: 200px;
		height: 200px;
		border-radius: 10px;
	}
	.box-2 {
		border: 1px solid #CCC;
		width: 120px;
		height: 120px
		border-radius: 10px;
	}

As you can see, we're repeating code, so if we had to change the `border-radius` or the `background` it would mean to check all the places it's been set. How do we make it more scalable and easy to mantain? We can abstract the visual properties into another class.

    :::scss
	/* The good way */
	.box-1 {
		width: 200px;
		height: 200px;
	}
	.box-2 {
		width: 120px;
		height: 120px;
	}
	.box-border{
		border: 1px solid #CCC;
		border-radius: 10px;
	}

Now we can apply these classes to all our HTML elements, combining them to create extended objects. Remember to keep you classes non-semantic so you can apply them everywhere.

##What about semantics and upkeep?
You shouldn't care about being non-semantic. I care about what it means to upkeep. For example, the previous CSS would look like this in HTML.

    :::html
	<div class="box-1 box-border">Lorem ipsum</div>
	<div class="box-2 box-border">Lorem ipsum</div>

The only way to make objects in plain CSS is to define non-semantic classes. However, this comes with some problems:

- We have to change our HTML almost every time we need to changes styles.
- There's not a safe way to access some of the DOM elements.

Besides the unmaintainable HTML, everything else about OOCSS is just great. Our CSS code is scalable and easy to mantain and reusing our abstract classes makes it easy to style new content.

So we code the parts in CSS and **extend** them in HTML. Could it get any better?

##Sass comes into play
I'm sure you've heard about Sass' `@extend` directive and of course you know [how it works](/intermediate/understanding-placeholder-selectors).
So, thanks to placeholder selectors we can extend in Sass, creating semantic classes in CSS, solving our problem for HTML.

We must use placeholders as objects, and define classes formed only by merging them through `@extend`. This will result in an incredibly <abbr title="Don't Repeat Your">DRY</abbr> CSS code. Let's see an example:

    :::scss
	/* The bad way */
	a.twitter {
		min-width: 100px;
		padding: 1em;
		border-radius: 1em;
		background: #55acee
		color: #fff;
	}
	span.facebook {
		min-width: 100px;
		padding: 1em;
		border-radius: 1em;
		background: #3b5998;
		color: #fff;
	}

Applying all we've seen and using `@extend` to mix base objects we can get clean object-oriented CSS which is very easy to mantain and we don't have to change the HTML all the time.

    :::scss
	/* The best way */
	%button {
		min-width: 100px;
		padding: 1em;
		border-radius: 1em;
	}
	%twitter-background {
		color: #fff;
		background: #55acee;
	}
	%facebook-background {
		color: #fff;
		background: #3b5998;
	}

	.btn {
		&--twitter {
			@extend %button;
			@extend %twitter-background;
		}
		&--facebook {
			@extend %button;
			@extend %facebook-background;
		}
	}

This produces efficient code that we can use easily in our HTML:

    :::html
	<a href="#" class="btn--twitter">Twitter</a>
	<a href="#" class="btn--facebook">Facebook</a>

Pretty semantic, right? Sass has solved our problem. Remember: extend and collect non-semantic parts on Sass if you want to keep a semantic, easy to mantain HTML.

I like to call this **OOSass**, because it's a mixture between OOCSS and Sass and the objects are built on the Sass side. But of course, you don't have to use it. You can stick with regular OOCSS if you don't mind non-semantic HTML code. To each his own. How do you structure your CSS nowadays?
