class ServicesController < BaseController
  def ping
    result = "PONG"
    build_response(result)
  end

  def profile
    result = @response.load_profile
    build_response(result)
  end
end
