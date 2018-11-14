require "rails_helper"

RSpec.describe RentalPlansController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/rental_plans").to route_to("rental_plans#index")
    end

    it "routes to #show" do
      expect(:get => "/rental_plans/1").to route_to("rental_plans#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/rental_plans").to route_to("rental_plans#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/rental_plans/1").to route_to("rental_plans#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/rental_plans/1").to route_to("rental_plans#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rental_plans/1").to route_to("rental_plans#destroy", :id => "1")
    end
  end
end
