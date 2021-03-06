class AuthController < ApplicationController
    skip_before_action :authorized, only: [:login, :signup]
    def login
        user = User.find_by(email: params[:email])

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            json_user = UserSerializer.new(user).serialized_json
            render json: json_user
        else
        render json: { errors: "Invalid username or password" }, status: :unauthorized
        end
    end

    def signup
        user = User.create(
            first_name: params[:first_name],
            last_name: params[:last_name],
            email: params[:email],
            password: params[:password],
            role: params[:role]
        )

        if user.valid?
            session[:user_id] = user.id
            json_user = UserSerializer.new(user).serialized_json
            render json: json_user, status: :created
        else
        render json: { errors: user.errors.full_messages }, status: :bad_request
        end
    end

    def autologin
        json_user = UserSerializer.new(@current_user).serialized_json
        render json: json_user
    end

    def logout
        session.delete(:user_id)

        render json: { message: "Logged out" }
    end

    def change_password
        user = User.find_by(email: params[:email])


        if user.authenticate(params[:currentPassword]) && params[:newPassword] == params[:newPasswordConfirm]
            user.password = params[:newPassword]
            user.save
            render json: {message: "Password Changed"}
        else
            render json: {message: "Incorrect Information Entered"}
        end
    end
end
