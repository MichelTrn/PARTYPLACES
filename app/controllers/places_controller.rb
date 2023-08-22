class PlacesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @place = Place.new
  end

  def create
    @user = User.find(params[:user_id])
    @place = Place.new(place_params)
    if @place.save
      redirect_to place_path(@place)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def place_params
    params.require(:place).permit(:name, :address, :price, :picture_url, :user_id)
  end
end
