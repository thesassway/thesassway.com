---
date: 14 September 2050
categories: news
author: Adam Stacoviak
summary: For the Sass Veterans out there, I can imagine a big'ol smile appeared on your face when you read that headline. If you know the power of mixins, then you can imagine being able to pass a block of Sass to a mixin and watch the magic happen. We're going to look at the history of this feature and a few examples of how it can be used.
---

# New Sass Feature: Passing content blocks to mixins

For the Sass veterans out there, I can just imagine a big'ol smile appeared on your face when you read that headline. If you know the power of mixins, then you can imagine being able to pass a block of Sass to a mixin and watch the magic happen. We're going to look at the history of this feature and a few examples of how it can be used.

## First, the history of this feature

Support for passing children to mixins ...

https://github.com/nex3/sass/pull/167#issuecomment-2065825
Here's a gist where I first explored this concept. some of the comments there might be relevant: https://gist.github.com/407318
https://gist.github.com/407318#comments

In particular, @hagenburger suggested using @content instead of @children.

I like @content but I'm worried that it might get used by the w3c someday.

---

https://github.com/nex3/sass/pull/167
https://gist.github.com/407318#comments
https://gist.github.com/1215856
