class StudentClassroomsController < ApplicationController

    def add_student_to_class
        classroom = params[:classroom_id]
        student = params[:student_id]
        student_classroom = StudentClassroom.create(classroom_id: classroom, student_id: student)
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
        student_classrooms.select { |classroom| student_arr << User.find_by(id: classroom.student_id) }
        json_users = UserSerializer.new(student_arr).serialized_json
        render json: json_users
    end
    
end
