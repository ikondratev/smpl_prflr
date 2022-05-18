require 'redis'

module SmplPrflr
  module Initializers
    module Base
      def initialize_base!
        host = ENV['HOST'] || SmplPrflr::Constants::HOST
        port = ENV['PORT'] || SmplPrflr::Constants::PORT
        db = ENV['DB'] || SmplPrflr::Constants::DB

        @redis = Redis.new(host: host, port: port, db: db)
      rescue StandardError => e
        raise SmplPrflr::LoadResourcesError.new, e.message
      end
    end
  end
end
