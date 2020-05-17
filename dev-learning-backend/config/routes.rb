Rails.application.routes.draw do
  # resources :users
  post "/signup", to: "auth#signup"
  post "/login", to: "auth#login"
  post "/logout", to: "auth#logout"
  get "/autologin", to: "auth#autologin"

  post "/all-classrooms", to: "classrooms#all_classrooms"
  post "new-classroom", to: "classrooms#new_classroom"

  get '/all-students', to: "users#all_students"

  post '/add-student', to: "student_classrooms#add_student_to_class"
  post 'find-students', to: "student_classrooms#find_students_in_class"
  post 'find-classrooms', to: "student_classrooms#find_student_classrooms"

  post "/newclass", to: "classrooms#new_class"

  post "/newlesson", to: "lessons#create_lesson"
  post "/all-lessons", to: "lessons#all_lessons"
end
