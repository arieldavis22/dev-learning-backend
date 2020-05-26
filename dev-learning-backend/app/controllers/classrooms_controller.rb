class ClassroomsController < ApplicationController

    def edit_classroom
        classroom = Classroom.find_by(id: params[:classroom_id])
        classroom.name = params[:name]
        classroom.save
        render json: classroom
    end

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

    def remove_classroom
        ClassroomLesson.where(classroom_id: params[:classroom_id]).destroy_all
        StudentClassroom.where(classroom_id: params[:classroom_id]).destroy_all
        classroom = Classroom.find_by(id: params[:classroom_id]).destroy
        classroom.save
        render json: {message: "Classroom Deleted"}
    end

end
