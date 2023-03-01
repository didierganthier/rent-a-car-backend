class CarsController < ApplicationController
  before_action :authorize, only: %i[create destroy]
  before_action :read_car, only: %i[show destroy]

  def index
    @cars = Car.all
    render json: @cars
  end

  def show
    render json: @car
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      render json: @car
    else
      render json: @car.errors.full_messages
    end
  end

  def destroy
    if @car.destroy
      render json: 'Car deleted successfully'
    else
      render json: @car.errors.full_messages
    end
  end

  private

  def read_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:name, :car_type, :description, :image, :brand, :daily_rate)
  end
end
