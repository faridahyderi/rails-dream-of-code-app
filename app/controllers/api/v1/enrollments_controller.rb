class Api::V1::EnrollmentsController < ApplicationController
    def index
      course = Course.find(params[:course_id])
      
      enrollments_hash = {
        enrollments: course.enrollments.includes(:student).map do |enrollment|
          {
            id: enrollment.student.id,
            studentId: enrollment.student.id,
            studentFirstName: enrollment.student.first_name,
            studentLastName: enrollment.student.last_name,
            finalGrade: enrollment.final_grade || ""
          }
        end
      }
  
      render json: enrollments_hash, status: :ok
    end
  end
  
  
  