class PlacesController < ApplicationController
  def new
    @user = User.find(current_user.id)
    @place = Place.new
  end

  def index
    @place = Place.new
    @places_otheruser = Place.where.not(user: current_user)
    @places = Place.all

    if params[:query].present?
      # Méthode Search Active Record
      # @places = @places.where(name: params[:query])
      @places = Place.search_by_name_and_address(params[:query])
    end

    if user_signed_in? && params[:query].present?
      @places_user = current_user.places.search_by_name_and_address(params[:query])
      @places_otheruser = @places_otheruser.search_by_name_and_address(params[:query])
    end
  end

  def myplaces
    @myplaces = current_user.places
  end

  def create
    @place = Place.new(place_params)
    @user = User.find(current_user.id)
    @place.user = @user
    if @place.save
      redirect_to places_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @place = Place.find(params[:id])
  end

  def update
    @place = Place.find(params[:id])
    if @place.update(place_params)
      redirect_to place_path(@place)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @place = Place.find(params[:id])
    @bookings = Booking.all.select {|booking| booking.place == @place }
    @bookings.sort_by! {|booking| booking.begin_date}
    if @place.geocoded?
      @markers = [
        {
          lat: @place.latitude,
          lng: @place.longitude,
          marker_html: render_to_string(partial: "shared/marker")
        }
      ]
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to places_path, status: :see_other
  end

  private

  def place_params
    params.require(:place).permit(:name, :address, :price, :user_id, :place_id, :photo)
  end
end
