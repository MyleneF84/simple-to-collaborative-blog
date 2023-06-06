Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"

  resources :articles

  resources :articles do
    resources :authors
  end

  resources :authors do
    resources :articles
  end

  resources :authors
end
