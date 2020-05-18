Rails.application.routes.draw do
  # resources :users
  post "/signup", to: "auth#signup"
  post "/login", to: "auth#login"
  post "/logout", to: "auth#logout"
  get "/autologin", to: "auth#autologin"

  post "/all-classrooms", to: "classrooms#all_classrooms"
  post "/new-classroom", to: "classrooms#new_classroom"

  get '/all-students', to: "users#all_students"
  get '/all-teachers', to: "users#all_teachers"
  post '/following', to: "users#teacher_following"
  post '/follow', to: "users#teacher_follow"

  post '/add-student', to: "student_classrooms#add_student_to_class"
  post '/find-students', to: "student_classrooms#find_students_in_class"
  post '/find-classrooms', to: "student_classrooms#find_student_classrooms"

  # post "/newclass", to: "classrooms#new_class"

  post "/newlesson", to: "lessons#create_lesson"
  post "/all-lessons", to: "lessons#all_lessons"

  post "/lesson-classroom", to: "classroom_lessons#add_lesson_classroom"
  post "/find-lessons", to: "classroom_lessons#find_classroom_lessons"

  post "/check-code", to: "student_lessons#check_code"
end
