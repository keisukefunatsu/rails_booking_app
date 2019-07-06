class MembersRolesController < ApplicationController
  before_action :set_members_role, only: [:show, :update, :destroy]

  # GET /members_roles
  # GET /members_roles.json
  def index
    @members_roles = MembersRole.all
  end

  # GET /members_roles/1
  # GET /members_roles/1.json
  def show
  end

  # POST /members_roles
  # POST /members_roles.json
  def create
    @members_role = MembersRole.new(members_role_params)

    if @members_role.save
      render :show, status: :created, location: @members_role
    else
      render json: @members_role.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /members_roles/1
  # PATCH/PUT /members_roles/1.json
  def update
    if @members_role.update(members_role_params)
      render :show, status: :ok, location: @members_role
    else
      render json: @members_role.errors, status: :unprocessable_entity
    end
  end

  # DELETE /members_roles/1
  # DELETE /members_roles/1.json
  def destroy
    @members_role.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_members_role
      @members_role = MembersRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def members_role_params
      params.require(:members_role).permit(:member_id, :role_id)
    end
end
