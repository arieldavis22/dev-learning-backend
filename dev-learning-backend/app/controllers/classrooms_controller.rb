class ClassroomsController < ApplicationController

    def new_classroom
        user = User.find_by(id: params[:teacher_id])

        if user
            name = params[:name]
            new_classroom = Classroom.create(teacher_id: user.id, name: name)
            render json: user
        end
    end

    def all_classrooms
        user = User.find_by(id: params[:id])
        if user
            user_classrooms = Classroom.all.select { |classroom| classroom.teacher_id == user.id }
            render json: user_classrooms
        else
            render json: { message: 'Please log in' }, status: :unauthorized
        end
    end

end
