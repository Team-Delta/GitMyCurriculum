GitMyCurriculum::Application.routes.draw do

  get 'search/uc_search'
  get 'user_root' => 'profile#load'

  authenticated :user do
    root to: 'dashboard#show', as: 'authenticated_root'
  end

  devise_for :users, controllers: { confirmations: 'confirmations', passwords: 'passwords', registrations: 'registrations', sessions: 'sessions' }

  root 'splash#load'

  get 'splash/load'

  get 'profile/edit'
  get 'profile/load'
  get 'dashboard/show'

  # Curricula area

  resources :curricula do

    member do
      get 'tree/:name' => 'curricula#grab_tree_folder', as: :open_folder
      get 'blob/:name' => 'curricula#grab_file_contents', as: :open_file, :name => /(\w+)(\D+)(\w)/
      get 'fork' => 'curricula#fork', as: :fork
    end

  end

  namespace :curricula do

    get ':id/settings', to: 'settings#show', as: :settings
    post ':id/settings', to: 'settings#show', as: :settings_post

    get 'settings/contributors' => 'settings#update_contributors', as: :contributors
    get 'settings/search' => 'settings#search_results', as: :settings_search

    get ':id/requests/' => 'pull_request#show_requests', as: :requests
    get 'join/:id' => 'pull_request#pull_request', as: :join_request
    get 'merge/:id' => 'pull_request#merge_request', as: :merge
    post 'comment' => 'pull_request#comment', as: :comment

    get ':id/download' => 'exchanges#download', as: :download
    get ':id/upload' => 'exchanges#upload', as: :show_upload
    post ':id/upload' => 'exchanges#upload', as: :post_upload

    get ':id/history' => 'history#show', as: :history
    get ':id/compare/:commit' => 'history#compare', as: :compare
    get ':id/revert/:commit' => 'history#revert', as: :revert

  end

  get 'splash/load'

  get 'subscriptions/subscription'
  post 'subscriptions/subscription' => 'subscriptions#subscription', as: :subscription

  get 'source/show/:id' => 'source#show', as: :source_show
  post 'source/edit' => 'source#edit', as: :source_edit

  get 'featured/show' => 'featured#show', as: :featured_show
  get 'featured/add_featured' => 'featured#add_featured', as: :add_featured
  get 'featured/remove_featured' => 'featured#remove_featured', as: :remove_featured

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
