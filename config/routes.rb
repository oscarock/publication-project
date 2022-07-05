Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => {
    registrations: 'users/registrations'
  }

  # Defines the root path route ("/")
  root "dashboard#index"
end
