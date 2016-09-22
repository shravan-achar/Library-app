Rails.application.routes.draw do
  get 'bookings/search', :to => 'bookings#search'
  resources :bookings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
