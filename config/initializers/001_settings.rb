# frozen_string_literal: true

require "config"

Config.setup do |config|
  config.const_name = "Settings"
  config.use_env = false
end

env = ::ActiveSupport::StringInquirer.new(ENV["RACK_ENV"] || "development")
path = Dir.pwd << ("/config")
Config.load_and_set_settings(Config.setting_files(path, env))

Settings.env = env
