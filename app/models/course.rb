class Course < ApplicationRecord
  belongs_to :coding_class
  belongs_to :trimester
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :lessons 
  has_many :submissions
  delegate :title, to: :coding_class

  def student_email_list
    students.pluck(:email)
  end
end