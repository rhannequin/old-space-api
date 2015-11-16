namespace :parser do
  def planets
    %i( mercury venus earth mars jupiter saturn uranus neptune pluto ).map do |planet|
      "http://solarsystem.nasa.gov/json/page-json.cfm?URLPath=planets/#{planet}/facts"
    end
  end

  desc 'Initialize database with static data'
  task all: :environment do
    Rake.application.invoke_task('parser:planets')
  end

  desc 'Parse all planets from the Solar System'
  task :planets do
    ParsePlanets.new.all
  end
end
