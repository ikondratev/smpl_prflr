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
        raise ProfilerError "end of the block"
      end
    rescue StandardError => e
      puts "#{category} #{e.message}"
      printer = RubyProf::FlatPrinter.new(result)
      printer.print($stdout)
    end
  end
end
