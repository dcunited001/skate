

# ADMIN CONTROLLER ======================
# TODO: action: manage config
# TODO: admin/approles: manage approles
# TODO: action:


class AdminController < ApplicationController
  before_filter :authenticate_member!
  filter_access_to :all

  def index
    
  end

  #list user roles
  def set_roles

    #eager load all the members role_members

    @members = Member.all
    @roles = Role.all
  end
end
