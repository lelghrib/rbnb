Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :activities, only: [ :index,:new, :create, :show ] do
    resources :bookings, only: [ :create ]
  end
  resources :bookings, only: [ :index ]

  namespace :seller do
    resources :activities, only: [:index, :new, :create, :show]
    resources :bookings, only: [ :index ]
  end

end
