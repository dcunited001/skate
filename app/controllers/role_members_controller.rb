
class RoleMembersController < ApplicationController
  before_filter :authenticate_member!
  filter_access_to :toggle
  
  def toggle
    @role = Role.find(params[:role])
    @member = Member.find(params[:member])

    @already_has_role = @member.roles.include? @role

    if @already_has_role
      @role_member = @member.role_members.select{|r| r.role_id == @role.id}.first
      @role_member.destroy
    else
      @role_member = RoleMember.new_of_admin
      @role_member.role = @role

      @member.role_members << @role_member
    end

    respond_to do |format|
      format.js
    end
  end
end