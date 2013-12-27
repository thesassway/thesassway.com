---
date: 28 August 2011
categories: projects, adam-stacoviak
author: Adam Stacoviak
summary: Twitter's "Twitter Bootstrap" is a HOT topic, especially in the Sass community, namely because they used LESS instead of Sass. Well, fellow staff member John w. Long changed that with Sass Twitter Bootstrap.
---

# Sass Twitter Bootstrap

Twitter's "Bootstrap" is a HOT topic, especially in the Sass community. Sadly, they used LESS instead of Sass. Well, fellow staff member John W. Long changed that with [Sass Twitter Bootstrap](https://github.com/jlong/sass-twitter-bootstrap).

## bootstrap.scss

Thanks [John](http://wiseheartdesign.com/) for stepping out and porting this for all of us Sass-lovers to enjoy!

    :::scss
    /*!
     * Bootstrap v1.1.0
     *
     * Copyright 2011 Twitter, Inc
     * Licensed under the Apache License v2.0
     * http://www.apache.org/licenses/LICENSE-2.0
     *
     * Designed and built with all the love in the world @twitter by @mdo and @fat.
     *
     * Converted to Sass by @johnwlong.
     *
     * Date: @DATE
     */

    // CSS Reset
    @import "reset.scss";

    // Core
    @import "preboot.scss";
    @import "scaffolding.scss";

    // Styled patterns and elements
    @import "type.scss";
    @import "forms.scss";
    @import "tables.scss";
    @import "patterns.scss";

## Links

* [[Sass Twitter Bootstrap on GitHub](https://github.com/jlong/sass-twitter-bootstrap)]
* [[Contributors to Sass Twitter Bootstrap ](https://github.com/jlong/sass-twitter-bootstrap/contributors)