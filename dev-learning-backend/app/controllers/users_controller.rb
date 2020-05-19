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
        users = User.all.select {|user| user.role === "Teacher"}

        json_users = UserSerializer.new(users).serialized_json
        render json: json_users
    end

    def all_students
        users = User.all.select {|user| user.role === "Student"}

        json_users = UserSerializer.new(users).serialized_json
        render json: json_users
    end


end
