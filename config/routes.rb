Rails.application.routes.draw do
 # get 'sessions/new'
 # root to: 'tasks#index'
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks do
    collection do
      post :confirm
    end
  end

  namespace :admin do
    resources :users
  end

  resources :users
end
