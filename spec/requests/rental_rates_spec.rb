require 'rails_helper'

RSpec.describe "RentalRates", type: :request do
  describe "GET /rental_rates" do
    it "works! (now write some real specs)" do
      get rental_rates_path
      expect(response).to have_http_status(200)
    end
  end
end
