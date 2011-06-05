class Event < ActiveRecord::Base
  belongs_to :event_format
  belongs_to :event_level
  belongs_to :event_type

  has_one :address, :as => :addressable, :dependent => :destroy


end


# EVENTS MODELS =====================
# TODO: flesh out events model
# TODO: Named Scopes
# TODO: Validations?
# TODO: relationships
# TODO: set basic event types