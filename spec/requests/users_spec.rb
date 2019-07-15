require 'rails_helper'

RSpec.describe UsersController, type: :request do

  include_context 'auth_token'
  describe "index" do
    it "returns http success code" do
      get '/users.json', headers: {Authorization: auth_token}
      expect(response).to have_http_status(:success)
    end
    it "returns only login user" do
      get '/users.json', headers: {Authorization: auth_token}
      body = JSON.parse(response.body)
      pp body
      expect(body['user']['id']).to eq(login_user.id)
      expect(body['user']['name']).to eq(login_user.name)
    end
  end

  describe "create" do
    it "can create user" do
      user_params = {
        user: 
          {
            email: 'some@email.com', 
            name: 'test user', 
            password: 'password1234',
            password_confirmation: 'password1234'
          }
      }
      expect{ post '/users.json', params: user_params }.to change(User, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end
  
  describe "edit" do
    it "can edit user" do
      user_params = {
        user: 
          {
            email: 'some@email.com', 
            name: 'edited user', 
            password: 'password1234',
            password_confirmation: 'password1234'
          }
      }
      put "/users/#{login_user.id}.json", headers: {Authorization: auth_token}, params: user_params
      expect(response).to have_http_status(:success)
    end
    it 'can not edit other user'  do
      user_params = {
        user: 
          {
            email: 'some@email.com', 
            name: 'edited user', 
            password: 'password1234',
            password_confirmation: 'password1234'
          }
      }
      put "/users/#{other_user.id}.json", headers: {Authorization: auth_token}, params: user_params
      expect(response).to have_http_status(:forbidden)
    end
  end
  describe "delete" do
    it "can not delete other user" do
      delete "/users/#{other_user.id}.json", headers: {Authorization: auth_token}
      expect(response).to have_http_status(:forbidden)
    end
    it "can delete user" do
      expect{ delete "/users/#{login_user.id}.json", headers: {Authorization: auth_token}}.to change(User, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
