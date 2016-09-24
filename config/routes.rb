Rails.application.routes.draw do
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
