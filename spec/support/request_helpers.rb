module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end

    def excluded_keys
      %w( id slug created_at updated_at )
    end
  end
end
