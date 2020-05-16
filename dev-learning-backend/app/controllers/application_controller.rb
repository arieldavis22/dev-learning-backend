class ApplicationController < ActionController::API
    include ActionController::Cookies

    before_action :authorized

    private 
    
    def current_user
        @current_user = User.find_by(id: session[:user_id])
    end
    
    def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless current_user
    end
end
