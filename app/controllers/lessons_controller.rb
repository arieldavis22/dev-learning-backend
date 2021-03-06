require 'rest-client'
require 'json'
require "base64"

class LessonsController < ApplicationController

    def all_lessons
        lessons = Lesson.all.select { |lesson| lesson.teacher_id == params[:teacher_id] }
        classroom_lessons = ClassroomLesson.all.where(classroom_id: params[:classroom_id])
        already_in = []
        classroom_lessons.select{|lesson| already_in << Lesson.find_by(id: lesson.lesson_id)}
        # byebug
        not_in = lessons.reject{|lesson| already_in.include? lesson }
        render json: not_in
    end

    # def followed_lessons
    #     classroom_lessons = ClassroomLesson.all.where(lesson_id: params[:lesson_id])
    #     # already_in = []
    #     already_in = classroom_lessons.map{|classroom| classroom.classroom_id == params[:classroom_id]}

    #     if(already_in.include?(true))
    #         render json: true
    #     else
    #         render json: false
    #     end
    # end


    def create_lesson
        lesson = Lesson.create(
            title: params[:title],
            points: params[:points_worth],
            deadline: params[:deadline],
            return_value: params[:return_value],
            description: params[:description],
            boilerplate: params[:boilerplate],
            teacher_id: params[:teacher_id],
            language: params[:language]
        )
        render json: lesson
    end

    def check_code
        encoded_code = Base64.encode64(params[:code])
        req = RestClient.post(
            'https://api.judge0.com/submissions', 
            {'source_code' => encoded_code, 'language_id' => params[:lesson_lang]}, 
            {params: {'base64_encoded' => true, 'wait' => false}}
        )

        token = req.to_json

        uri = RestClient::Resource.new("https://api.judge0.com/submissions/")

        sleep(1)

        code_back = uri[token[14...50]].get(
            {params: {'base64_encoded' => true}}
        )

        stdout = JSON.parse(code_back)["stdout"]

        decoded_code = Base64.decode64(stdout)

        # byebug

        Complete.create(lesson_id: params[:lesson_id], student_id: params[:student_id], done: true)

        if decoded_code.match(params[:return_value])[0] == params[:return_value]
            render json: {message: "Correct"}
        else
            render json: {message: "Incorrect"}
        end

    end

    
    def test_code
        encoded_code = Base64.encode64(params[:code])
        # byebug
        req = RestClient.post(
            'https://api.judge0.com/submissions', 
            {'source_code' => encoded_code, 'language_id' => params[:lesson_lang]}, 
            {params: {'base64_encoded' => true, 'wait' => false}}
        )

        token = req.to_json

        uri = RestClient::Resource.new("https://api.judge0.com/submissions/")

        sleep(1)

        code_back = uri[token[14...50]].get(
            {params: {'base64_encoded' => true}}
        )

        stdout = JSON.parse(code_back)["stdout"]

        decoded_code = Base64.decode64(stdout)

        # byebug
        
        if params[:lesson_lang] == 63
            render json: decoded_code.to_json
        else
            render json: decoded_code.to_json
        end
    end

    def search_stack
        uri = RestClient::Resource.new("https://api.stackexchange.com/2.2/search")

        stack_info = uri.get(
            {params: {
                'order' => 'desc',
                'sort' => 'relevance',
                'intitle' => params[:search],
                'site' => 'stackoverflow'
            }}
        )

        render json: stack_info
    end

    def remove_lesson
        ClassroomLesson.where(lesson_id: params[:lesson_id]).destroy_all
        lesson = Lesson.find_by(id: params[:lesson_id]).destroy
        lesson.save
        
        render json: {message: "Lesson Removed"}
    end
end
