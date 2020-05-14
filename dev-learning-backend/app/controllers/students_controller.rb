class StudentsController < ApplicationController
    skip_before_action :authorized, only: [:login, :signup]

    def login
        student = Student.find_by(email: params[:email])

        if student && student.authenticate(params[:password])
            session[:student_id] = student.id
            render json: student
        else
            render json: { error: "Invalid email or password" }, status: :unauthorized
        end
    end

    def signup
        student = Student.create(
            first_name: params[:first_name],
            last_name: params[:last_name],
            email: params[:email],
            password: params[:password],
            point_average: 100
        )

        if student.valid?
            session[:student_id] = student.id
            render json: student, status: :created
        else
            render json: {errors: student.errors.full_messages}, status: :bad_request
        end
    end

    def autologin
        render json: @current_student
    end

    # def logout
    #     reset_session
    #     @current_student = nil
    #     render json: { message: "Logged out" }
    # end
end
