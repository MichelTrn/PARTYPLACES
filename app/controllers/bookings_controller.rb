class BookingsController < ApplicationController
  before_action :set_place, only: %i[new create]

  def index
    @places_user = Place.where(user_id: current_user)
    @my_bookings_owner = []
    @places_user.each do |place|
      # place.name
      @my_bookings_owner << place.bookings

    end
    # @my_bookings_owner.sort_by! {|booking| place.booking.begin_date}
    @my_bookings_locataire = Booking.all.select {|booking| booking.user_id == current_user.id }
    @my_bookings_locataire.sort_by! {|booking| booking.begin_date}

  end

  def new
    @booking = Booking.new
  end

  def accepted
    @booking = Booking.find(params[:id])
    @booking.status = 'booked'
    @booking.save
    redirect_to bookings_path
  end

  def refused
    @booking = Booking.find(params[:id])
    @booking.status = 'refused'
    @booking.save
    redirect_to bookings_path
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
    @booking.update(booking_params)
    redirect_to place_path(@booking.place_id)
  end

  private

  def set_place
    @place = Place.find(params[:place_id])
  end

  def booking_params
    # TODO: check your model, might be different than mine
    params.require(:booking).permit(:begin_date,:end_date, :status)
  end
end
