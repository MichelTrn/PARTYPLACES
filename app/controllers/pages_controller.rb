class PagesController < ApplicationController
  def home
    @places_user = Place.where(user_id: current_user)
    @places = Place.all
  end
end
