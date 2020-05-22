class ReportsController < ApplicationController

    def new_report
        report = Report.create(
            lesson_id: params[:lesson_id],
            title: params[:title],
            message: params[:message]
        )
        render json: {message: "Report submitted"}
    end

    def reports_for_lesson
        lesson = Lesson.find_by(id: params[:lesson_id])
        render json: lesson.reports
    end

    def delete_report
        report = Report.find_by(id: params[:report_id])
        report.destroy
        report.save
        render json: {message: "Report removed"}
    end
end
