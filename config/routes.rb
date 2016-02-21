Rails.application.routes.draw do

  root "posts#index"

  get 'index' => "homes#index"
  get 'about' => "homes#about"

  # resources :posts
  # new/create
  # get "/posts/new" => "posts#new", as: :new_post
  # post "/posts" => "posts#create", as: :posts
  # # index/show
  # get "/posts" => "posts#index"
  # get "/posts/:id" => "posts#show", as: :post
  # # edit/update
  # get "/posts/:id/edit" => "posts#edit", as: :edit_post
  # patch "/posts/:id" => "posts#update"
  # # delete
  # delete "/posts/:id" => "posts#destroy"
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :favourites, only: [:create, :destroy]
  end
  resources :favourites, only: [:index]

  resources :users, only: [:new, :create, :show, :edit, :update]

  get "/users/:id/edit_password" => "users#edit_password", as: :edit_password
  patch "/users/:id/edit_password" => "users#update_password", as: :update_password

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
 resources :password_resets, only: [:new, :create, :edit, :update]


  get "/search" => "posts#search"
  post "/search" => "posts#search"
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

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
