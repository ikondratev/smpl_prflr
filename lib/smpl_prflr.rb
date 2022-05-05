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
require "figaro"
require 'ruby-prof'
require 'redis'
require 'smpl_prflr/constants'

module SmplPrflr
  class ProfilerError < StandardError; end

  # @author KILYA
  # Init logger
  #
  # Init Profiler
  #
  # Load env
  #
  # Init Redis
  # @raise [ProfilerError]
  def initialize_profiler!(mod = :development)
    path = File.expand_path(
      Constants::MODES[mod.to_sym]
    )
    Figaro.application = Figaro::Application.new(
      environment: mod.to_sym,
      path: path
    )
    Figaro.load

    @logger = Logger.new($stdout)
    @redis = Redis.new(
      host: Figaro.env.host || SmplPrflr::Constants::HOST,
      port: Figaro.env.port || SmplPrflr::Constants::PORT,
      db: Figaro.env.db || SmplPrflr::Constants::DB
    )
  rescue StandardError => e
    raise ProfilerError.new e.message
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
    result = RubyProf.profile do
      yield
    end

    output = String.new
    printer = RubyProf::FlatPrinter.new(result)
    printer.print(output, min_percent: 0)
    @redis.set(:profile, output)

    nil
  rescue StandardError => e
    @logger.error e.message.to_s
  end
end
