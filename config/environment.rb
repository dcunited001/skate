# Load the rails application
require File.expand_path('../application', __FILE__)
require File.expand_path('../../lib/devise_names', __FILE__)

# Load the Sinatra GuestApp
require File.expand_path('../../lib/guest/guest_app', __FILE__)

# Load the SqlLoader Module to help create extra SQL objects
require File.expand_path('../../db/sql_loader', __FILE__)

# Initialize the rails application
Sk8::Application.initialize!