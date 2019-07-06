require 'rails_helper'
require 'jwt'
describe "Login with post data", :type => :request do
  include_context 'auth_token'
  it 'returns auth_token' do
    expect(response).to have_http_status(:success)
    expect(auth_token).not_to eq(nil)
  end
  it 'can get auth_token and use it to access controllers' do
    get '/users.json', headers: {Authorization: auth_token}
    expect(response).to have_http_status(:success)
  end
  
  it 'fails to access with expired token' do
    travel_to 25.hours.from_now do
      get '/users.json', headers: {Authorization: auth_token}
      expect(response).to have_http_status(:forbidden)
    end
  end
  
  it 'fails to access controllers without Authorization header' do
    get '/users.json'
    expect(response).to have_http_status(:forbidden)
  end
end