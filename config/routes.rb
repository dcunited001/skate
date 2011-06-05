Testapp2::Application.routes.draw do
  match '/auth/:provider/callback' => 'authentications#create'

  devise_for :members, :controllers => { :registrations => 'registrations'}

  #===================================================
  # HOME_CONTROLLER
  #===================================================
  match '/home/' => 'home#index'
  match '/home/friend_requests' => 'friendships#requests'
  match '/home/team_requests' => 'team_members#index'
  match '/home/friends/' => 'friendships#index'
  match '/home/team_mates/' => 'team_members#team_mates'

  #===================================================
  # TEAMS_CONTROLLER
  #===================================================
  match '/teams/manage' => 'teams#manage'
  match '/teams/set_home_rink' => 'teams#set_home_rink'
  match '/teams/requests' => 'teams#requests'
  match '/teams/kick_off/:id' => 'teams#kick_off'

  #===================================================
  # MEMBERS_CONTROLLER
  #===================================================
  match '/members/set_home_rink/:id' => 'members#set_home_rink'
  match '/members/' => 'members#index'
  match '/members/quit_team' => 'members#quit_team'
  match '/members/:id' => 'members#show'

  #===================================================
  # ROLE_MEMBERS_CONTROLLER
  #===================================================
  match '/role_members/toggle/:member/:role' => 'role_members#toggle'

  #===================================================
  # TEAM_MEMBERS_CONTROLLER
  #===================================================
  match '/team_members/team_request/:id' => 'team_members#team_request'
  match '/team_members/member_request/:id' => 'team_members#member_request'
  match '/team_members/approve_request/:id' => 'team_members#approve_request'
  match '/team_members/deny_request/:id' => 'team_members#deny_request'
  match '/team_members/cancel_request/:id' => 'team_members#cancel_request'
  match '/team_members/show/:id' => 'team_members#show'
  match '/team_requests/' => 'team_members#index'

  match '/team_members/approve_team_request/:id' => 'team_members#approve_team_request'
  match '/team_members/deny_team_request/:id' => 'team_members#deny_team_request'
  match '/team_members/cancel_team_request/:id' => 'team_members#cancel_team_request'

  #===================================================
  # FRIENDSHIPS_CONTROLLER
  #===================================================
  match '/friends/' => 'friendships#index'
  match '/friends/requests' => 'friendships#requests'
  match '/friends/send_request/:id' => 'friendships#send_request'
  match '/friends/delete/:id' => 'friendships#delete'
  match '/friends/accept/:id' => 'friendships#accept'
  match '/friends/deny/:id' => 'friendships#deny'
  match '/friends/cancel/:id' => 'friendships#cancel'

  #===================================================
  # MANAGE_CONTROLLER
  #===================================================
  match '/manage/' => 'manage#home'
  match '/manage/home' => 'manage#home'

  match '/manage/member_roles' => 'manage#member_roles'

  match '/manage/member/:id' => 'manage#member'
  match '/manage/rink/:id' => 'manage#rink'
  match '/manage/event/:id' => 'manage#event'
  match '/manage/team/:id' => 'manage#team'

  match '/manage/search_members' => 'manage#search_members'
  match '/manage/search_rinks' => 'manage#search_rinks'
  match '/manage/search_events' => 'manage#search_events'
  match '/manage/search_teams' => 'manage#search_teams'

  #===================================================
  # RINKS_CONTROLLER
  #===================================================
  match '/rinks/info/:id' => 'rinks#info'
  match '/rinks/locate' => 'rinks#locate'
  match '/rinks/locate/:state' => 'rinks#locate'
  match '/rinks/locate_rinks' => 'rinks#locate_rinks'
  match '/rinks/locate_rinks/:state' => 'rinks#locate_rinks'
  match '/rinks/toggle_visible/:id' => 'rinks#toggle_visible'
  match '/rinks/verify/:id' => 'rinks#verify'
  match '/rinks/unverify/:id' => 'rinks#unverify'
  match '/rinks/set_contacted/:id' => 'rinks#set_contacted'

  #===================================================
  # ADMIN_CONTROLLER
  #===================================================
  match '/admin/index'

  resources :authentications
  resources :teams
  resources :rinks


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.bak.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

  root :to => "home#index"
end
