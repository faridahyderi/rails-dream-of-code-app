require 'rails_helper'

RSpec.describe "Mentors", type: :request do
  describe "GET /mentors" do
    context 'mentors exist' do
      before do
        # Create some test mentor records
        Mentor.create!(first_name: "Mentor", last_name: "One", email: "one@example.com")
        Mentor.create!(first_name: "Mentor", last_name: "Two", email: "two@example.com")
      end

      it 'returns a page containing all mentor names' do
        get '/mentors'
        expect(response.body).to include('Mentor')
        expect(response.body).to include('One')
        expect(response.body).to include('Two')
      end
    end

    context 'no mentors exist' do
      it 'returns a page with only the title' do
        get '/mentors'
        expect(response.body).to include('Mentors')
        expect(response.body).not_to include('<div id="mentor_') # no mentor divs should appear
      end
    end
  end

  describe "GET /mentors/:id" do
    let!(:mentor) { Mentor.create!(first_name: "Mentor", last_name: "Show", email: "show@example.com") }

    it 'returns a page with the mentor details' do
      get "/mentors/#{mentor.id}"
      expect(response.body).to include('Mentor')
      expect(response.body).to include('Show')
      expect(response.body).to include('show@example.com')
    end
  end
end
