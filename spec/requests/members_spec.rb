require 'rails_helper'

RSpec.describe "Members", type: :request do
  include_context 'auth_token'
  describe "GET /members" do
    it "returns 200" do
      group = login_user.groups.first
      get group_members_path(group.id), headers: { Authorization: auth_token }
      expect(response).to have_http_status(200)
    end
  end
  
  describe "create" do
    it "can create member" do
      group = login_user.groups.first
      member_params = {
        member: {
          group_id: group.id,
          user_id: other_user.id,
        }
      }
      expect{ post group_members_path(group.id), headers: { Authorization: auth_token }, params: member_params }.to change(Member, :count).by(1)
      expect(response).to have_http_status(:success)
    end
    it "can not create other user's member" do
      group = other_user.groups.first
      member_params = {
        member: {
          group_id: group.id,
          user_id: other_user.id,
        }
      }
      post group_members_path(group.id), headers: { Authorization: auth_token }, params: member_params
      expect(response).to have_http_status(:forbidden)
    end
  end
  describe "edit" do
    it "can edit member" do
      group = login_user.groups.first
      member_params = {
        member: {
          group_id: group.id,
          user_id: other_user.id,
        }
      }
      member = Member.find_by(group_id: group.id)
      put group_member_path(group.id, member.id), headers: { Authorization: auth_token }, params: member_params
      expect(response).to have_http_status(:success)
    end
    it "can't edit other user's group's member"  do
      group = other_user.groups.first
      member_params = {
        member: {
          group_id: group.id,
          user_id: other_user.id,
        }
      }
      member = Member.find_by(group_id: group.id)
      put group_member_path(group.id, member.id), headers: { Authorization: auth_token }, params: member_params
      expect(response).to have_http_status(:forbidden)
    end
  end
  describe "delete" do
    it "can not delete other user's member" do
      member = Member.find_by(user_id: other_user.id)
      group = Group.find_by(user_id: other_user.id)
      delete group_member_path(group.id, member.id), headers: { Authorization: auth_token }
      expect(response).to have_http_status(:forbidden)
    end
    it "can delete member" do
      member = Member.find_by(user_id: login_user.id)
      group = Group.find_by(user_id: login_user.id)
      expect{ delete group_member_path(group.id, member.id), headers: { Authorization: auth_token } }.to change(Member, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
