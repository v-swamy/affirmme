Rails.application.routes.draw do
  root to: 'pages#front'

  get 'ui(/:action)', controller: 'ui'

  get '/register', to: 'users#new'

  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  resources :users
  resources :affirmations
end
