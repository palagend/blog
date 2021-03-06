Rails.application.routes.draw do
  root 'static_pages#home'
  get 'sessions/new'
  get 'session/new'
  get '/signup', to: 'users#new'
  get '/contact', to: 'static_pages#contact'
  get '/help', to: 'static_pages#help'
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
end
