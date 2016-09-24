Rails.application.routes.draw do
  post 'bookings/search', :to => 'bookings#search'
  get 'bookings/makebooking', :to => 'bookings#makebooking'
  post 'bookings/quickbook', :to => 'bookings#quickbook'
  resources :bookings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
