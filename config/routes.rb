Rails.application.routes.draw do

  get "posts/index"
  devise_for :collaborateurs, skip: [:registrations]
  resources :collaborateurs, only: [:index, :new, :create, :edit, :update, :destroy, :show]


  get "up" => "rails/health#show", as: :rails_health_check



  # root "posts#index"

  root to: redirect('/restaurants')


  resources :restaurants
  resources :fonctions
  resources :affectations

end