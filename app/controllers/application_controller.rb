class ApplicationController < ActionController::Base
  #before_filter :set_current_user

  before_filter { |c| Authorization.current_user = c.current_member }
  before_filter :instantiate_controller_and_action_names
  protect_from_forgery


#  protected
#  def set_current_user
#    Authorization.current_user = current_member
#  end

  def current_user
    current_member if current_member
  end

private

  def instantiate_controller_and_action_names
      @current_action = action_name
      @current_controller = controller_name
  end

end
