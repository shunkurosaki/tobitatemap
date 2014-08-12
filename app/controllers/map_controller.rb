class MapController < ApplicationController
  def index
    gon.latitude = 37.792457
    gon.longitude = -122.393064
  end
end