# require 'rails_helper'

# RSpec.describe "Reservations", type: :request do
# include_context 'auth_token'
#   describe "GET /reservations" do
#     it "returns 200" do
#       get reservations_path, headers: { Authorization: auth_token }
#       expect(response).to have_http_status(200)
#     end
#   end
#   describe "create" do
#     it "can create reservation" do
#       reservation_params = {
#         reservation: {
#           space_id: login_user.groups.first.id,
#           start_at: DateTime.now,
#           end_at: DateTime.now + 1.hour,
#           note: "4/3 英語上級"
#         }
#       }
#       expect{ post reservations_path, headers: { Authorization: auth_token }, params: reservation_params }.to change(Reservation, :count).by(1)
#       expect(response).to have_http_status(:success)
#     end
#     it "can not create other user's reservation" do
#       group = other_user.groups.first
#       reservation_params = {
#         reservation: {
#           group_id: group.id,
#           start_at: DateTime.now,
#           end_at: DateTime.now + 1.hour,
#           note: "4/3 英語上級"
#         }
#       }
#       post reservations_path, headers: { Authorization: auth_token }, params: reservation_params
#       expect(response).to have_http_status(:forbidden)
#     end
#   end
#   describe "edit" do
#     it "can edit reservation" do
#       group = login_user.groups.first
#       reservation_params = {
#         reservation: {
#           group_id: group.id,
#           start_at: DateTime.now,
#           end_at: DateTime.now + 1.hour,
#           note: "4/3 英語上級"
#         }
#       }
#       reservation = reservation.find_by(group_id: group.id)
#       put reservation_path(reservation.id), headers: { Authorization: auth_token }, params: reservation_params
#       expect(response).to have_http_status(:success)
#     end
#     it "can't edit other user's reservation"  do
#       group = other_user.groups.first
#       reservation_params = {
#         reservation: {
#           group_id: group.id,
#           start_at: DateTime.now,
#           end_at: DateTime.now + 1.hour,
#           note: "4/3 英語上級"
#         }
#       }
#       reservation = reservation.find_by(group_id: group.id)
#       put reservation_path(reservation.id), headers: { Authorization: auth_token }, params: reservation_params
#       expect(response).to have_http_status(:forbidden)
#     end
#   end
#   describe "delete" do
#     it "can not delete other user's reservation" do
#       reservation = Group.find_by(user_id: other_user.id)
#       delete reservation_path(reservation.id), headers: { Authorization: auth_token }
#       expect(response).to have_http_status(:forbidden)
#     end
#     it "can delete reservation" do
#       reservation = reservation.find_by(user_id: login_user.id)
#       expect{ delete reservation_path(group.id), headers: { Authorization: auth_token } }.to change(Reservation, :count).by(-1)
#       expect(response).to have_http_status(204)
#     end
#   end
# end
