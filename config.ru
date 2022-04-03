require_relative "config/application"
require_all "./config/app"

run Rack::URLMap.new('/' => Rack::Builder.new { run App.new })