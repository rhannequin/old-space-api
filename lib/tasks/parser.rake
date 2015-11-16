namespace :parser do
  def planets
    %i( mercury venus earth mars jupiter saturn uranus neptune pluto ).map do |planet|
      "http://solarsystem.nasa.gov/json/page-json.cfm?URLPath=planets/#{planet}/facts"
    end
  end

  desc 'Initialize database with static data'
  task all: :environment do
    Rake.application.invoke_task('parser:planets:drop')
    Rake.application.invoke_task('parser:planets:fetch')
  end

  namespace :planets do
    desc 'Drop every Planet objetcs'
    task drop: :environment do
      Planet.destroy_all
    end

    desc 'Parse all planets from the Solar System'
    task fetch: :environment do
      ParsePlanets.new.all
    end
  end
end
