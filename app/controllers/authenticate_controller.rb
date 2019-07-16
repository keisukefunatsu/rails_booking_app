class AuthenticateController < ApplicationController
  def index
    @current_user = User.find_by(email: params[:email])
    if @current_user && @current_user.authenticate(params[:password])
      encoded_token = JWT.encode(
        { user_id: @current_user.id, expire_at: 24.hours.from_now},
        Rails.application.credentials.secret_key_base
      )
      LoginLog.create(auth_token: encoded_token, user_id: @current_user.id)
      render status: 200, json: { status: 'success', auth_token: encoded_token }
    else 
      render status: 401, json: { status: 'unauthorized', message: 'Authentication Failed' }
    end
  end
end
