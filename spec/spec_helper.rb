# we need to tell Rack (remember what Rack is?) that we are just testing.
# normally this is 'development'
ENV['RACK_ENV'] = 'test'

# require testing gems
require 'rspec'
require 'rack/test'

OUTER_APP = Rack::Builder.parse_file('config.ru').first

module SpecHelper
  include Rack::Test::Methods  
  # Rack::Test looks for this app variable
  def app() 
    OUTER_APP
  end 
end