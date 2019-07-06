shared_context 'auth_token' do
  let!(:login_user) {create(:login_user)}
  let!(:other_user) {create(:other_user)}
  before do 
    post '/authenticate', params: {email: login_user.email, password: login_user.password} 
  end
  let!(:auth_token) { JSON.parse(response.body)['auth_token'] } 
  let!(:auth_header) do
    { headers: 
      { Authorization: JSON.parse(response.body)['auth_token'] } 
    }
  end
end