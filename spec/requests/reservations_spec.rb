require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  include_context 'auth_token'
  let!(:group) { Group.find_by(user_id: login_user.id) }
  let!(:space) { Space.find_by(group_id: group.id) }
  let!(:member) { Member.find_by(user_id: login_user.id) }
  let!(:reservation) { Reservation.find_by(space_id: space.id) }
  describe "GET /reservations" do
    it "returns 200" do
      get space_reservations_path(space.id), headers: { Authorization: auth_token }
      expect(response).to have_http_status(200)
    end
    it "can see " do
    end
  end
  describe "create" do
    it "can create reservation" do
      reservation_params = {
        reservation: {
          space_id: space.id,
          member_id: member.id,
          start_at: DateTime.now,
          end_at: DateTime.now + 1.hour,
          note: "4/3 英語上級"
        }
      }
      
      expect { post space_reservations_path(space.id), headers: { Authorization: auth_token }, params: reservation_params }.to change(Reservation, :count).by(1)
      expect(response).to have_http_status(:success)
    end
    it "can not create other user's reservation" do
      group = other_user.groups.first
      space = Space.find_by(group_id: group.id)
      reservation_params = {
        reservation: {
          space_id: space.id,
          member_id: member.id,
          start_at: DateTime.now,
          end_at: DateTime.now + 1.hour,
          note: "4/3 英語上級"
        }
      }
      post space_reservations_path(space.id), headers: { Authorization: auth_token }, params: reservation_params
      expect(response).to have_http_status(:forbidden)
    end
  end
  describe "edit" do
    it "can edit reservation" do
      reservation_params = {
        reservation: {
          space_id: space.id,
          member_id: member.id,
          start_at: DateTime.now,
          end_at: DateTime.now + 1.hour,
          note: "4/3 英語上級2"
        }
      }
      put space_reservation_path(space.id, reservation.id), headers: { Authorization: auth_token }, params: reservation_params
      expect(response).to have_http_status(:success)
    end
    it "can't edit other user's reservation"  do
      group = other_user.groups.first
      space = Space.find_by(group_id: group.id)
      member = Member.find_by(user_id: other_user.id)
      reservation = Reservation.find_by(member_id: member.id)
      reservation_params = {
        reservation: {
          space_id: space.id,
          member_id: member.id,
          start_at: DateTime.now,
          end_at: DateTime.now + 1.hour,
          note: "4/3 英語上級"
        }
      }
      reservation = Reservation.find_by(space_id: space.id)
      put space_reservation_path(space.id, reservation.id), headers: { Authorization: auth_token }, params: reservation_params
      expect(response).to have_http_status(:forbidden)
    end
  end
  describe "delete" do
    it "can not delete other user's reservation" do
      group = other_user.groups.first
      space = Space.find_by(group_id: group.id)
      member = Member.find_by(user_id: other_user.id)
      reservation = Reservation.find_by(member_id: member.id)
      delete space_reservation_path(space.id, reservation.id), headers: { Authorization: auth_token }
      expect(response).to have_http_status(:forbidden)
    end
    it "can delete reservation" do
      expect{ delete space_reservation_path(space.id, reservation.id), headers: { Authorization: auth_token } }.to change(Reservation, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
