class AuthenticateController < ApplicationController
  def index
    @current_user = User.find_by(email: params[:email])
    if @current_user && @current_user.authenticate(params[:password])
      encoded_token = JWT.encode(
        { user_id: @current_user.id, expire_at: 24.hours.from_now},
        Rails.application.credentials.secret_key_base
      )
      @current_user.update(auth_token: encoded_token)
      render status: 200, json: {'status' => 'success', "auth_token" => encoded_token }
    else 
      render status: 403, json: {'status' => 'forbidden', 'message' => 'Authentication Failed'}
    end
  end
end
