class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update, :destroy]
  before_action :authenticate_api, only: [:index, :show, :create, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    render json: Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # POST /groups
  # POST /groups.json
  def create
    unless params[:group][:user_id].to_i == @current_user.id
      return render json: { message: 'You are not permitted to perform this operation.' }, status: :forbidden
    end
    @group = Group.new(group_params)
    if @group.save
      render json: @group, status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    unless @group.user_id == @current_user.id
      return render json: { message: 'You are not permitted to perform this operation.' }, status: :forbidden
    end
    if @group.update(group_params)
      render json: @group, status: :ok, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    unless @group.user_id == @current_user.id
      return render json: { message: 'You are not permitted to perform this operation.' }, status: :forbidden
    end
    if @group.destroy
      render json: { message: 'successfully deleted.' }, status: 204
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:user_id, :name, :note)
    end
end
