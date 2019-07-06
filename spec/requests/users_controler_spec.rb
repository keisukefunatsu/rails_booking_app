require 'rails_helper'

RSpec.describe UsersController, type: :request do

  include_context 'auth_token'
  describe "GET #index" do
    it "returns http success" do
      get '/users.json', headers: {Authorization: auth_token}
      expect(response).to have_http_status(:success)
    end
    it "returns only login user" do
      get '/users.json', headers: {Authorization: auth_token}
      body = JSON.parse(response.body)
      expect(body.length).to eq(1)
      expect(body['user']['id']).to eq(login_user.id)
    end
  end

  describe "POST #create" do
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
  
  describe "POST #edit" do
    it "can edit user" do
      user_params = {
        user: 
          {
            email: 'some@email.com', 
            name: 'edited user', 
            password: 'password1234',
            password_confirmation: 'password1234',
            admin: true
          }
      }
      put "/users/#{login_user.id}.json", headers: {Authorization: auth_token}, params: user_params
      expect(response).to have_http_status(:success)
    end
  end
end
