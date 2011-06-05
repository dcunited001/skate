class Authentication < ActiveRecord::Base
    belongs_to :member

    attr_accessible :member_id, :provider, :uid
end