class RegisterController < ApplicationController
  def index
    if params[:password] == params[:password_confirmation]
      user = User.new(register_params)
      if user.save
        render json: { status: 'ok', message: 'user successfully created' }, status: :ok
      else
        render json: user.errors, status: :forbidden
      end
    else
      render json: {status: 'forbidden', message: 'parameter missing'}, status: :forbidden
    end
  end

  def activate_account
    begin
      activation_token = params[:register][:activation_token]
      user = User.find_by(activation_token: activation_token)
      if user.update(activated: true) && user.activated == false
        render json: { status: 'ok', message: 'activated' }, status: :ok
      end
    rescue 
      render json: { status: 'forbidden', message: 'something wrong' }, status: :forbidden
    end
  end

  private 
  def register_params
    params.require(:register).permit(:name, :email, :password, :password_confirmation, :activation_token)
  end
end

