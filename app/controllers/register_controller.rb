class RegisterController < ApplicationController
  def index
    if params[:password] == params[:password_confirmation]
      user = User.new(register_params)
      if user.save
        render json: { status: 'ok', message: 'user successfully created' }, status: :ok
      else
        render json: { status: 'unprocessable_entity', message: 'failed to create user', errors: user.errors }, status: :unprocessable_entity
      end
    else
      render json: {message: 'some parameters are missing'}, status: :unprocessable_entity
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
      render json: { status: 'unprocessable_entity', message: 'something wrong' }, status: :unprocessable_entity
    end
  end

  private 
  def register_params
    params.require(:register).permit(:name, :email, :password, :password_confirmation, :activation_token)
  end
end

