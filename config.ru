require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

# The project root directory
root = ::File.dirname(__FILE__)

# Code highlighting
require 'pygments'
require 'rack/codehighlighter'
use Rack::Codehighlighter, :pygments, :element => "pre>code", :markdown => true

# Cache control headers for Heroku
require 'rack/contrib'
use Rack::ResponseHeaders do |headers|
  headers['Cache-Control'] = 'public, max-age=1501'
end
use Rack::ETag

# Google analytics
require "rack/google_analytics"
use Rack::GoogleAnalytics, web_property_id: "UA-4556641-15"

# URL rewriting
require 'rack/rewrite'
use Rack::Rewrite do
  # Adam Stacoviak
  # rewrite '/adamstac',  '/adam-stacoviak'
  # r301 '/adam-stacoviak', '/adamstac'

  # Mario Ricalde
  r301 '/mario-kuroir-ricalde', '/mario-ricalde'
end

run Middleman.server
