class ApplicationController < ActionController::API
  include JsonConcern
  JSON_EXCLUDE = %i( id slug atmosphereable_id atmosphereable_type created_at updated_at )

  def render_not_found
    render json: { status: 404, error: 'Not Found' }, status: 404
  end
end
