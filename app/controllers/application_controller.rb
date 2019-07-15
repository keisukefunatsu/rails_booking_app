class ApplicationController < ActionController::API
  def authenticate_api
    # # Check if Authorization header exists
    if request.headers['Authorization'].present?
      sent_token = request.headers['Authorization']
      begin
        decoded_token = JWT.decode(sent_token, Rails.application.credentials.secret_key_base)[0]
        user_id = decoded_token['user_id']
        expire_at = decoded_token['expire_at']
        @current_user = User.find(user_id)
        current_token = @current_user.login_logs.last.auth_token
        raise 'token is old' unless current_token == sent_token
        raise 'token expired' unless expire_at > Time.now 
      rescue
        render status: 401, json: 
          {
            'status' => 'unauthorized', 
            'message' => 'Token is not valid or expired, please get token again' 
            
          }
      end
    else
      render status: 403, json: 
      {
        'status' => 'forbidden', 
        'message' => 'Authorization header is missing' 
      }
    end
  end
end
