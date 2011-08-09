class MembersController < ApplicationController
  before_filter :authenticate_member!

  def index
    @members = Member.where("id != ?", current_member.id)
  end

  def show
    if (params[:id] =~ /^[0-9]+/)
      @member = Member.find_by_id(params[:id])
    else
      @member = Member.find_by_alias(params[:id])
    end
  end

  def delete
  end

  def destroy
  end
end
