class ApplicationController < ActionController::API
  def authenticate_api
    # # Check if Authorization header exists
    if request.headers['Authorization'].present?
      sent_token = request.headers['Authorization']
      begin
        decoded_token = JWT.decode(sent_token, Rails.application.credentials.secret_key_base)[0]
        user_id = decoded_token['user_id']
        expire_at = decoded_token['expire_at']
        if expire_at > Time.now
          @current_user = User.find(user_id)
        else
          raise 'token expired'
        end
      rescue
        render status: 403, json: 
          {
            'status' => 'forbidden', 
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
