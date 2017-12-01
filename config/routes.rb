Rails.application.routes.draw do
  root :to => 'gallery#index'
  get 'gallery/index', to: 'gallery#index'
  get "gallery/about", to: 'gallery#about'
  get "gallery/member", to: 'gallery#member'
  get "gallery/one_hour", to: 'gallery#one_hour'
  get "gallery/illust/:tweet_id", to: 'gallery#illust'
  post "gallery/illust/:tweet_id", to: 'gallery#illust'
  get "gallery/search", to: 'gallery#search'

  resources :topics
  post "topics/post", to: 'topics#post'
end
