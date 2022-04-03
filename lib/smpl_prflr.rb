require 'ruby-prof'
require 'redis'

class SmplPrflr
  class ProfilerError < StandardError; end
  DEFAULT_HOST = "127.0.0.1".freeze

  # @author KILYA
  # @param [String] host
  # @param [Integer] port
  # @param [Integer] db
  # @example self.new(host: "http:/your.path", port: 555, db:1)
  def initialize(host: DEFAULT_HOST, port: 6379, db: 15)
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
  # @param [String] category, default :common
  # Its your own label for redis
  def p(category)
    profiled = ""
    result = RubyProf.profile do
      yield
    end

    printer = RubyProf::GraphHtmlPrinter.new(result)
    printer.print(profiled, min_percent: 0)
    @redis.set(category, line)

    nil
  rescue StandardError => e
    raise ProfileError.new e.message
  end
end
