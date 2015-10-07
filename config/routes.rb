Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'pages#front'

  get 'ui(/:action)', controller: 'ui'

  get '/register', to: 'users#new'

  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  

  post '/start', to: 'twilio#start'
  post '/status', to: 'twilio#status'
  post '/stop', to: 'twilio#stop'


  resources :users
  resources :affirmations
end
