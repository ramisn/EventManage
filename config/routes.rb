EventManagement::Application.routes.draw do

  #Front UI routes
  root :to => "home#index"
  resources :events, :only => [:index,:show] do
    member do
      get 'teams'
      get 'results'
      get 'matches'
      get 'rules'
    end
  end

  #Admin UI routes
  get "admin" => "admin::dashboard#index"
  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'
  get 'signup' => 'admin::users#new', :as => 'signup'
  match 'admin/events/:event_id/teams/:team_id/add_player' => 'admin/teams#add_player', :as => 'add_player'
  match 'admin/events/:event_id/teams/:team_id/:user_id/remove_player' => 'admin/teams#remove_player', :as => 'remove_player'
  match 'admin/events/:event_id/teams/:team_id/reset_team' => 'admin/teams#reset_team', :as => 'reset_team'
  match 'admin/events/:event_id/teams/:team_id/show_result' => 'admin/teams#show_result', :as => 'team_result'
  match 'admin/events/:event_id/teams/:team_id/plus_one_played' => 'admin/teams#plus_one_played', :as => 'plus_one_played'
  match 'admin/events/:event_id/teams/:team_id/plus_one_won' => 'admin/teams#plus_one_won', :as => 'plus_one_won'
  match 'admin/events/:event_id/teams/:team_id/plus_one_lost' => 'admin/teams#plus_one_lost', :as => 'plus_one_lost'
  match 'admin/events/:event_id/teams/:team_id/plus_one_tie' => 'admin/teams#plus_one_tie', :as => 'plus_one_tie'
  match 'admin/events/:event_id/teams/:team_id/plus_one_nr' => 'admin/teams#plus_one_nr', :as => 'plus_one_nr'
  match 'admin/events/:event_id/teams/:team_id/reset_result' => 'admin/teams#reset_result', :as => 'reset_result'
  match 'admin/events/:event_id/matches/:match_id/update_result' => 'admin/matches#update_result', :as => 'update_result'
  match 'admin/events/:event_id/matches/reset_matches' => 'admin/matches#reset_matches', :as => 'reset_matches'

  resources :sessions, :only => [:new,:create,:destroy]
  resources :password_resets, :only => [:create,:edit,:update]

  namespace :admin do
    resources :events do
      resources :teams, :except => :show
      resources :rules, :except => :show
      resources :matches, :except => :show
    end
    resources :users, :except => :show
  end

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
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
