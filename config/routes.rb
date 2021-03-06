Rails.application.routes.draw do
	# Welcome Page
  get '/', to: 'welcome#show'
  get '/welcome', to: 'welcome#show'

	# User Session
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

	# Merchants
  resources :merchants

	# Items
  resources :items, only: [:index, :show]

	# Reviews
  get '/items/:item_id/reviews/new', to: 'reviews#new'
  post '/items/:item_id/reviews', to: 'reviews#create'
  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'

	# Cart
  post '/cart/:item_id', to: 'cart#add_item'
  get '/cart', to: 'cart#show'
  delete '/cart', to: 'cart#empty'
  delete '/cart/:item_id', to: 'cart#remove_item'
	patch '/cart/:item_id/:increment_decrement', to: 'cart#increment_decrement'

	# Orders
  get '/orders/new', to: 'orders#new'
  post '/orders', to: 'orders#create'
  get '/orders/:id', to: 'orders#show'

	# Registration
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

	# User
  namespace :user do
    get '/profile/edit', to: 'profile#edit'
    patch '/profile', to: 'profile#update'
    get '/profile', to: 'profile#show'
    get '/profile/edit_password', to: 'profile#edit_password'
    get '/profile/orders', to: 'profile/orders#index'
    get '/profile/orders/:id', to: 'profile/orders#show'
    patch '/profile/orders/:id', to: 'profile/orders#cancel'
  end

	# Merchant Employee
  namespace :merchant_employee do
    get '/dashboard', to: 'dashboard#show'
    get '/orders/:id', to: 'orders#show'
    get '/merchants/:id/items', to: 'items#index'
    get '/merchants/:id/items/new', to: 'items#new'
    post '/merchants/:id/items', to: 'items#create'
    get '/merchants/:id/items/:id', to: 'items#show'
    get '/merchants/:id/items/:id/edit', to: 'items#edit'
    patch '/merchants/:id/items/:id', to: 'items#update'
    patch '/merchants/:id/items/:id/update', to: 'item_status#update'
    delete '/merchants/:id/items/:id', to: 'items#destroy'
    patch '/orders/:id', to: 'item_orders#update'
    get 'discounts/new', to: 'discounts#new', as: :discounts
    post 'discounts/', to: 'discounts#create'
    get 'discounts/:id/edit', to: 'discounts#edit'
    patch 'discounts/:id', to: 'discounts#update'
    delete 'discounts/:id', to: 'discounts#destroy'
  end

	# Admin
  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    get '/merchant_employee/merchants/:id/items', to: '/merchant_employee/items#index'
    get '/users', to: 'users#index'
    get '/users/:id', to: 'users#show'
    get '/merchants', to: 'merchants#index'
    get '/merchants/:merchant_id', to: 'merchants#show'
    patch '/users/:id/orders/:id/ship', to: 'orders#ship'
    patch '/merchants/:id', to: 'merchants#update'
  end
end
