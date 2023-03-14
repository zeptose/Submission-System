Rails.application.routes.draw do

  resources :sessions 
  # Semi-static page routes
   get 'home', to: 'home#index', as: :home
   get 'home/about', to: 'home#about', as: :about
   get 'home/contact', to: 'home#contact', as: :contact
   get 'home/privacy', to: 'home#privacy', as: :privacy
   get 'search', to: 'search#search', as: :search
 
  #  resources :users, only: [:edit, :index, :new, :create, :update]
  #  get 'users/new', to: 'users#new', as: :signup
  #  get 'user/edit', to: 'users#edit', as: :edit_current_user
   get 'login', to: 'sessions#new', as: :login
   get 'logout', to: 'sessions#destroy', as: :logout
 
 
   resources :categories, only: [:edit, :index, :new, :create, :update]
   resources :customers
   resources :addresses
   resources :orders
   resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
