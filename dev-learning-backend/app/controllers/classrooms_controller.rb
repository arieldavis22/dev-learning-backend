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
            render json: [], status: :unauthorized
        end
    end

    def all_classrooms_without_lesson
        user = User.find_by(id: params[:id])
        if user
            #loop through classroomlesson
            #take out classrooms that match lesson_id
            #return classrooms

            # all_classroom_lessons = ClassroomLesson.all.select { |cl| cl.lesson_id != params[:lesson_id] }
            # classrooms = []
            # all_classroom_lessons.map {|cl| classrooms << Classroom.find_by(id: cl.classroom_id)}
            # # byebug
            # user_classrooms = classrooms.select { |classroom| classroom.teacher_id == user.id}

            # render json: user_classrooms
            lesson = Lesson.find_by(id: params[:lesson_id])

            user_classrooms = Classroom.all.select { |classroom| classroom.teacher_id == user.id }
            classes_not = user_classrooms.select { |classroom| !classroom.lessons.include?(lesson) }
            # byebug
            render json: classes_not
        else
            render json: [], status: :unauthorized
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
