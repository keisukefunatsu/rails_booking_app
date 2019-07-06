class MemberRolesController < ApplicationController
  before_action :set_member_role, only: [:show, :update, :destroy]

  # GET /member_roles
  # GET /member_roles.json
  def index
    render json: MemberRole.all
  end

  # GET /member_roles/1
  # GET /member_roles/1.json
  def show
  end

  # POST /member_roles
  # POST /member_roles.json
  def create
    @member_role = MemberRole.new(member_role_params)

    if @member_role.save
      render :show, status: :created, location: @member_role
    else
      render json: @member_role.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /member_roles/1
  # PATCH/PUT /member_roles/1.json
  def update
    if @member_role.update(member_role_params)
      render :show, status: :ok, location: @member_role
    else
      render json: @member_role.errors, status: :unprocessable_entity
    end
  end

  # DELETE /member_roles/1
  # DELETE /member_roles/1.json
  def destroy
    @member_role.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member_role
      @member_role = MemberRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_role_params
      params.require(:member_role).permit(:member_id, :role_id)
    end
end
