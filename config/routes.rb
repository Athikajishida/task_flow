Rails.application.routes.draw do
  post '/register', to: 'authentication#register'
  post '/login', to: 'authentication#login'
  post '/logout', to: 'authentication#logout'
  resources :tasks, only: [:index, :create, :update, :destroy]
end
