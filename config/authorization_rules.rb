authorization do
  role :admin do
    has_omnipotence
  end

  role :wsa_manage do
    has_permission_on [:manage],
      :to => [:home,
              :member,
              :rink,
              :team,
              :event,
              :search_members,
              :search_rinks,
              :search_teams,
              :search_events]
    has_permission_on [:rinks],
      :to => [:toggle_visibility,
              :set_contacted,
              :verify,
              :unverify,
              :set_rink_owner,
              :new,
              :create,
              :destroy]
    has_permission_on [:role_members],
      :to => [:toggle]
  end

  role :member do
    has_permission_on [:home], :to => [:index]

    has_permission_on [:rinks],
      :to => [:index, :show, :info, :locate, :locate_rinks]

    has_permission_on [:members],
          :to => [:set_home_rink]

    has_permission_on [:team_members],
      :to => [:show, :index, :team_request, :approve_request, :deny_request, :quit_team, :cancel_team_request]

    has_permission_on [:friendships],
        :to => [:send_request, :index, :delete, :requests]

    #unsafe actions need to be restricted
    has_permission_on [:friendships] do
      to [:accept, :deny]
      if_attribute :friend => is {user}
    end
    has_permission_on [:friendships] do
      to [:cancel]
      if_attribute :member => is {user}
    end
  end

  role :wsa_member do
    #only allow wsa_members to form teams
    #only allow wsa_members to have friends

    #only allow wsa_members to do pretty much anything
  end

  role :rink_owner do
    has_permission_on [:rinks] do
      to [:manage, :edit, :update]
      if_attribute :owner => is {user}
    end
  end

  role :rink_employee do

  end

  role :team_owner do
    has_permission_on [:teams] do
      to [:manage, :edit, :requests, :kick_off]
      if_attribute :owner => is {user}
    end
    has_permission_on [:team_members], :to => :member_request
    has_permission_on [:team_members] do
      to [:cancel_request, :approve_team_request, :deny_team_request]
      if_attribute :team => is {user.team}
    end
    #TODO: ONLY ALLOW FOR TEAM OWNERS, WHO OWN THAT TEAM
  end

  role :team_member do
    has_permission_on [:members] do
      to [:quit_team]
    end
  end

  role :team_captain do

  end

  role :event_admin do
    
  end

  role :guest do
    
  end
end