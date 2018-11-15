require "rails_helper"

RSpec.describe LocalitiesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/localities").to route_to("localities#index")
    end

    it "routes to #show" do
      expect(:get => "/localities/1").to route_to("localities#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/localities").to route_to("localities#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/localities/1").to route_to("localities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/localities/1").to route_to("localities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/localities/1").to route_to("localities#destroy", :id => "1")
    end
  end
end
