require 'rails_helper'
require 'jwt'
describe "Login with post data", :type => :request do
  include_context 'auth_token'
  it 'returns auth_token' do
    expect(response).to have_http_status(:success)
    expect(auth_token).not_to eq(nil)
  end
  it 'can get auth_token and use it to access controllers' do
    get '/users.json', headers: { Authorization: auth_token }
    expect(response).to have_http_status(:success)
  end
  
  it 'fails to access with expired token' do
    travel_to 25.hours.from_now do
      get '/users.json', headers: { Authorization: auth_token }
      expect(response).to have_http_status(:unauthorized)
    end
  end
  
  it 'fails to access with old token' do
    # get different token
    travel_to 1.hours.from_now do
      post '/authenticate', params: {email: login_user.email, password: login_user.password} 
      get '/users.json', headers: { Authorization: auth_token }
      expect(response).to have_http_status(:unauthorized)
    end
  end
  
  it 'can access with renewed token' do 
    post '/authenticate', params: {email: login_user.email, password: login_user.password} 
    renewed_auth_token = JSON.parse(response.body)['auth_token'] 
    get '/users.json', headers: { Authorization: renewed_auth_token }
    expect(response).to have_http_status(:success)
  end
  
  
  it 'fails to access controllers without Authorization header' do
    get '/users.json'
    expect(response).to have_http_status(:forbidden)
  end
end