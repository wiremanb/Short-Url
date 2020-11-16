Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'shortcodes#index', as: 'home'

  resources :shortcodes

  get '/:short_url', to: 'shortcodes#goto', as: 'goto'
end
