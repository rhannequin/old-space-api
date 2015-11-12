namespace :parser do
  desc 'Initialize database with static data'
  task all: :environment do
    Rake.application.invoke_task('parser:planets')
  end

  desc 'Parse all planets from the Solar System'
  task :planets do
    puts 'I am going to parse planets data.'
  end
end
