Rails.application.routes.draw do

  # namespace :teacher do
    post "/tsignup", to: "teachers#signup"
    post "/tlogin", to: "teachers#login"
    post "/tlogout", to: "teachers#logout"
    get "/autologin", to: "teachers#autologin"
  # end

  post "/ssignup", to: "students#signup"
  post "/slogin", to: "students#login"
  post "/slogout", to: "students#logout"
  # get "/sautologin", to: "students#autologin"
end
