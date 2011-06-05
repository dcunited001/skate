# TEAM MEMBERS CONTROLLER ==============
# TODO: quit team action (remove role)
# TODO: kick member off action (remove role)

class TeamMembersController < ApplicationController
  before_filter :authenticate_member!
  before_filter :get_request_for_auth, :only => [:cancel_request, :approve_team_request, :deny_team_request]
  
  filter_access_to :cancel_request, :approve_team_request, :deny_team_request,
                   :attribute_check => true
  filter_access_to :all

  def index
    @sent_team_requests = current_member.
        pending_sent_team_requests.
        team_requests
    @recd_member_requests = current_member.
        pending_recd_team_requests.
        member_requests

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @request }
    end
  end

  def show
    @request = TeamMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @request }
    end
  end

  def team_request
    @request = TeamMember.new
    @team = Team.find(params[:id])
    already_on_team = current_member.teams.any?

    @message = ""
    if !already_on_team
      @request.requestor = current_member
      @request.member = current_member

      @request.team = @team

      @request.active = 0
      @request.approved = 0
    else
      @message = "You already skate for a team"
    end
    
    @success = @request.save

    respond_to do |format|
      format.js
    end
  end

  def member_request
    @request = TeamMember.new
    @member = Member.find(params[:id])
    already_on_team = @member.teams.any?

    @message = ""
    if current_member.owned_team and !already_on_team
      @request.requestor = current_member
      @request.member = @member

      @request.team = current_member.owned_team

      @request.active = 0
      @request.approved = 0
    else
      @message = "This Member already skates for a team"
    end

    @success = @request.save

    respond_to do |format|
      format.js
    end
  end

  def approve_request
    @request = TeamMember.find(params[:id])
    member = @request.member
    @team = @request.team

    @message = ""
    already_on_team = true
    if !member.nil? and @request.member == current_member
      already_on_team = member.teams.any?
    else
      @message = "Member not found"
    end

    @success = false
    role_member = RoleMember.new_of_type 'Team'
    if !already_on_team
      @request.approved = 1
      @request.active = 1
      @request.join_date = DateTime.now

      #add the team_member role to the member
      role = Role.find_by_name("team_member")
      role_member.role = role
      role_member.member = member
      role_member.roleable_id = @team.id

      @success = true
    else
      @message = "This member is already on a team."
    end

    if @success
      @success = @request.save(:validate => false)
      if @success
        member.role_members << role_member
      end
    else
      role_member.destroy
    end

    respond_to do |format|
      format.js
    end
  end

  def deny_request
    @request = TeamMember.find(params[:id])
    member = @request.member
    @team = @request.team

    is_this_members_request = false
    @message = ""
    if !member.nil? and @request.member == current_member
      is_this_members_request = true
    else
      @message = "Member not found"
    end

    if is_this_members_request
      @request.rejected = 1
      @request.join_date = DateTime.now
    else
      @message = "Not your request!!"
      #TODO: Log security violation information
    end

    @success = @request.save(:validate => false)

    respond_to do |format|
      format.js
    end
  end

  def cancel_request
    @request = @team_member
    @member = @request.member
    @team = @request.team

    @request.rejected = 1
    @request.join_date = DateTime.now

    @success = @request.save(:validate => false)

    respond_to do |format|
      format.js
    end
  end

  def approve_team_request
    @request = @team_member
    @member = @request.member
    @team = @request.team

    #check that the request belongs to the team that this member owns
    cur_mem_team = current_member.team
    team_check = false
    already_on_team = @member.teams.any?
    @message = ""
    if @team == cur_mem_team
      team_check = true
    else
      @message = "Not your team!!"
    end

    @success = false
    role_member = RoleMember.new_of_type 'Team'
    if team_check
      if !already_on_team
        @request.approved = 1
        @request.active = 1
        @request.join_date = DateTime.now

        #add the team_member role to the member
        role = Role.find_by_name("team_member")
        role_member.role = role
        role_member.member = @member
        role_member.roleable_id = @team.id

        @success = true
      else
        @message = "Member skates for another team"
      end
    end

    if @success
      @success = @request.save(:validate => false)
      if @success
        @member.role_members << role_member
      end
    else
      role_member.destroy
    end

    respond_to do |format|
      format.js
    end
  end

  def deny_team_request
    @request = @team_member
    @member = @request.member
    @team = @request.team

    cur_mem_team = current_member.team
    @message = ""
    if @team == cur_mem_team
      @request.rejected = 1
      @request.join_date = DateTime.now
    else
      @message = "Not your team!!"
      #TODO: Log security violation information
    end

    @success = @request.save(:validate => false)

    respond_to do |format|
      format.js
    end
  end

  #TODO: ONLY ALLOW FOR MEMBERS WHO SENT THE REQUEST
  def cancel_team_request
    @request = TeamMember.find(params[:id])
    member = @request.member
    @team = @request.team
    
    @request.rejected = 1
    @request.join_date = DateTime.now

    @success = @request.save(:validate => false)

    respond_to do |format|
      format.js
    end
  end

  def team_mates
    @team_mates = current_member.team_mates

    respond_to do |format|
      format.html
    end
  end

  def get_request_for_auth
    @team_member = TeamMember.find(params[:id])
    
    @team_member = TeamMember.new if @team_member.nil?
  end
end
