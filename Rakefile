require 'rake/clean'
require 'rake/testtask'
require 'mongoid'

task default: :test

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/**/*_test.rb']
  t.warning = false
end


desc 'Create all models with default fixed values'
namespace :db do

  require_relative 'require_models'

  task :prepare do
    Mongoid.load!('mongoid.yml')
    Sun.prepare
    Moon.prepare
    Mercury.prepare
    Venus.prepare
    Mars.prepare
    Jupiter.prepare
    Saturn.prepare
  end
end