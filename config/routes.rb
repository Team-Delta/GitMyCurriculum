GitMyCurriculum::Application.routes.draw do

  get "search/uc_search"
  get 'user_root' => 'profile#load'

  authenticated :user do
    root to: 'dashboard#dashboard_main', as: 'authenticated_root'
  end

  root 'splash#load'

  get 'profile/edit'
  get 'profile/load'

  get 'curricula/commits/:id' => 'curricula#commits', as: :c_commit

  get 'curricula/fork/:id' => 'curricula#fork', as: :fork

  get 'curricula/clone/:username/:curriculum_name' => 'curricula#clone'

  get 'curricula/show/:id' => 'curricula#show', as: :curricula
  get 'curricula/show/:id/:branch' => 'curricula#show', as: :switch
  get 'curricula/show/:id/:branch/:tree' => 'curricula#show', as: :open_folder

  get 'curricula/:id/:branch/blob/:name/:blob' => 'curricula#showfile', as: :open_file, :name => /(\w+)(\D+)(\w)/
  
  get 'curricula/create'
  post '/curricula/create', to: 'curricula#create', as: :create_curriculum

  get 'curricula/edit/:id', to: 'curricula#edit', as: :edit_curricula
  post '/curricula/edit/:id', to: 'curricula#edit', as: :edit_curriculum

  get 'curriculua/revert_save/:id/:commit_id', to: 'curricula#revert_save', as: :revert_save

  get 'splash/load'

  get 'dashboard/dashboard_main'

  get 'users/show'

  get 'subscriptions/user_follow'
  get 'subscriptions/user_unfollow'
  get 'subscriptions/curricula_follow'
  get 'subscriptions/curricula_unfollow'
  post 'subscriptions/user_follow' => 'curricula#user_follow', as: :user_follow
  post 'subscriptions/user_unfollow' => 'curricula#user_unfollow', as: :user_unfollow
  post 'subscriptions/curricula_follow' => 'curricula#curricula_follow', as: :curricula_follow
  post 'subscriptions/curricula_unfollow' => 'curricula#curricula_unfollow', as: :curricula_unfollow


  devise_for :users, :controllers => {:confirmations => "confirmations", :passwords => "passwords", :registrations => "registrations", :sessions => "sessions"}

  get 'users/:username' => 'users#show', as: :user
 
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
