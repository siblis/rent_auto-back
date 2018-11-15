require "rails_helper"

RSpec.describe RentalPricesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/rental_prices").to route_to("rental_prices#index")
    end

    it "routes to #show" do
      expect(:get => "/rental_prices/1").to route_to("rental_prices#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/rental_prices").to route_to("rental_prices#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/rental_prices/1").to route_to("rental_prices#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/rental_prices/1").to route_to("rental_prices#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rental_prices/1").to route_to("rental_prices#destroy", :id => "1")
    end
  end
end
