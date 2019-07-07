require 'rails_helper'

RSpec.describe "Spaces", type: :request do
  include_context 'auth_token'
  describe "GET /spaces" do
    it "works! (now write some real specs)" do
      get spaces_path, headers: { Authorization: auth_token }
      expect(response).to have_http_status(200)
    end
  end
  describe "create" do
    it "can create space" do
      space_params = {
        space: {
          group_id: login_user.groups.first.id,
          start_at: DateTime.now,
          end_at: DateTime.now + 1.hour,
          note: "4/3 英語上級"
        }
      }
      expect{ post spaces_path, headers: { Authorization: auth_token }, params: space_params }.to change(Space, :count).by(1)
      expect(response).to have_http_status(:success)
    end
    it "can not create other user's space" do
      group = other_user.groups.first
      space_params = {
        space: {
          group_id: group.id,
          start_at: DateTime.now,
          end_at: DateTime.now + 1.hour,
          note: "4/3 英語上級"
        }
      }
      post spaces_path, headers: { Authorization: auth_token }, params: space_params
      expect(response).to have_http_status(:forbidden)
    end
  end
  describe "edit" do
    it "can edit space" do
      group = login_user.groups.first
      space_params = {
        space: {
          group_id: group.id,
          start_at: DateTime.now,
          end_at: DateTime.now + 1.hour,
          note: "4/3 英語上級"
        }
      }
      space = Space.find_by(group_id: group.id)
      put space_path(space.id), headers: { Authorization: auth_token }, params: space_params
      expect(response).to have_http_status(:success)
    end
    it "can't edit other user's space"  do
      group = other_user.groups.first
      space_params = {
        space: {
          group_id: group.id,
          start_at: DateTime.now,
          end_at: DateTime.now + 1.hour,
          note: "4/3 英語上級"
        }
      }
      space = Space.find_by(group_id: group.id)
      put space_path(space.id), headers: { Authorization: auth_token }, params: space_params
      expect(response).to have_http_status(:forbidden)
    end
  end
  describe "delete" do
    it "can not delete other user's space" do
      space = Group.find_by(user_id: other_user.id)
      delete space_path(space.id), headers: { Authorization: auth_token }
      expect(response).to have_http_status(:forbidden)
    end
    it "can delete space" do
      space = Space.find_by(user_id: login_user.id)
      expect{ delete space_path(group.id), headers: { Authorization: auth_token } }.to change(Space, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
