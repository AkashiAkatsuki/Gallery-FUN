Rails.application.routes.draw do
  root :to => 'gallery#index'
  get 'gallery/index', to: 'gallery#index'
  get "gallery/about", to: 'gallery#about'
  get "gallery/member", to: 'gallery#member'

end
