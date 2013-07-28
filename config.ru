require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

# The project root directory
root = ::File.dirname(__FILE__)

# Compile Sass on the fly with the Sass plugin. Some production environments
# don't allow you to write to the file system on the fly (like Heroku).
# Remove this conditional if you want to compile Sass in production.
if ENV['RACK_ENV'] != 'production'
  require 'sass'
  require 'sass/plugin/rack'
  require 'compass'

  Compass.add_project_configuration(root + '/config.rb')
  Compass.configure_sass_plugin!

  use Sass::Plugin::Rack  # Sass Middleware
end

# Code highlighting
require 'pygments'
require 'rack/codehighlighter'
use Rack::Codehighlighter, :pygments, :element => "pre>code", :markdown => true

# Nice looking 404s and other messages
use Rack::ShowStatus

# Nice looking errors
use Rack::ShowExceptions

# cache control headers for Heroku
require 'rack/contrib'
use Rack::ResponseHeaders do |headers|
  headers['Cache-Control'] = 'public, max-age=1501'
end
use Rack::ETag

# Nesta
require 'nesta/app'
Nesta::App.root = root
run Nesta::App

require 'rack/rewrite'
use Rack::Rewrite do
  # Adam Stacoviak
  # rewrite '/adamstac',  '/adam-stacoviak'
  # r301 '/adam-stacoviak', '/adamstac'

  # Mario Ricalde
  r301 '/mario-kuroir-ricalde', '/mario-ricalde'
end
