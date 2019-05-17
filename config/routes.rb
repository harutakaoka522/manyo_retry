Rails.application.routes.draw do
  get 'sessions/new'
  root to: 'tasks#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :tasks do
    collection do
      post :confirm
    end
  end
end
