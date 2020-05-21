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

    def check_code
        encoded_code = Base64.encode64(params[:code])
        req = RestClient.post(
            'https://api.judge0.com/submissions', 
            {'source_code' => encoded_code, 'language_id' => 72}, 
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

        if JSON.parse(decoded_code) == params[:return_value]
            render json: {message: "Correct"}
        else
            render json: {message: "Incorrect"}
        end

    end

    
    def test_code
        encoded_code = Base64.encode64(params[:code])
        req = RestClient.post(
            'https://api.judge0.com/submissions', 
            {'source_code' => encoded_code, 'language_id' => 72}, 
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


        render json: decoded_code

    end
end
