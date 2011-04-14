#$:.unshift File.expand_path('..', __FILE__)
#$:.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'collective_intelligence'

# # Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__),'/support/**/*.rb')].each {|f| require f}

Rspec.configure do |config|
  config.mock_with :rspec
end