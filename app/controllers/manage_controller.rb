# MANAGE CONTROLLER =================
# TODO: for rinks: show details, toggle visibility, sanction, set owner, set contact, update description
# TODO: for members: show details, make state rep, make regional rep
# TODO: for teams: show details,
# TODO: protect all the actions with authorizations
# TODO: add ability to make anouncements
# TODO: remove auto-search from search_members, etc
# TODO: add type parameter to auto_members search??
# TODO: create advanced search forms for members
# TODO: create advanced search forms for rinks
# TODO: add new div structure to tabs in manage layout
# TODO: Div for Quick Search, Div for preset searches and actions, Div for advanced searches
# TODO: quick search by member first name
# TODO: quick search by member last name
# TODO: quick search by member WSA member Number name
# TODO: create table structer to format verify/contact dates
# TODO: manage/members: manage members (temp block, block, etc)
# TODO: manage/rinks: manage all Rinks
# TODO: manage/teams: manage all teams
# TODO: manage/events: manage all events

class ManageController < ApplicationController

  def home

  end

  def member
    @this_member = Member.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def rink
    @this_rink = Rink.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def team
    # TODO: Members/team/:id
  end

  def event
    # TODO: Members/event/:id
  end

  def search_members
    if params[:term] then
      @members = Member.all(
          :limit => 10,
          :conditions => ["first_name like ? or last_name like ?",
                          '%' + params[:term] + '%',
                          '%' + params[:term] + '%'])
    elsif params[:member] then
      searchterm = ''
      searchterm = params[:member][:search] if params[:member][:search]


      @members = Member.all(
          :conditions => ["first_name like ? or last_name like ?",
                          '%' + searchterm + '%',
                          '%' + searchterm + '%'])
    else
      @members = Member.all(
          :limit => 10)
    end

    members_json = []

    if (@members) then''
      @members.each { |m|
        members_json << {
            :label => m.full_name,
            :value => '/manage/member/' + m.id.to_s
        }
      }
    else
      members_json << {
            :label => 'No Results',
            :value => ''
        }
    end

    respond_to do |format|
      format.html
      format.json { render :json => members_json }
      format.js
    end
  end

  def search_rinks
    if params[:term]
      @rinks = Rink.all(
          :limit => 10,
          :include => :address,
          :conditions => ["name like ? or addresses.city like ?",
                          '%' + params[:term] + '%',
                          '%' + params[:term] + '%'])
    elsif params[:rink] then
      searchterm = ''
      searchterm = params[:rink][:search] if params[:rink][:search]


      @rinks = Rink.all(
          :include => :address,
          :conditions => ["name like ? or addresses.city like ?",
                          '%' + searchterm + '%',
                          '%' + searchterm + '%'])
    else
      @rinks = Rink.all(
          :limit => 10)
    end

    rinks_json = []

    if (@rinks) then
      @rinks.each { |r|
        rinks_json << {
            :label => r.name,
            :value => '/manage/rink/' + r.id.to_s
        }
      }
    else
      rinks_json << {
            :label => 'No Results',
            :value => ''
        }
    end

    respond_to do |format|
      format.html
      format.json { render :json => rinks_json }
      format.js
    end
  end

  def search_teams
    # TODO: Members/search_teams
  end

  def search_events
    # TODO: Members/search_events
  end

  def member_roles
    @roles = Role.basic

    #TODO: clean up eager loading
    #TODO: create scope for this

    @members = Member.includes(:role_members, :roles).
        joins("LEFT OUTER JOIN team_members
                ON team_members.member_id = members.id
                AND team_members.active = 1")
    
    respond_to do |format|
      format.html
    end
  end
end


#http://view.jquery.com/trunk/plugins/autocomplete/demo/search.php?q=a