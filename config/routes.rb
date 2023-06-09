Rails.application.routes.draw do
  devise_for :authors
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"

  resources :articles

  resources :authors do
    resources :articles
  end

  resources :articles do
    resources :contributions, only: %i[new create]
  end

  resources :articles do
    resources :comments
  end

  resources :authors do
    resources :comments
  end

  resources :authors, only: %i[show new destroy]
end
