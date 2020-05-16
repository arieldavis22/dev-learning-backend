Rails.application.routes.draw do
  # resources :users
  post "/signup", to: "auth#signup"
  post "/login", to: "auth#login"
  post "/logout", to: "auth#logout"
  get "/autologin", to: "auth#autologin"

  post "/all-classrooms", to: "users#all_classrooms"
  post "new-classroom", to: "users#new_classroom"

  post "/newclass", to: "classrooms#new_class"
end
