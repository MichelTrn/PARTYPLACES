class PagesController < ApplicationController
  def home
    @places_user = Place.where(user_id: current_user)
    @places_otheruser = Place.where.not(user_id: current_user)
    @places = Place.all
    if params[:query].present?
      # Méthode Search Active Record
      # @places = @places.where(name: params[:query])
      @places = Place.search_by_name_and_address(params[:query])
      @places_otheruser = @places_otheruser.search_by_name_and_address(params[:query])
    end
  end
end
