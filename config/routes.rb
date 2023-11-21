Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post "/api/v1/customers/subscriptions", to: "api/v1/customers/subscriptions#create"
end
