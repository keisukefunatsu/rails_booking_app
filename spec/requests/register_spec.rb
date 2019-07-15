require 'rails_helper'
require 'jwt'
describe "Register index", :type => :request do
  include_context 'auth_token'
  it 'can not register user when password confirmation is not correct' do
    register_params = {
      register: {
        name: 'sample_user',
        email: 'sample_user@example.com',
        password: '123123123',
        password_confirmation: '1231231234'
      }
    }
    post '/register', params: register_params
    expect(response).to have_http_status(:forbidden)
  end
  it 'can register user' do
    register_params = {
      register: {
        name: 'sample_user',
        email: 'sample_user@example.com',
        password: '123123123',
        password_confirmation: '123123123'
      }
    }
    post '/register', params: register_params
    expect(response).to have_http_status(:success)
  end
  it 'can not register user when parameter is missing' do
    register_params = {
      register: {
        name: 'sample_user',
        password: '123123123',
        password_confirmation: '123123123'
      }
    }
    post '/register', params: register_params
    expect(response).to have_http_status(:forbidden)
  end
end
describe "Register index", :type => :request do
    it 'can activate user' do
    register_params = {
      register: {
        name: 'sample_user',
        email: 'activate_user@example.com',
        password: '123123123',
        password_confirmation: '123123123'
      }
    }
    post '/register', params: register_params
    expect(response).to have_http_status(:success)
    user = User.find_by(email: 'activate_user@example.com')
    expect(user.activated).to eq(false)
    activation_token = user.activation_token
    post '/register/activate_account', params: {
      register: {
        activation_token: activation_token
        }
      }
    expect(response).to have_http_status(:success)
    user = User.find_by(email: 'activate_user@example.com')
    expect(user.activated).to eq(true)
  end
end