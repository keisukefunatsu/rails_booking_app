require 'rails_helper'

RSpec.describe "MembersRoles", type: :request do
  describe "GET /members_roles" do
    it "works! (now write some real specs)" do
      get members_roles_path
      expect(response).to have_http_status(200)
    end
  end
end
