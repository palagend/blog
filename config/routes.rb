Rails.application.routes.draw do
  get '/contact', to: 'static_pages#contact'

  get '/help', to: 'static_pages#help'

  get '/home', to: 'static_pages#home'

  get '/about', to: 'static_pages#about'

  root 'static_pages#home'
end
