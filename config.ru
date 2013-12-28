require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

# The project root directory
root = ::File.dirname(__FILE__)

# Compile Sass on the fly with the Sass plugin. Some production environments
# don't allow you to write to the file system on the fly (like Heroku).
# Remove this conditional if you want to compile Sass in production.
#
# if ENV['RACK_ENV'] != 'production'
#   require 'sass'
#   require 'sass/plugin/rack'
#   require 'compass'
# 
#   Compass.add_project_configuration(root + '/config.rb')
#   Compass.configure_sass_plugin!
# 
#   use Sass::Plugin::Rack  # Sass Middleware
# end

run Middleman.server
