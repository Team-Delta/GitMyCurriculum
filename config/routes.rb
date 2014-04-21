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

  resources :curricula do
    
    member do
      get 'show/:id/:branch' => 'curricula#switch_branch', as: :switch_branch
      get ':branch/:tree/:name' => 'curricula#grab_tree_folder', as: :open_folder
      get ':branch/:name/:blob' => 'curricula#grab_file_contents', as: :open_file, :name => /(\w+)(\D+)(\w)/
      get 'fork/:id' => 'curricula#fork', as: :fork
    end

    scope module: :curricula do

      resource :exchange do 
        member do
          get 'upload'
          post 'upload'
        end
      end


      get 'show' => 'history#show', as: :history
      get 'compare/:commit' => 'history#compare', as: :compare
      get 'revert/:commit' => 'history#revert', as: :revert

    end

  end

  get 'edit_curricula/edit/:id', to: 'edit_curricula#edit', as: :curricula_edit
  post '/edit_curricula/edit/:id', to: 'edit_curricula#edit', as: :edit_curriculum

  get 'edit_curricula/update_contributors' => 'edit_curricula#update_contributors', as: :update_contributors
  get 'edit_curricula/search_results' => 'edit_curricula#search_results', as: :search_results

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
