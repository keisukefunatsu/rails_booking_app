class UsersController < ApplicationController
  before_action :authenticate_api, only: [:index, :show, :update, :destroy]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @user = @current_user
    render :index, formats: :json, handlers: 'jbuilder'
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @current_user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    return render json: { message: 'You are not permitted this operation.' }, status: :forbidden unless @user == @current_user 
    if @user.update(user_params)
      render json: @user, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    return render json: { message: 'You are not permitted this operation.' }, status: :forbidden unless @user == @current_user 
    if @user.destroy
      render json: @user, status: 204
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end
end
