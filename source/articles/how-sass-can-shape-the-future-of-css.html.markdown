---
date: 2011-11-20 20:00:00 -0600
categories: articles, peter-gasston
author: Peter Gasston
summary: The rise in popularity of CSS extensions, such as Sass, in recent years has not gone unnoticed by the people who work on proposing and standardizing modules for CSS3 (and CSS4).
---

# How Sass Can Shape The Future of CSS

The rise in popularity of CSS extensions, such as Sass, in recent years has not gone unnoticed by the people who work on proposing and standardizing modules for CSS3 (and CSS4).

## Sass Features Being Adapted for Submission

Many of the key features found in Sass are being adapted for submission to the W3C. [Variables, Mixins, and Nesting are all mooted for inclusion in CSS](http://www.xanthir.com/blog/b49w0), and we may see some of them appear in the near future.

Then again, we may not; resistance to the proposals is quite strong from certain members - for example, [Bert Bos](http://www.w3.org/People/Bos/) wrote a long article on [why he considers CSS Variables to be harmful](http://www.w3.org/People/Bos/CSS-variables). But I thought it would be interesting for the Sass community to see how the software to which you develop and contribute to (Sass) is being used to discuss the future of the web.

## The Variables Proposal

This proposal should look very familiar to you - it's the same syntax that Sass uses, with one addition. Each variable is defined using a three-part syntax: first you set up the declaration using the `@var` at-rule, then you provide a unique name with the `$` character before it, then you set the value:

    :::css
    @var $foo #F00;

Once set up like this, you can reference your variable by using the unique name as a value:

    :::css
    h1 { color: $foo; }

[This proposal has already been put forward to the W3C](http://www.xanthir.com/blog/b4AD0), and I'll tell you the result of that shortly.

## The Mixins Proposal

As with Variables, you should be very familiar with the Mixins proposal - the syntax used in Sass was the inspiration. You create a declaration block using the @mixin at-rule, assign a unique id, and then add your rules:

    :::scss
    @mixin foo { color: #F00; font-weight: bold; }

When you need to use that code block you call it using the @mix directive and the unique id you previously assigned:

    :::css
    h1 { font-size: 2em; @mix foo; }

As you can see, the only difference is that the CSS proposal uses `@mix` in place of Sass's `@include`. As with Sass, you can also use parameters with Mixins:

    :::css
    @mixin foo($bar #F00) {
      border-color: $bar;
      color: $bar;
    }
    h1 {
      @mix foo(#00F);
    }

## An Alternative Variables Syntax

Recently, [an alternative syntax for Variables has been proposed](http://lists.w3.org/Archives/Public/www-style/2011Oct/0699.html). This syntax looks and acts somewhat similarly to the HTML data attribute, although it's not the same. In this proposal variables are scoped to elements (for global scope, you'd use the `:root` selector) and the variable name is prefixed with `data-`:

    :::css
    :root {
      data-foo: #F00;
    }

Then you reference the variable by using the unique name in the data function:

    :::css
    h1 {
      color: data(foo);
    }

This has the advantage of allowing scoped variables, and integrating better with the [CSSOM](http://dev.w3.org/csswg/cssom/), JavaScript, as well as inspector tools like [Firebug](http://getfirebug.com/) or [Dragonfly](http://www.opera.com/dragonfly/).

**It must be stressed**, however, that this is **still only** at the discussion stage.

### So When Will We See Them?

As I said, maybe never. As I understand it, the first Variables proposal was not well received by the W3C - but the module author, [Tab Atkins](https://twitter.com/#!/tabatkins), is continuing to refine it anyway. Tab is also key to the creation of the alternative syntax. You can follow along with Tab and his writing at [his personal blog](http://www.xanthir.com/blog/) where he shares his thoughts on web standards as well as details surrounding discussions on the future of CSS.

As for Mixins, they were rejected out of hand and probably won't be pursued. The reason given? Lack of use cases. But I can't imagine that you, as Sass creators, developers and users are short of use cases for Mixins. So, if you have them I'd love to read them - please leave a comment below sharing your thoughts if that's the case.

If work does continue on these proposals, or any part of them, I think that it would be *a matter of little time* before browsers started to implement them; I believe, in fact, that [WebKit](http://www.webkit.org/) already implemented Variables, only to remove them after feedback from the [W3C](http://www.w3.org/).

## Conclusion

I have to confess that I've only briefly experimented with Sass, and have not used it in any production websites, but what I like about it is the ease with which it's been possible to adapt the syntax into CSS itself. It's great to see community-created language extensions influence the evolution of the web, and even if none of these proposals ever make it to the implementation stage, you can be sure that ***at the very least*** they form part of the standards conversation.

## Links

* [CSSOM, Vars, Mixins, Nesting, and Modules](http://www.xanthir.com/blog/b49w0)
* [Why “variables” in CSS are harmful](http://www.w3.org/People/Bos/CSS-variables)
* [CSS Variables Draft](http://www.xanthir.com/blog/b4AD0)
* [Better Variables through Custom Properties from Tab Atkins Jr. on 2011-10-24](http://lists.w3.org/Archives/Public/www-style/2011Oct/0699.html)
