require 'rspec'
require 'pry'
require 'factory_bot'
require 'database_cleaner'

require './config/app_config'
require './app/messages/responder.rb'
Dir['../app/messages/*.rb'].each {|file| require file }
ENV['RACK_ENV'] ||= 'test'

Dir['./spec/support/**/*.rb'].each { |f| require f }

config = AppConfig.new
config.configure

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.disable_monkey_patching!
  config.warnings = true
  if config.files_to_run.one?
    config.default_formatter = "doc"
  end
  config.order = :random
end
