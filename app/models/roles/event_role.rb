class EventRole < Role
  def self.names
    { :event_admin => 'event_admin',
      :event_moderator => 'event_moderator',
      :event_registrant => 'event_registrant',
      :event_attendee => 'event_attendee',
      :event_rsvp => 'event_rsvp' }
  end
end