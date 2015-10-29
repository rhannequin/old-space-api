require 'rake/clean'
require 'rake/testtask'
require File.expand_path('../init_static', File.dirname(__FILE__))

desc 'Create all models with default fixed values'
namespace :db do
  task :prepare do
    DbPrepare.new.start
  end
end
