Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "pages#home"

  authenticate :user do
    resources :articles, except: %i[index show]
  end

  resources :articles do
    resources :contributions, only: %i[new create]
    resources :comments
  end

  resources :authors, only: %i[show new destroy] do
    resources :comments
    resources :articles
  end

  resources :bookmarks

  get "become_author", to: "users#become_author"


  namespace :authorspace do
    get '/', to: "pages#home", as: :root

    resources :articles do
      resources :contributions, only: %i[new create]
      resources :comments
    end

    resources :authors, only: %i[show new destroy] do
      resources :comments
      resources :articles
      resources :groups
    end
  end
end
