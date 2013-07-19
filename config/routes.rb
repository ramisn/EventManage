EventManagement::Application.routes.draw do
  #Front UI routes
  root :to => "home#index"
  resources :events, :only => [:index,:show] do
    member do
      get 'teams'
      get 'groups'
      get 'results'
      get 'matches'
      get 'rules'
    end
  end
  resources :feedback, :only => [:new,:create]
  resources :photos, :only => [:index]
  match 'photos/:event' => 'photos#photos', :as => 'event_photos'

  #Admin UI routes
  get "admin" => "admin::dashboard#index"
  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'
  get 'signup' => 'admin::users#new', :as => 'signup'
  match 'admin/events/:event_id/teams/:team_id/add_player' => 'admin/teams#add_player', :as => 'add_player'
  match 'admin/events/:event_id/teams/:team_id/:user_id/remove_player' => 'admin/teams#remove_player', :as => 'remove_player'
  match 'admin/events/:event_id/teams/:team_id/reset_team' => 'admin/teams#reset_team', :as => 'reset_team'

  match 'admin/events/:event_id/matches/reset_matches' => 'admin/matches#reset_matches', :as => 'reset_matches'
  match 'admin/events/:event_id/matches/:team_id/reset_result' => 'admin/matches#reset_result', :as => 'reset_result'
  match 'admin/events/:event_id/matches/:team_id/match_team_result' => 'admin/matches#match_team_result', :as => 'match_team_result'

  match 'admin/events/:event_id/groups/:group_id/add_team' => 'admin/groups#add_team', :as => 'add_team'
  match 'admin/events/:event_id/groups/:group_id/:team_id/remove_team' => 'admin/groups#remove_team', :as => 'remove_team'
  match 'admin/events/:event_id/groups/:group_id/reset_group' => 'admin/groups#reset_group', :as => 'reset_group'

  match 'admin/photos/:event/photos' => 'admin/photos#event_photos', :as => 'admin_event_photos'

  resources :sessions, :only => [:new,:create,:destroy]
  resources :password_resets, :only => [:create,:edit,:update]

  namespace :admin do
    resources :events do
      resources :teams, :except => :show
      resources :rules, :except => :show
      resources :matches
      resources :groups, :except => :show
    end
    resources :users, :except => :show
    resources :feedbacks, :only => :index
    resources :photos, :except => :show
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
