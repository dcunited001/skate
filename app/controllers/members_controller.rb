# MEMBERS CONTROLLER ====================
# TODO: members/show: manage profile/team status
# TODO: members/editinfo: manage public info
# TODO: add ability for members to update their profile
# TODO: member search
# TODO: create member search view
# TODO: create member profile view
# TODO: create edit profile view

class MembersController < ApplicationController
  def index
    @members = Member.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @members }
    end
  end

  def show
    @member = Member.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @member }
    end
  end

  #========================================
  #  Search Actions
  #========================================
  def search

  end

  def auto_search

  end
  
  #========================================
  #  Maps Actions ???
  #========================================


  #========================================
  #  Other Actions
  #========================================
  def set_home_rink
    @rink = Rink.find(params[:id])

    @member = current_member
    @member.rink = @rink
    @member.save

    #necessary??
    respond_to do |format|
      format.html {redirect_to :back, :notice => 'Successfully Updated Home Rink'}
      # format.js  TODO: change this to an ajax request
    end
  end

  def quit_team
    @success = false
    if !current_member.owned_team
      @team = current_member.team

      @tm = current_member.team_members.first

      @tm.active = 0
      @tm.quit_date = DateTime.now

      @success = @tm.save(:validate => false)

      if @success
        current_member.role_members.where("roleable_type = 'Team'").destroy_all
      end
    end

    respond_to do |format|
      format.js
    end
  end
end

