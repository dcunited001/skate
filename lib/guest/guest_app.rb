class GuestApp < Sinatra::Base
  require 'haml'
  require File.dirname(__FILE__) + '/../devise_names'

  enable :method_override

  set :views, File.dirname(__FILE__) + '/views'
  set :haml, :format => :html5

  get '/' do
    haml :index
  end

  get '/features' do
    haml :features
  end

  get '/mission' do
    haml :mission
  end

  get '/about' do
    haml :about
  end

  get '/contact' do
    haml :contact
  end

  get '/style.css' do
    sass :style
  end

end

