class Submission < ApplicationRecord
  belongs_to :course
  belongs_to :lesson
  belongs_to :enrollment
  belongs_to :mentor, optional: true
end

