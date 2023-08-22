class PagesController < ApplicationController
  def home
    @places_user = Place.where(id: current_user)
    @places = Place.all
  end
end
