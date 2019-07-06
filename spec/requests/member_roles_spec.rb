require 'rails_helper'

RSpec.describe "MemberRoles", type: :request do
  describe "GET /member_roles" do
    it "works! (now write some real specs)" do
      get member_roles_path
      expect(response).to have_http_status(200)
    end
  end
end
