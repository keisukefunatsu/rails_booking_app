require 'rails_helper'
require 'jwt'
describe "Login with post data", :type => :request do
  let!(:user) {create(:test_user)}
  before { post '/authenticate', params: {email: user.email, password: user.password} } 
  it 'returns auth_token' do
    expect(response).to have_http_status(:success)
    auth_token = JSON.parse(response.body)['auth_token']
    expect(auth_token).not_to eq(nil)
  end
  it 'cant get auth_token and use it to access controllers' do
    auth_token = JSON.parse(response.body)['auth_token']
    get '/users.json', headers: {Authorization: auth_token}
  end
  
  it 'fails to access with expired token' do
    travel_to 25.hours.from_now do
      auth_token = JSON.parse(response.body)['auth_token']
      get '/users.json', headers: {Authorization: auth_token}
      expect(response).to have_http_status(:forbidden)
    end
  end
  
  it 'fails to access controllers without Authorization header' do
    get '/users.json'
    expect(response).to have_http_status(:forbidden)
  end
  
end