Rails.application.routes.draw do
  resources :publications
  get "my-publications", to: "publications#my_publications"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => {
    registrations: 'users/registrations'
  }

  # Defines the root path route ("/")
  root "publications#index"
end
