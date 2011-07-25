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
use Rack::Codehighlighter, :pygments, :element => "pre", :pattern => /\A:::(\w+)\s*\n/, :logging => false

# Nice looking 404s and other messages
use Rack::ShowStatus

# Nice looking errors
use Rack::ShowExceptions

# Nesta
require 'nesta/app'
Nesta::App.root = root
run Nesta::App
