require "capybara/rspec"
require 'capybara/webkit'

# use the following web driver to run tests
Capybara.javascript_driver = :webkit

Capybara::Webkit.configure do |config|
  config.allow_unknown_urls
end

RSpec.configure do |config|
  config.include Capybara::DSL
end
