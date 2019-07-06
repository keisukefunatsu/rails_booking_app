require "rails_helper"

RSpec.describe MembersRolesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/members_roles").to route_to("members_roles#index")
    end

    it "routes to #show" do
      expect(:get => "/members_roles/1").to route_to("members_roles#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/members_roles").to route_to("members_roles#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/members_roles/1").to route_to("members_roles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/members_roles/1").to route_to("members_roles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/members_roles/1").to route_to("members_roles#destroy", :id => "1")
    end
  end
end
