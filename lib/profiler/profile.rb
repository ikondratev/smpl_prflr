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

module Profiler
  class Profile
    class ProfilerError < StandardError; end

    # @author KILYA
    # Initialise redis
    def initialize(env)
      @redis = Redis.new(
        host: env.store(value: "host") || "127.0.0.1",
        port: env.store(value: "port").to_i || 6379,
        db: env.store(value: "db").to_i || 15
      )
    end

    # @author KILYA
    # main point
    def start
      output = String.new
      result = RubyProf.profile do
        yield
      end

      printer = RubyProf::FlatPrinter.new(result)
      printer.print(output, min_percent: 0)
      @redis.set(:profile, output)

      nil
    rescue StandardError => e
      raise ProfilerError.new e.message.to_s
    end
  end
end
