require 'rails_helper'

RSpec.describe "Groups", type: :request do
  include_context 'auth_token'
  describe "GET /groups" do
    it "works! (now write some real specs)" do
      get groups_path, headers: {Authorization: auth_token}
      expect(response).to have_http_status(200)
    end
  end
  describe "create" do
    it "can create group" do
      group_params = {
        group: {
          user_id: login_user.id,
          name: "英語教室",
          note: "初級者〜中級者を対象とした英語教室です"
        }
      }
      expect{ post groups_path, headers: { Authorization: auth_token }, params: group_params }.to change(Group, :count).by(1)
      expect(response).to have_http_status(:success)
    end
    it "can not create other user's group"  do
      group_params = {
        group: {
          user_id: other_user.id,
          name: "英語教室",
          note: "初級者〜中級者を対象とした英語教室です"
        }
      }
      group = Group.find_by(user_id: other_user.id)
      post groups_path, headers: { Authorization: auth_token }, params: group_params
      expect(response).to have_http_status(:forbidden)
    end
  end
  describe "edit" do
    it "can edit group" do
      group_params = {
        group: {
          user_id: login_user.id,
          name: "英語教室",
          note: "初級者〜中級者を対象とした英語教室です"
        }
      }
      group = Group.find_by(user_id: login_user.id)
      put group_path(group.id), headers: { Authorization: auth_token }, params: group_params
      expect(response).to have_http_status(:success)
    end
    it "can not edit other user's group"  do
      group_params = {
        group: {
          user_id: login_user.id,
          name: "英語教室",
          note: "初級者〜中級者を対象とした英語教室です"
        }
      }
      group = Group.find_by(user_id: other_user.id)
      put group_path(group.id), headers: { Authorization: auth_token }, params: group_params
      expect(response).to have_http_status(:forbidden)
    end
  end
  describe "delete" do
    it "can not delete other user's group" do
      group = Group.find_by(user_id: other_user.id)
      delete group_path(group.id), headers: { Authorization: auth_token }
      expect(response).to have_http_status(:forbidden)
    end
    it "can delete group" do
      group = Group.find_by(user_id: login_user.id)
      expect{ delete group_path(group.id), headers: { Authorization: auth_token } }.to change(Group, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
