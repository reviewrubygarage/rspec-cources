require 'simplecov'
require 'pry'
SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage 93
end

Dir[Dir.pwd + "/lib/**/*.rb"].each { |f| require f }
Dir[Dir.pwd + "/spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include ConsoleHelper, goodbye_only: true
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
