require 'rails_helper'

RSpec.describe "Courses", type: :request do
  describe "GET /courses/:id" do
    before do
      coding_class = CodingClass.create!(title: "Intro to Ruby")
      trimester = Trimester.create!(
        term: 'Current',
        year: Date.today.year.to_s,
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )
      @course = Course.create!(coding_class: coding_class, trimester: trimester, max_enrollment: 10)

      student = Student.create!(first_name: "John", last_name: "Doe", email: "john@example.com")
      Enrollment.create!(course: @course, student: student)
    end

    it "shows the course title" do
      get course_path(@course)
      expect(response.body).to include(@course.coding_class.title)
    end

    it "shows enrolled student names" do
      get course_path(@course)
      expect(response.body).to include("John Doe")
    end
  end
end
