Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'shortcodes#index', as: 'home'

  resources :shortcodes

  get '/top100', to: 'shortcodes#top100', as: 'top100'
  get '/:short_url', to: 'shortcodes#goto', as: 'goto'
  post '/shortcodes/:original_url', to: 'shortcodes#create', as: 'original_url'
end
