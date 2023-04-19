Rails.application.routes.draw do

  resources :sessions 
  # Semi-static page routes
   get 'home', to: 'home#index', as: :home
   get 'home/about', to: 'home#about', as: :about
   get 'home/contact', to: 'home#contact', as: :contact
   get 'home/privacy', to: 'home#privacy', as: :privacy
   get 'search', to: 'search#search', as: :search
 
   resources :users, only: [:edit, :index, :new, :create, :update]
   get 'users/new', to: 'users#new', as: :signup
   get 'user/edit', to: 'users#edit', as: :edit_current_user
   get 'login', to: 'sessions#new', as: :login
   get 'logout', to: 'sessions#destroy', as: :logout
 
   resources :categories
   resources :items, except: [:destroy, :index] # in the future, items should be destroyed if there are no submissions attached

   resources :case_workers
   resources :parents

   patch 'categories/:id/toggle_active_category', to: 'categories#toggle_active_category', as: :toggle_active_category
   patch 'items/:id/toggle_active_item', to: 'items#toggle_active_item', as: :toggle_active_item
   patch 'parents/:id/toggle_active_parent', to: 'parents#toggle_active_parent', as: :toggle_active_parent

   root 'home#index'

  # Hello For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
