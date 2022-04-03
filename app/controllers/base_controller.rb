class BaseController
  def initialize(request)
    @request = request
    @response = Services::ProfileService.new
  end

  def not_found
    build_response("not_found", status: 404)
  end

  private

  def build_response(body, status: 200)
    [status, { "Content-Type" => "text/json" }, [body]]
  end
end
