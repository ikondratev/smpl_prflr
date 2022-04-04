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

require 'ruby-prof'
require 'redis'
require 'logger'

class SmplPrflr
  class ProfilerError < StandardError; end

  # @author KILYA
  # @param [String] host
  # @param [Integer] port
  # @param [Integer] db
  # @example self.new(host: "http:/your.path", port: 555, db:1)
  def initialize(host: "127.0.0.1", port: 6379, db: 15)
    @logger = Logger.new($stdout)
    @redis = Redis.new(
      host: host,
      port: port,
      db: db
    )
  end

  # @author KILYA
  # @param nil
  #
  # @example PONG
  # @return [String] PONG
  def self.ping
    "PONG"
  end

  # @author KILYA
  # Profile block of your code
  # @return [nil]
  def p(prof: "")
    result = RubyProf.profile do
      yield
    end

    printer = RubyProf::FlatPrinter.new(result)
    printer.print(prof, min_percent: 0)
    @redis.set(:profile, prof)

    nil
  rescue StandardError => e
    @logger.error(e.message.to_s)
  end
end
