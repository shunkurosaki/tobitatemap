class MapController < ApplicationController
  def index
    gon.members = Member.limit(10)
  end
end
