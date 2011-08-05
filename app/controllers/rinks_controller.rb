class RinksController < ApplicationController
  before_filter :authenticate_member!

  def index
    @rinks = Rink.where(:visible => true)
  end

  def show
    @rink = Rink.find(params[:id])
  end

  def edit
  end

  def create
  end

  def update
  end

  def delete
  end

  def destroy
  end

end
