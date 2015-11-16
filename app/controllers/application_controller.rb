class ApplicationController < ActionController::API
  def render_not_found
    render json: { status: 404, error: 'Not Found' }, status: 404
  end
end
