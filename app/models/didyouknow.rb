class Didyouknow < ActiveRecord::Base
  belongs_to :submitted_by, :class_name => 'Member'
  belongs_to :approved_by, :class_name => 'Member'

  #TODO: Verifies presence of submitted_by
end

# DID YOU KNOW MODEL ================
# TODO: relationships
# TODO: validations
# TODO: named scopes