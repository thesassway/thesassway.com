require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require 'rack/codehighlighter'
use Rack::Codehighlighter, :pygments_api, :element => "pre", :pattern => /\A:::(\w+)\s*\n/, :logging => false

require 'nesta/app'
Nesta::App.root = ::File.expand_path('.', ::File.dirname(__FILE__))
run Nesta::App
