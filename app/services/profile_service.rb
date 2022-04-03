module Services
  class ProfileService
    def initialize
      @redis = Redis.new(
        host: "127.0.0.1",
        port: 6379,
        db: 15
      )
    end

    def load_profile
      @redis.get(:tost)
    end
  end
end
