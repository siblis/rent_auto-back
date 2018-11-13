require "rails_helper"

RSpec.describe RentalRatesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/rental_rates").to route_to("rental_rates#index")
    end

    it "routes to #show" do
      expect(:get => "/rental_rates/1").to route_to("rental_rates#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/rental_rates").to route_to("rental_rates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/rental_rates/1").to route_to("rental_rates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/rental_rates/1").to route_to("rental_rates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rental_rates/1").to route_to("rental_rates#destroy", :id => "1")
    end
  end
end
