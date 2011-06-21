class Announcement < ActiveRecord::Base
  belongs_to :posted_by, :class_name => 'Member'

  #TODO: verifies presence of Posted_by
end



# ANNOUNCEMENTS MODEL ===============
# TODO: relationships
# TODO: validations
# TODO: named scopes