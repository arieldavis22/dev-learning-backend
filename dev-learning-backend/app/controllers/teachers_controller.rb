class TeachersController < ApplicationController
    skip_before_action :authorized, only: [:login, :signup]

    def login
        teacher = Teacher.find_by(email: params[:email])

        if teacher && teacher.authenticate(params[:password])
            session[:teacher_id] = teacher.id
            render json: teacher
        else
            render json: { error: "Invalid email or password" }, status: :unauthorized
        end
    end

    def signup
        teacher = Teacher.create(
            first_name: params[:first_name],
            last_name: params[:last_name],
            email: params[:email],
            password: params[:password]
        )

        if teacher.valid?
            session[:teacher_id] = teacher.id
            render json: teacher, status: :created
        else
            render json: {errors: teacher.errors.full_messages}, status: :bad_request
        end
    end

    def autologin
        render json: @current_teacher
    end

    def logout
        reset_session
        render json: { message: "Logged out" }
    end
end
