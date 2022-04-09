module Env
  module Constants
    MODES = {
      production: "./config/production.yml",
      development: "./config/development.yml",
      test: "./config/test.yml"
    }.freeze
  end
end
