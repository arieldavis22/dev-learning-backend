require 'json'
class StudentClassroomsController < ApplicationController

    def delete_student_in_class
        student_classroom = StudentClassroom.find_by(classroom_id: params[:classroom_id], student_id: params[:student_id])

        if student_classroom
            student_classroom.destroy
            student_classroom.save
            render json: {message: "Student Removed"}
        else
            render json: {message: "Student not found"}
        end
    end

    def add_student_to_class
        classroom = params[:classroom_id]
        student = params[:student_id]
        student_classroom = StudentClassroom.create(classroom_id: classroom, student_id: student, point_average: 100)
        render json: student_classroom
    end

    def find_student_classrooms
        student_classrooms = StudentClassroom.all.select {|classroom| classroom.student_id == params[:student_id]}
        classroom_arr = []
        student_classrooms.select { |classroom| classroom_arr << Classroom.find_by(id: classroom.classroom_id) }
        render json: classroom_arr
    end

    def find_students_in_class
        student_classrooms = StudentClassroom.all.select {|classroom| classroom.classroom_id == params[:classroom_id]}
        student_arr = []
        student_gpas = []
        student_classrooms.select { |classroom| student_arr << User.find_by(id: classroom.student_id) }
        student_classrooms.map { |classroom| student_gpas << classroom.point_average }
        json_users = UserSerializer.new(student_arr).serialized_json
        render json: {
            users: JSON.parse(json_users),
            gpas: student_gpas
        }
    end

    def find_student_gpa
        student_classroom = StudentClassroom.find_by(classroom_id: params[:classroom_id], student_id: params[:student_id])

        if student_classroom
            render json: student_classroom.point_average
        else
            render json: {message: "No GPA"}
        end
    end

    def correct_answer
        student_classroom = StudentClassroom.find_by(classroom_id: params[:classroom_id], student_id: params[:student_id])
        if params[:points] < 10
            increase = 1
        else
            increase = ((params[:points] * 10) / 100)
        end

        if student_classroom
            student_classroom.point_average += increase
            student_classroom.save
            render json: {message: "POINT AVERAGE INCREASED"}
        else
            render json: {message: "NO POINT AVERAGE"}
        end
    end

    def wrong_answer
        student_classroom = StudentClassroom.find_by(classroom_id: params[:classroom_id], student_id: params[:student_id])
        if params[:points] < 10
            decrease = 1
        else
            decrease = ((params[:points] * 10) / 100)
        end

        if student_classroom
            student_classroom.point_average -= decrease
            student_classroom.save
            render json: {message: "POINT AVERAGE DECREASED"}
        else
            render json: {message: "NO POINT AVERAGE"}
        end
    end
    
end
