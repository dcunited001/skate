Sk8::Application.routes.draw do

  devise_for :member, :path => '', :path_names => {
      :sign_in => "login",
      :sign_out => "logout",
      :sign_up => "register" }
  #devise_for :devise

  #hack because when on sinatra page, for whatever reason
  #   the links do not allow me to submit a DELETE request to the logout action
  #match 'logout' => 'devise/sessions#logout'

  #Routes for Sinatra GuestApp
  match 'home' => 'home#index'
  match '/', :to => GuestApp, :constraints => lambda { |r| !r.env["warden"].authenticate? }
  [:mission, :features, :about, :contact].each do |page|
    match "/#{page.to_s}", :to => GuestApp
  end

  root :to => 'home#index'
  #root :to => 'home#index', :constraints => lambda { |r| r.env["warden"].authenticate? }
  #root :to => GuestApp, :constraints => lambda { |r| !r.env["warden"].authenticate? }


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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

end
