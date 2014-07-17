ENV["SINATRA_ENV"] ||= "development"

require 'sinatra/activerecord/rake'
require_relative './config/environment'

# Type `rake -T` on your command line to see the available rake tasks.

namespace :db do
  desc 'add seed data' do
    task :seed => :environment do
      Rake::Task["db:seed"].invoke
    end
  end
end