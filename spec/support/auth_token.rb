shared_context 'auth_token' do
  let!(:user) {create(:test_user)}
  before do 
    post '/authenticate', params: {email: user.email, password: user.password} 
  end
  let!(:auth_token) { JSON.parse(response.body)['auth_token'] } 
  let!(:auth_header) do
    { headers: 
      { Authorization: JSON.parse(response.body)['auth_token'] } 
    }
  end
end