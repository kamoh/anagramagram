ENV['SINATRA_ENV'] ||= "development"

require 'open-uri'
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/anagramagramv1_#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app'



# ENV['SINATRA_ENV'] ||= "development"

# require 'bundler/setup'
# Bundler.require(:default, ENV['SINATRA_ENV'])

# ActiveRecord::Base.establish_connection(
#   :adapter => "sqlite3",
#   :database => "db/complex_forms_#{ENV['SINATRA_ENV']}.sqlite"
# )

# require_all 'app'