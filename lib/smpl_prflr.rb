class SmplPrflr
  class << self
    def ping
      "pong"
    end

    def safe(category: :common)
      yield
    rescue StandardError => e
      puts "#{category} #{e.message}"
    end
  end
end
