namespace :parser do
  desc 'Initialize database with static data'
  task all: :environment do
    Rake.application.invoke_task('parser:planets:drop')
    Rake.application.invoke_task('parser:planets:fetch')
  end

  namespace :planets do
    desc 'Drop every Planet objetcs'
    task drop: :environment do
      Planet.destroy_all
      AtmEl.destroy_all
    end

    desc 'Parse all planets from the Solar System'
    task fetch: :environment do
      Api::V1::Parser::Planets::ParsePlanets.new.all
    end
  end
end
