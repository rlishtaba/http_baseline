require 'bundler/setup'
require 'yaml'

$:.unshift File.expand_path('../', File.dirname(__FILE__))

require 'http_baseline'

Dir[File.expand_path('support/**/*.rb', File.dirname(__FILE__))].each do |file|
  require file if File.file?(file)
end

RSpec.configure do |config|
  config.color     = true
  config.formatter = :documentation
  config.include Fixtures
end

include Fixtures