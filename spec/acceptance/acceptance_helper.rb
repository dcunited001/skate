require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "steak"
require 'capybara/rspec'


# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

#OmniAuth.config.test_mode = true
#OmniAuth.config.add_mock(:facebook, {:user_info => {
#  :first_name => 'Facebook',
#  :last_name  => 'User',
#  :email      => 'facebook-user@example.com',
#}})

Capybara.javascript_driver = :webkit

RSpec.configure do |config|

# If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end


