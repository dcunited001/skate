class MembersController < ApplicationController
  before_filter :authenticate_member!

  def index
    @members = Member.where("id != ?", current_member.id)
  end

  def show
    @member = Member.find_by_id(params[:id])
  end

  def edit
  end

  def delete
  end

  def create
  end

  def update
  end

  def destroy
  end
end
