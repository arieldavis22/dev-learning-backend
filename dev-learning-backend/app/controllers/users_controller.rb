class UsersController < ApplicationController

    def all_students
        users = User.all.select {|user| user.role === "Student"}

        json_users = UserSerializer.new(users).serialized_json
        render json: json_users
    end


end
