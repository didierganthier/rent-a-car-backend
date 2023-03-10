class ReservationsController < ApplicationController
  before_action :authorize
  before_action :read_reservation, only: [:destroy]

  def index
    render json: @user.reservations
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = @user
    car = Car.where(id: params[:reservation][:car_id])
    if @reservation.save
      render json: { reservation: @reservation, name: @user.name,
                     car: }
    else
      render json: { error: @reservation.errors.full_messages }
    end
  end

  def update
    unless @user == Reservation.find(params[:id]).user
      return render json: { error: 'You are not allowed because you did not create the reservation' },
                    status: :unauthorized
    end
    car = Car.where(id: params[:reservation][:car_id])
    if @reservation.update(reservation_params)
      render json: { reservation: @reservation, name: @user.name,
                     car: }
    else
      render json: @reservation.errors.full_messages
    end
  end

  def destroy
    unless @user == Reservation.find(params[:id]).user
      return render json: { error: 'You are not allowed because you did not create the reservation' },
                    status: :unauthorized
    end
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
