#require 'rbconfig'
#require File.expand_path('../support/refinery/controller_macros', __FILE__)

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  #config.use_instantiated_fixtures  = false

  config.include ::Devise::TestHelpers, :type => :controller

  #email spec helpers
  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)

  config.before(:all) do
    #create the appropriate SQL Views/Rules/Etc
    SqlLoader::SqlLoaderBase.create_all
  end

  config.after(:all) do
    #drop the SQL Views/Rules/Etc
    SqlLoader::SqlLoaderBase.drop_all
  end
end


