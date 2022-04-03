# frozen_string_literal: true

# require gems
require 'bundler'

Bundler.require(:default, ENV["RACK_ENV"] || "development")

# require additional gem files
require "active_support/all"

# initialize application, logger, gems, etc.
require_all "config/initializers"

# require application
require_all "app"
