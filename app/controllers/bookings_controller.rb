class BookingsController < ApplicationController
  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to place_path(@booking.place_id)
    end
  end

  private

  def booking_params
    # TODO: check your model, might be different than mine
    params.require(:booking).permit(:status)
  end
end
