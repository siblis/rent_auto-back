require 'rails_helper'

RSpec.describe "RentalPlans", type: :request do
  describe "GET /rental_plans" do
    it "works! (now write some real specs)" do
      get rental_plans_path
      expect(response).to have_http_status(200)
    end
  end
end
