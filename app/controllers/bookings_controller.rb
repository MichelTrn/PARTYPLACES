class BookingsController < ApplicationController
  before_action :set_place, only: %i[new create]

  def index
    @places_user = Place.where(user_id: current_user)
    @places_user.each do |place|
      @my_bookings_owner = Booking.all.select { |booking| booking.place_id == place.id }
      # @my_bookings_owner.each do |booking|
      #   booking.update(booking_params)
      #    raise
      #   redirect_to bookings_path
      # end
    end

    @my_bookings_locataire = Booking.all.select {|booking| booking.user_id == current_user.id }
  end

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
    params.require(:booking).permit(:begin_date, :end_date, :status)
  end
end
