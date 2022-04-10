# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright (c) 2019-2022 Kondratev Ilya
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'logger'
require "config"
require 'ruby-prof'
require 'redis'
require 'profiler/constants'
require 'active_support/all'

module SmplPrflr
  # @author KILYA
  # Init logger
  # Init Profiler
  # Load env
  # Init Redis
  def initialize_profiler!(mod: "development")
    Config.setup do |config|
      config.const_name = "Settings"
      config.use_env = false
    end

    env = ::ActiveSupport::StringInquirer.new(mod)
    path = Dir.pwd << ("/config")
    Config.load_and_set_settings(Config.setting_files(path, env))
    Settings.env = env

    @logger = Logger.new($stdout)
    @redis = Redis.new(
      host: Settings.HOST || Profiler::Constants::DEFAULT_HOST,
      port: Settings.PORT || Profiler::Constants::DEFAULT_PORT,
      db: Settings.DB || Profiler::Constants::DEFAULT_DB
    )
  end

  # @author KILYA
  # @example PONG
  # @return [String] PONG
  def ping
    "PONG"
  end

  # @author KILYA
  # Profile block of your code
  # @return [nil]
  def p
    output = String.new
    result = RubyProf.profile do
      yield
    end

    printer = RubyProf::FlatPrinter.new(result)
    printer.print(output, min_percent: 0)
    @redis.set(:profile, output)

    nil
  rescue StandardError => e
    @logger.error e.message.to_s
  end
end
