---
date: 31 August 2019
categories: beginner, guides
author: Adam Stacoviak
summary: ...
---

# Compass setup and configuration

If you've read Getting [Started with Sass and Compass](http://localhost:9393/beginner/getting-started-with-sass-and-compass), you're ready to dive into the Compass configuration file to see how we can fine tune things to our needs and liking.

Starting a new Sass project and configuring Compass may seem like a daunting task unless you know what you're doing.

:::ruby
# Compass Configuration

require 'grid-coordinates'

# HTTP
http_path             = '/'

# Stylesheets
http_stylesheets_path = '/stylesheets'
css_dir               = 'public/stylesheets'
sass_dir              = 'sass'

# Images
http_images_path      = '/images'
images_dir            = 'public/images'

# JavaScripts
http_javascripts_path = '/javascripts'
javascripts_dir       = 'public/javascripts'

# Fonts
http_fonts_path = ''
http_fonts_dir = ''

# Setings
line_comments         = false
preferred_syntax      = :sass

# CSS output style :nested, :expanded, :compact, or :compressed
output_style          = :expanded

# Should asset helper functions generate relative or absolute paths
relative_assets       = true

# Quiet warnings
disable_warnings = true
sass_options = { Sass::Plugin.options[:quiet] = :true }

# Learn more: http://compass-style.org/docs/tutorials/configuration-reference/
