module JsonConcern
  extend ActiveSupport::Concern

  def json_reponse(obj)
    obj = pretty(obj) unless avoid_pretty_json
    { json: obj }
  end

  def avoid_pretty_json
    params[:pretty] && params[:pretty] == 'false'
  end

  def pretty(json)
    JSON.pretty_generate(JSON.parse(json))
  end
end
