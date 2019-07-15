class RegisterController < ApplicationController
  def index
    
  end

  def confirmation
  end

  private 
  def register_params
    params.require(:register).permit(:name, :email, :password, :password_confirmation)
  end
end
