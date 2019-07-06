class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :update, :destroy]
  before_action :authenticate_api, only: [:index, :show, :create, :update, :destroy]
  # GET /spaces
  # GET /spaces.json
  def index
    render json: Space.all
  end

  # GET /spaces/1
  # GET /spaces/1.json
  def show
  end

  # POST /spaces
  # POST /spaces.json
  def create
    group = Group.find(params[:space][:group_id])
    unless @current_user.id == group.user_id
      return render json: { message: "You are not permitted to perform this operation." }, status: :forbidden
    end
    @space = Space.new(space_params)
    if @space.save
      render json: @space, status: :created, location: @space
    else
      render json: @space.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /spaces/1
  # PATCH/PUT /spaces/1.json
  def update
    group = Group.find(@space.group_id)
    unless @current_user.id == group.user_id
      return render json: { message: "You are not permitted to perform this operation." }, status: :forbidden
    end
    if @space.update(space_params)
      render json: @space, status: :created, location: @space
    else
      render json: @space.errors, status: :unprocessable_entity
    end
  end

  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroy
    group = Group.find(@space.group_id)
    unless @current_user.id == group.user_id
      return render json: { message: "You are not permitted to perform this operation." }, status: :forbidden
    end
    if @space.destroy
      render json: {message: 'successfully deleted.'}, status: 204
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_space
      @space = Space.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def space_params
      params.require(:space).permit(:group_id, :start_at, :end_at, :note)
    end
end
