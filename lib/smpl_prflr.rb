require 'ruby-prof'

class SmplPrflr
  class ProfilerError < StandardError; end
  class << self
    # Simple test app
    #
    # @return [String]
    # @example PONG
    def ping
      "PONG"
    end

    def profile(category: :common)
      result = RubyProf.profile do
        yield
      end

      printer = RubyProf::FlatPrinter.new(result)
      printer.print($stdout)
    end
  end
end
