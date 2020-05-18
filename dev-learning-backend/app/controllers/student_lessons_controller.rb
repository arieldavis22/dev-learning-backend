require 'rest-client'
require 'json'
require "base64"

class StudentLessonsController < ApplicationController

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

        if decoded_code.include? params[:return_value]
            render json: {message: "Correct"}
        else
            render json: {message: "Incorrect"}
        end

    end
end
