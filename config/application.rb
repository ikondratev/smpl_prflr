# frozen_string_literal: true

# require gems
require 'bundler'

Bundler.require(:default, ENV["RACK_ENV"] || "development")

# require application
require_all "app"
