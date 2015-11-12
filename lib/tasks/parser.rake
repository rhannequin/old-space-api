namespace :parser do
  def config
    { proxy: proxy, planets: planets }
  end

  def proxy
    {
      proxy_use: ENV['PROXY_USE'],
      proxy_host: ENV['PROXY_HOST'],
      proxy_port: ENV['PROXY_PORT'],
      proxy_user: ENV['PROXY_USER'],
      proxy_password: ENV['PROXY_PASSWORD'],
    }
  end

  def planets
    %i( mercury venus earth mars jupiter saturn uranus neptune pluto ).map do |planet|
      {
        name: planet,
        :uri => "http://solarsystem.nasa.gov/json/page-json.cfm?URLPath=planets/#{planet}/facts"
      }
    end
  end

  desc 'Initialize database with static data'
  task all: :environment do
    Rake.application.invoke_task('parser:planets')
  end

  desc 'Parse all planets from the Solar System'
  task :planets do
    ParsePlanets.new(config).all
  end
end
