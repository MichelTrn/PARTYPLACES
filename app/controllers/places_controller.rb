class PlacesController < ApplicationController
  def new
    @user = User.find(current_user.id)
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    @user = User.find(current_user.id)
    @place.user = @user
    if @place.save
      redirect_to root_path
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

  def show
    @place = Place.find(params[:id])
  end

  def destroy
    @place = place.find(params[:id])
    @place.destroy
    redirect_to root_path, status: :see_other

  end

  private

  def place_params
    params.require(:place).permit(:name, :address, :price, photos: [])
  end
end
