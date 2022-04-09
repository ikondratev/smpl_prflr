require 'figaro'
require 'env/constants'

module Env
  class Loading
    def initialize(app_mode: :development)
      path = Env::Constants::MODES[app_mode]
      Figaro.application = Figaro::Application.new(environment: app_mode, path: path)
      Figaro.load
    end

    def store(value:)
      Figaro.env.send(value)
    end
  end
end
