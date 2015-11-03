require 'rake/clean'
require 'rake/testtask'
require 'yaml'
require File.expand_path('../init_static', File.dirname(__FILE__))

desc 'Create all models with default fixed values'
namespace :db do
  task :prepare do
    environment = ENV['RACK_ENV'] || 'development'
    config = YAML.load_file File.expand_path('../config_file.yml', File.dirname(__FILE__))
    DbPrepare.new(config[environment]).start
  end
end
