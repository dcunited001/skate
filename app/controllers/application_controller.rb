class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :determine_layout

  private

  def determine_layout
    current_member ? 'home' : 'guest'
  end

end
