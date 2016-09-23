Rails.application.routes.draw do
  root 'homepage#home'

  get 'homepage/contact'
  get 'homepage/about'
  get '/home', to: 'homepage#home'

  get '/signup', to:'members#new'
  post '/signup', to:'members#create'

  resources :members

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
