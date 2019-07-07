class MembersController < ApplicationController
  before_action :set_member, only: [:show, :update, :destroy]
  before_action :authenticate_api, only: [:index, :show, :create, :update, :destroy]
  # GET /members
  # GET /members.json
  def index
    render json: @members = Member.all
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # POST /members
  # POST /members.json
  def create
    group = Group.find(params[:member][:group_id])
    if @current_user.id != group.user_id 
      return render json: { message: "You are not permitted to perform this operation." }, status: :forbidden
    end
    @member = Member.new(member_params)

    if @member.save
      render json: @member, status: :created
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    if @current_user.id != @member.user_id
      return render json: { message: "You are not permitted to perform this operation." }, status: :forbidden
    end
    if @member.update(member_params)
      render json: @member, status: :ok
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    group = Group.find(params[:group_id])
    unless @current_user.id == @member.user_id || group.user_id == @current_user.id
      return render json: { message: "You are not permitted to perform this operation." }, status: :forbidden
    end
    if @member.destroy
      render json: { message: 'successfully deleted' }, status: 204
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:user_id, :group_id)
    end
end
