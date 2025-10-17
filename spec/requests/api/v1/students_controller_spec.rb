require 'rails_helper'

RSpec.describe "Api::V1::Students", type: :request do
  describe "POST /api/v1/students" do
    let(:valid_attributes) do
      {
        student: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: 'validstudent@example.com'
        }
      }
    end

    let(:invalid_attributes) do
      {
        student: {
          first_name: "",
          last_name: "",
          email: ""
        }
      }
    end

    context "with valid parameters" do
      it "creates a new student" do
        expect {
          post '/api/v1/students', params: valid_attributes
        }.to change(Student, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['student']['email']).to eq("validstudent@example.com")
      end
    end

    context "with invalid parameters" do
      it "does not create a student and returns errors" do
        expect {
          post '/api/v1/students', params: invalid_attributes
        }.not_to change(Student, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("errors")
        expect(json_response["errors"]).to include("First name can't be blank")
      end
    end
  end
end

