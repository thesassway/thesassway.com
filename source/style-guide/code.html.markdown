# Style Guide: Code

## CSS

    :::css
    /* Button link */
    a.button {
      font-family: Helvetica, "MS Sans Serif", Arial, san-serif;
      background: black;
      color: white;
      padding: 3px;
      border-radius: 5px;
    }

## SCSS

    :::scss
    // Simple button mixin
    @mixin border-radius($radius) {
      border-radius: $radius;
      -webkit-border-radius: $radius;
      -moz-border-radius: $radius;
    }

    /* Button link */
    a.button {
      font-family: Helvetica, "MS Sans Serif", Arial, san-serif;
      background: black;
      color: white;
      padding: 3px;
      @include border-radius(5px);
    }

## Sass

    :::sass
    // Simple button mixin
    @mixin border-radius($radius)
      border-radius: $radius
      -webkit-border-radius: $radius
      -moz-border-radius: $radius

    /* Button link
    a.button
      font-family: Helvetica, "MS Sans Serif", Arial, san-serif
      background: black
      color: white
      padding: 3px
      +border-radius(5px)

## HTML

    :::html
    <!DOCTYPE html>
    <html>
      <head>
        <title>An HTML Document</title>
      </head>
      <body>
        <div class="banner">
          <img src="logo.png" width=120 height=60 />
        </div>
        <!-- content start -->
        <h1>Example</h1>
        <p>This is an example HTML document.</p>
        <!-- content end -->
      </body>
    </html>

## Ruby

    :::ruby
    class Greeter < Object
      def greet(name)
        puts "Hello #{name}!"
      end
    end
    g = Greeter.new
    g.greet('World') #=> "Hello World!"

## Javascript

    :::javascript
    // Hello World example
    function greet(name) {
      var greeting = 'Hello';
      alert(greeting + ' ' + name '!');
    }
    greet('World');

## Bash

    :::bash
    $ gem install serve
    Fetching: rack-1.3.1.gem (100%)
    Fetching: rack-test-0.6.0.gem (100%)
    Fetching: tilt-1.3.2.gem (100%)
    Fetching: activesupport-3.0.9.gem (100%)
    Fetching: tzinfo-0.3.29.gem (100%)
    Fetching: i18n-0.6.0.gem (100%)
    Fetching: serve-1.5.1.gem (100%)
    ...

    $ serve create my-project
          create  my-project
          create  my-project/public
          create  my-project/tmp
          create  my-project/views
          create  my-project/Gemfile
          create  my-project/config.ru
          create  my-project/.gitignore
          create  my-project/compass.config
          create  my-project/public/images
          create  my-project/public/javascripts

## SQL

    :::sql
    SELECT sql FROM
       (SELECT * FROM sqlite_master UNION ALL
        SELECT * FROM sqlite_temp_master)
    WHERE type!='meta'
    ORDER BY tbl_name, type DESC, name
