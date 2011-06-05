# HOME CONTROLLER ===================
# TODO: set up basic layout
# TODO: div for member actions (update details, confirm friends?)
# TODO: div for team actions (respond to team requests, quit team)
# TODO: div for event actions (list upcoming local events)
# TODO: links to search members, locate rinks, find teams, show events
# TODO: add link to create team if not currently on one

class HomeController < ApplicationController
  before_filter :authenticate_member!
  filter_access_to :all

  def index
    @team = current_member.team
  end
end
