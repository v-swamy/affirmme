Rails.application.routes.draw do
  root to: 'pages#front'

  get 'ui(/:action)', controller: 'ui'

  get '/register', to: 'users#new'

  resources :users
  resources :affirmations
end
