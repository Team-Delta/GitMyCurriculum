GitMyCurriculum::Application.routes.draw do

  get "search/uc_search"
  get 'user_root' => 'profile#load'

  authenticated :user do
    root to: 'dashboard#dashboard_main', as: 'authenticated_root'
  end

  root 'splash#load'

  get 'profile/edit'
  get 'profile/load'

  get 'curricula/create'
  post '/curricula/create', to: 'curricula#create', as: :create_curriculum
  get 'curricula/cur_edit'
  post '/curricula/cur_edit', to: 'curricula#cur_edit', as: :edit_curriculum

  get 'splash/load'

  get 'dashboard/dashboard_main'

  get 'users/show'
  get 'users/follow'
  get 'users/unfollow'
  post 'users/follow' => 'users#follow', as: :follow
  post 'users/unfollow' => 'users#unfollow', as: :unfollow

  devise_for :users, :controllers => {:confirmations => "confirmations", :passwords => "passwords", :registrations => "registrations", :sessions => "sessions"}
  # :skip => [:sessions]
  # as :user do
  #   post 'splash/load' => 'devise/sessions#create', :as => :user_session
  # end
  
 
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
