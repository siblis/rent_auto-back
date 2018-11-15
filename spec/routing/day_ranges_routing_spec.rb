require "rails_helper"

RSpec.describe DayRangesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/day_ranges").to route_to("day_ranges#index")
    end

    it "routes to #show" do
      expect(:get => "/day_ranges/1").to route_to("day_ranges#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/day_ranges").to route_to("day_ranges#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/day_ranges/1").to route_to("day_ranges#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/day_ranges/1").to route_to("day_ranges#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/day_ranges/1").to route_to("day_ranges#destroy", :id => "1")
    end
  end
end
