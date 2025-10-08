class Api::V1::CoursesController < ApplicationController
    def index
      today = Date.today
      current_trimester = Trimester.where("start_date <= ? AND end_date >= ?", today, today).first
  
      courses = Course.where(trimester_id: current_trimester.id)
  
      courses_hash = {
        courses: courses.map do |course|
          {
            id: course.id,
            title: course.title,
            application_deadline: course.trimester.application_deadline,
            start_date: course.trimester.start_date,
            end_date: course.trimester.end_date
          }
        end
      }
  
      render json: courses_hash, status: :ok
    end
  end
  
  
  
  