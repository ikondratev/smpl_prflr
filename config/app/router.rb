class Router
  def initialize(request)
    @request = request
  end

  def route!
    return controller.not_found unless @request.get?

    case @request.path
    when "/ping"
      controller.ping
    when "/profile"
      controller.profile
    else
      controller.not_found
    end
  end

  private

  def controller
    @controller ||= ServicesController.new(@request)
  end

  def params
    JSON.parse(@request.body.read)
  end
end
