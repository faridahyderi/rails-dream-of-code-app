class Trimester < ApplicationRecord
  has_many :courses

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :application_deadline, presence: true

  scope :current, -> { where("start_date <= ? AND end_date >= ?", Date.today, Date.today).first }
  scope :upcoming, -> { where("start_date > ?", Date.today).order(:start_date).first }
end
