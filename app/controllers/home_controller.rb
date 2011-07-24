class HomeController < ActionController::Base
  before_filter :authenticate_member!

  def index

  end

  def features

  end

end