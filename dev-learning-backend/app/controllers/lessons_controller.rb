class LessonsController < ApplicationController

    def all_lessons
        lessons = Lesson.all.select { |lesson| lesson.teacher_id == params[:teacher_id] }
        render json: lessons
    end

    def create_lesson
        lesson = Lesson.create(
            title: params[:title],
            points: params[:points_worth],
            deadline: params[:deadline],
            return_value: params[:return_value],
            description: params[:description],
            boilerplate: params[:boilerplate],
            teacher_id: params[:teacher_id]
        )
        render json: lesson
    end
end
