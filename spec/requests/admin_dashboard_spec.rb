require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /dashboard' do
    before do
      coding_class = CodingClass.create!(title: "Intro to Ruby")

      current_trimester = Trimester.create!(
        term: 'Current term',
        year: Date.today.year.to_s,
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )

      Course.create!(trimester: current_trimester, coding_class: coding_class)

      Trimester.create!(
        term: 'Past term',
        year: (Date.today.year - 1).to_s,
        start_date: Date.today - 1.year,
        end_date: Date.today - 6.months,
        application_deadline: Date.today - 1.year
      )

      Trimester.create!(
        term: 'Upcoming term',
        year: Date.today.year.to_s,
        start_date: Date.today + 2.months, # within 6 months
        end_date: Date.today + 5.months,
        application_deadline: Date.today + 1.month
      )
    end

    it 'displays the current trimester' do
      get "/dashboard"
      expect(response.body).to include("Current term - #{Date.today.year}")
    end

    it 'displays the upcoming trimester' do
      get "/dashboard"
      expect(response.body).to include("Upcoming term - #{Date.today.year}")
    end
  end
end
