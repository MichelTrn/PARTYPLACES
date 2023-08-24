class BookingsController < ApplicationController
  before_action :set_place, only: %i[new create]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.status = "pending confirmation"
    @booking.place = @place
    @booking.user = current_user
    @booking.save
    redirect_to place_path(@place)
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to place_path(@booking.place_id)
    end
  end

  private

  def set_place
    @place = Place.find(params[:place_id])
  end

  def booking_params
    # TODO: check your model, might be different than mine
    params.require(:booking).permit(:begin_date,:end_date)
  end
end
