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
require 'profiler/profile'
require 'env/loading'

module SmplPrflr
  # @author KILYA
  # Init logger
  # Init Profiler
  def initialize_profiler!(mod: :development)
    env = Env::Loading.new(app_mode: mod)
    @logger = Logger.new($stdout)
    @profiler = Profiler::Profile.new(env)
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
    @profiler.start do
      yield
    end
  rescue Profiler::ProfilerError => e
    @logger.error(e.message.to_s)
  end
end
