# Load the rails application
require File.expand_path('../application', __FILE__)
require File.expand_path('../../lib/devise_names', __FILE__)
require File.expand_path('../../lib/guest/guest_app', __FILE__)

# Initialize the rails application
Sk8::Application.initialize!
