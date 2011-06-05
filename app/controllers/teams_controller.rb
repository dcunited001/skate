
# TEAMS CONTROLLER ======================
# TODO: Teams/index shows map where you select team
# TODO: teams/details/:id updates ajax panel with rink details
# TODO: Teams/show either update div below with ajax or open a new tab with rink profile
# TODO: teams/show show team info, allow users to pust comments
# TODO: add team description
# TODO: Protect Manage_Members action


class TeamsController < ApplicationController
  before_filter :authenticate_member!

  before_filter :get_team_for_manage, :only => [:manage, :edit, :update, :kick_off]
  filter_access_to :manage, :edit, :update, :kick_off, :attribute_check => true

  # GET /teams
  # GET /teams.xml
  def index
    @teams = Team.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.xml
  def show
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.xml
  def new
    @team = Team.new
    @team.address = Address.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
    @team.address = Address.new unless @team.address
  end

  # POST /teams
  # POST /teams.xml
  def create
    @team = Team.new(params[:team])

    @team.owner = current_member
    @team.rink = current_member.rink

    #now create the team member association for the owner
    team_member = TeamMember.new
    team_member.member = current_member
    team_member.requestor = current_member
    team_member.approved = 1
    team_member.active = 1
    team_member.join_date = DateTime.now  #this will be set when a request is approved later
    @team.team_members << team_member

    #NEED TO GRANT TEAM MEMBER ROLE TO OWNER
    # TODO: add polymorphism

    success = false
    Team.transaction do
      role = Role.find_by_name("team_owner")
      role_member = RoleMember.new_of_type 'Team'
      role_member.role = role
      role_member.member = current_member

      @team.role_members << role_member
      @team.save

      success = true
    end

#    success = false
#    if @team.valid? @team_member.valid?
#      Team.transaction do
#        @team.save
#        @team_member.save
#
#        success = true
#      end
#    end

    respond_to do |format|
      if success
        format.html { redirect_to(@team, :notice => 'Team was successfully created.') }
        format.xml  { render :xml => @team, :status => :created, :location => @team }
      else
        format.html { render :controller => 'teams', :action => "new" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.xml
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to(@team, :notice => 'Team was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.xml
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    #TODO: Delete Team: REMOVE TEAM MEMBER ROLE TO OWNER

    respond_to do |format|
      format.html { redirect_to(teams_url) }
      format.xml  { head :ok }
    end
  end

  #========================================
  #  Team Management
  #========================================

  def manage
    @team = current_member.team

    @team_members = @team.team_members.current
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def requests
    @team = current_member.team

    @recd_team_requests = @team.
        pending_recd_team_requests
    @sent_member_requests = @team.
        pending_sent_team_requests

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  #params[:id] = member
  def kick_off
    @member = Member.find(params[:id])
    @tm = @member.team_members.first

    @tm.active = 0
    @tm.kickoff_date = DateTime.now

    @success = @tm.save(:validate => false)

    if @success
      @member.role_members.where("roleable_type = 'Team'").destroy_all
    end

    respond_to do |format|
      format.js
    end
  end

  #========================================
  #  Other Actions
  #========================================

  #params[:id] = the rinks id
  def set_home_rink
    
  end

  protected
  def get_team_for_manage
    @team = current_member.team
    
    @team = Team.new if @team.nil?
  end
end
