class ReservationsController < ApplicationController
  before_action :authorize, only: %i[create destroy]
  before_action :read_reservation, only: [:destroy]

  def index
    @reservations = Reservation.all
    render json: @reservations
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = @user
    if @reservation.save
      render json: @reservation
    else
      render json: { error: @reservation.errors.full_messages }
    end
  end

  def update
    if @reservation.update(reservation_params)
      render json: @reservation
    else
      render json: @reservation.errors.full_messages
    end
  end

  def destroy
    if @reservation.destroy
      render json: { id: @reservation.id, message: 'Reservation deleted successfully' }
    else
      render json: @reservation.errors.full_messages
    end
  end

  private

  def read_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:reservation_date, :due_date, :car_id)
  end
end
