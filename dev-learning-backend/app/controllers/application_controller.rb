class ApplicationController < ActionController::API
    include ActionController::Cookies

    before_action :authorized

    private

    def current_teacher
        @current_teacher = Teacher.find_by(id: session[:teacher_id])
    end

    def current_student
        @current_student = Student.find_by(id: session[:student_id])
    end

    def logged_in?
        !!current_teacher || !!current_student
    end

    def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end
end
