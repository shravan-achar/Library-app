Rails.application.routes.draw do
  get 'sessions/new'

  root 'homepage#home'

  get 'homepage/contact'
  get 'homepage/about'
  get '/home', to: 'homepage#home'

  get '/signup', to:'members#new'
  post '/signup', to:'members#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'


  get 'admins/options', :to => 'admins#options'
  resources :admins
  post 'bookings/search', :to => 'bookings#search'
  get 'bookings/makebooking', :to => 'bookings#makebooking'
  post 'bookings/quickbook', :to => 'bookings#quickbook'
  resources :bookings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'members/showall', :to => 'members#showall'
  get 'members/history', :to => 'members#history'
  resources :members
  resources :rooms

end
