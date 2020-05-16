class UsersController < ApplicationController

    def all_classrooms
        user = User.find_by(id: params[:id])
        if user
            user_classrooms = Classroom.all.select { |classroom| classroom.teacher_id == user.id }
            render json: user_classrooms
        end
    end

    def new_classroom
        user = User.find_by(id: params[:teacher_id])

        if user
            name = params[:name]
            new_classroom = Classroom.create(teacher_id: user.id, name: name)
            render json: user
        end
    end

    # def user_students
    #     users = User.all.select {|user| user.role === "Student"}

    #     json_user = UserSerializer.new(users).serialized_json
    #     render json: json_user
    # end

    # def user_students_in_class
    #     user = User.find_by(email: params[:email])

    #     if user
    #         json_user = UserSerializer.new(user.students).serialized_json
    #         render json: json_user
    #     end
    # end

    # def add_student
    #     user = User.find_by(email: params[:teacher_email])
    #     student = User.find_by(email: params[:student_email])

    #     if user && student
    #         user.students << student
    #         json_user = UserSerializer.new(student).serialized_json
    #         render json: json_user
    #     end
    # end


end
