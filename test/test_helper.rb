require 'simplecov'
SimpleCov.start 'rails' do
  add_filter "lib/"
  add_filter "lib/exceptions.rb"
  # add_filter "app/controllers/api/"
  # add_filter "app/controllers/api_controller.rb"
  # add_filter "app/serializers/"
  # add_filter "app/models/"
  add_filter "app/helpers/"
  add_filter "app/channels/application_cable/"
  add_filter "app/jobs/"
  add_filter "app/mailers/"
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest"
require 'minitest/rails'
require 'minitest/reporters'
require 'minitest_extensions'
require 'contexts'
# require 'logins'

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  include Contexts
  # include Logins

  # Add the infamous deny method...
  def deny(condition, msg="")
    # a simple transformation to increase readability IMO
    assert !condition, msg
  end

  # Spruce up minitest results...
  Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end
