namespace :parser do
  def config
    {
      proxy: {
        proxy_use: ENV['PROXY_USE'],
        proxy_host: ENV['PROXY_HOST'],
        proxy_port: ENV['PROXY_PORT'],
        proxy_user: ENV['PROXY_USER'],
        proxy_password: ENV['PROXY_PASSWORD'],
      }
    }
  end

  desc 'Initialize database with static data'
  task all: :environment do
    Rake.application.invoke_task('parser:planets')
  end

  desc 'Parse all planets from the Solar System'
  task :planets do
    puts 'I am going to parse planets data.'
    ParsePlanets.new(config).all
  end
end
