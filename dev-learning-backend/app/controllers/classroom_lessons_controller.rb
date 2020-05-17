class ClassroomLessonsController < ApplicationController

    def add_lesson_classroom
        classroom_lesson = ClassroomLesson.create(
            classroom_id: params[:classroom_id],
            lesson_id: params[:lesson_id]
        )
        render json: classroom_lesson
    end
end
