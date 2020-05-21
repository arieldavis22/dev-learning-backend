Rails.application.routes.draw do
  # resources :users
  post "/signup", to: "auth#signup"
  post "/login", to: "auth#login"
  post "/logout", to: "auth#logout"
  get "/autologin", to: "auth#autologin"

  post "/all-classrooms", to: "classrooms#all_classrooms"
  post "/new-classroom", to: "classrooms#new_classroom"
  patch "/edit-classroom", to: "classrooms#edit_classroom"

  post '/all-students', to: "users#all_students"
  post '/all-teachers', to: "users#all_teachers"
  post '/following', to: "users#teacher_following"
  post '/follow', to: "users#teacher_follow"
  patch '/edit-user', to: "users#update_user"

  post '/add-student', to: "student_classrooms#add_student_to_class"
  post '/find-students', to: "student_classrooms#find_students_in_class"
  post '/find-classrooms', to: "student_classrooms#find_student_classrooms"
  delete '/remove-student', to: "student_classrooms#delete_student_in_class"
  post '/find-student-gpa', to: "student_classrooms#find_student_gpa"
  post '/correct', to: "student_classrooms#correct_answer"
  post '/wrong', to: "student_classrooms#wrong_answer"

  # post "/newclass", to: "classrooms#new_class"

  post "/newlesson", to: "lessons#create_lesson"
  post "/all-lessons", to: "lessons#all_lessons"
  post "/check-code", to: "lessons#check_code"

  post "/lesson-classroom", to: "classroom_lessons#add_lesson_classroom"
  post "/find-lessons", to: "classroom_lessons#find_classroom_lessons"

end
