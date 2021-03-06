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
require 'smpl_prflr/initializers/base'
require 'smpl_prflr/constants'
require 'smpl_prflr/errors'

module SmplPrflr
  include SmplPrflr::Initializers::Base

  # Init Profiler
  #
  # Init Redis
  # @raise [ProfilerError]
  def initialize_profiler!
    initialize_base!
  rescue  SmplPrflr::Error => e
    raise SmplPrflr::ClassProfilerError, e.message
  end

  # @example PONG
  # @return [String] PONG
  def ping
    "PONG"
  end

  # Profile block of your code
  # @return [nil]
  # @raise ProfilerError
  def p
    result = RubyProf.profile do
      yield
    end

    output = String.new
    printer = RubyProf::FlatPrinter.new(result)
    printer.print(output, min_percent: 0)
    @redis.set(:profile, output)

    nil
  rescue SmplPrflr::Error => e
    raise SmplPrflr::ClassProfilerError.new, e.message
  end
end
