class App
  def call(env)
    request = Rack::Request.new(env)
    serve_request(request)
  end

  def serve_request(request)
    Router.new(request).route!
  end
end
