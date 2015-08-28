Rails.application.routes.draw do

  get 'ui(/:action)', controller: 'ui'

  get '/register', to: 'users#new'

end
