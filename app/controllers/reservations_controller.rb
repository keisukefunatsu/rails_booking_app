class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]
  before_action :authenticate_api, only: [:index, :show, :create, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    space = Space.find(params[:space_id])
    group = Group.find(space.group_id)
    group_admin = User.find(group.user_id)
    member = Member.find_by(group_id: group.id, user_id: @current_user.id)
    if @current_user.id == group_admin.id
      @reservations = Reservation.where(space_id: params[:space_id])
    elsif member
      @reservations = Reservation.where(
          space_id: params[:space_id], 
          member_id: member.id
        )
    end
    render json: @reservations
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # POST /reservations
  # POST /reservations.json
  def create
    space = Space.find(params[:space_id])
    group = Group.find(space.group_id)
    group_member_ids = Member.where(group_id: group.id).pluck(:user_id)
    unless group_member_ids.include?(@current_user.id)
      return render json: { message: "You are not permitted to perform this operation." }, status: :forbidden
    end
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    space = Space.find(params[:space_id])
    group = Group.find(space.group_id)
    group_member_ids = Member.where(group_id: group.id).pluck(:user_id)
    user_id = User.find(@reservation.member.user_id)
    unless group.user_id == @current_user.id || user_id == @current_user.id
      return render json: { message: "You are not permitted to perform this operation." }, status: :forbidden
    end
    if @reservation.update(reservation_params)
      render json: @reservation, status: :ok
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    space = Space.find(params[:space_id])
    group = Group.find(space.group_id)
    group_member_ids = Member.where(group_id: group.id).pluck(:user_id)
    user_id = User.find(@reservation.member.user_id)
    unless group.user_id == @current_user.id || user_id == @current_user.id
      return render json: { message: "You are not permitted to perform this operation." }, status: :forbidden
    end
    if @reservation.destroy
      render json: {message: 'successfully deleted'}, status: 204
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:member_id, :space_id, :start_at, :end_at, :note)
    end
end
