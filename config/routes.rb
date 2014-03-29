GitMyCurriculum::Application.routes.draw do

  get 'search/uc_search'
  get 'user_root' => 'profile#load'

  authenticated :user do
    root to: 'dashboard#dashboard_main', as: 'authenticated_root'
  end

  devise_for :users, controllers: { confirmations: 'confirmations', passwords: 'passwords', registrations: 'registrations', sessions: 'sessions' }

  root 'splash#load'

  get 'splash/load'

  get 'featured/show'

  get 'profile/edit'
  get 'profile/load'
  get 'dashboard/dashboard_main'
  get 'curricula/show/:id' => 'curricula#show', as: :curricula
  get 'curricula/show/:id/:branch' => 'curricula#show', as: :switch
  get 'curricula/:id/:branch/:tree/:name' => 'curricula#grab_tree_folder', as: :ajax_open_folder
  get 'curricula/:id/:branch/:name/:blob' => 'curricula#grab_file_contents', as: :open_file, :name => /(\w+)(\D+)(\w)/

  get 'curricula/create'
  get 'curricula/edit/:id', to: 'curricula#edit', as: :edit_curricula
  post '/curricula/edit/:id', to: 'curricula#edit', as: :edit_curriculum
  post '/curricula/create', to: 'curricula#create', as: :create_curriculum

  get 'curricula/fork/:id' => 'curricula#fork', as: :fork
  get 'curricula/commits/:id' => 'curricula#commits', as: :c_commit
  get 'curricula/clone/:username/:curriculum_name' => 'curricula#clone'
  get '/curricula/compare/:id/:commit' => 'curricula#compare', as: :compare

  get 'splash/load'

  get 'dashboard/dashboard_main'

  get 'subscriptions/subscription'
  post 'subscriptions/subscription' => 'subscriptions#subscription', as: :subscription

  # Temp function for contributors until JSON is solved
  get 'subscriptions/contributor'
  post 'subscriptions/contributor' => 'subscriptions#contributor', as: :contributor

  get 'curricula/revert_save/:id/:commit_id', to: 'curricula#revert_save', as: :revert_save

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
