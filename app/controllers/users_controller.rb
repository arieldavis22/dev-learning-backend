class UsersController < ApplicationController

    def update_user
        user = User.find_by(id: params[:id])

        user.first_name = params[:first_name]
        user.last_name = params[:last_name]
        user.save
        render json: user
    end

    def teacher_follow
        # follower = User.find_by(id: params[:follower_id])
        # followee = User.find_by(id: params[:followee_id])

        follow = Follow.create(follower_id: params[:followee_id], followee_id: params[:follower_id])
        render json: follow

    end

    def teacher_following
        user = User.find_by(id: params[:teacher_id])
        # byebug
        json_users = UserSerializer.new(user.followers).serialized_json
        render json: json_users
    end

    def all_teachers
        if params[:teacher_id]
            teachers = User.all.select {|user| user.role === "Teacher"}
            teacher = User.find_by(id: params[:teacher_id])

            non_follow = teachers.reject{|x| teacher.followers.include? x}
            # byebug
            json_users = UserSerializer.new(non_follow).serialized_json
            render json: json_users
        else
            users = User.all.select {|user| user.role === "Teacher"}

            json_users = UserSerializer.new(users).serialized_json
            render json: json_users
        end
    end

    def all_students
        if params[:classroom_id]
            users = User.all.select {|user| user.role === "Student"}
            student_classrooms = StudentClassroom.all.where(classroom_id: params[:classroom_id])
            already_in = []
            student_classrooms.select{|student| already_in << User.find_by(id: student.student_id)}
            # byebug
            not_in = users.reject{|student| already_in.include? student }
            json_users = UserSerializer.new(not_in).serialized_json
            render json: json_users
        else
            users = User.all.select {|user| user.role === "Student"}

            json_users = UserSerializer.new(users).serialized_json
            render json: json_users
        end
    end


end
