
class EventsController < ApplicationController
  before_filter :authenticate_member!
  filter_access_to :all
  
end


# EVENTS CONTROLLER =================
# TODO: flesh out events model
# TODO: ACTION: New Event
# TODO: ACTION: List Events
# TODO: ACTION: Edit Event
# TODO: ACTION: Show Event
