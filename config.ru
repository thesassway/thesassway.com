require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require 'pygments'
require 'rack/codehighlighter'
use Rack::Codehighlighter, :pygments, :element => "pre", :pattern => /\A:::(\w+)\s*\n/, :logging => false

require 'nesta/app'
Nesta::App.root = ::File.expand_path('.', ::File.dirname(__FILE__))
run Nesta::App
