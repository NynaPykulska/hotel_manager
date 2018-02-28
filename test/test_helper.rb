require 'coveralls'
Coveralls.wear!('rails')
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'

class ActionDispatch::IntegrationTest
  # Include helpers from Devise to sub logged in users
  include Devise::Test::IntegrationHelpers

  # Set-up database cleaner
  require 'database_cleaner'
  DatabaseCleaner.strategy = :truncation

  # Reset sessions and driver between tests
  # Use super wherever this method is redefined in your individual test classes
  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end

class ActiveSupport::TestCase
  fixtures :all
end