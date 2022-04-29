Rails.application.routes.draw do

  resources :tasks do
    collection do
      get :sort
      get :search
    end
  end
  resources :sessions, only: %i[new create destroy]
  resources :users, only: %i[new create show]

  namespace :admin do
    resources :users, except: [:show]
  end
  root to: 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
