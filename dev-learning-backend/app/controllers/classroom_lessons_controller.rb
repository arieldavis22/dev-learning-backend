class ClassroomLessonsController < ApplicationController

    def find_classroom_lessons
        user = User.find_by(id: params[:student_id])
        if user
            classroom_lessons = ClassroomLesson.select {|classroom| classroom.classroom_id == params[:classroom_id]}
            lessons = []
            classroom_lessons.map {|classroom| lessons << Lesson.find_by(id: classroom.lesson_id)}
            not_complete = lessons.select {|lesson| !lesson.users.include?(user)}
    
            # byebug
    
            render json: not_complete
        else
            render json: []
        end
    end

    def find_classroom_lessons_all
        classroom_lessons = ClassroomLesson.select {|classroom| classroom.classroom_id == params[:classroom_id]}
        lessons = []
        classroom_lessons.map {|classroom| lessons << Lesson.find_by(id: classroom.lesson_id)}
        
        render json: lessons
    end

    def add_lesson_classroom
        classroom_lesson = ClassroomLesson.create(
            classroom_id: params[:classroom_id],
            lesson_id: params[:lesson_id]
        )
        render json: classroom_lesson
    end
end
