 class MembersController < ApplicationController
   before_filter :authenticate_user!,:only => [:edit,:update]

  def edit
    if current_user.member.id != params[:id].to_i
      redirect_to :controller => 'map', :action => 'index'
    end
    @member = Member.find(params[:id])
    if @member.latitude.blank? or @member.longitude.blank?
      @member.latitude = 35.0
      @member.longitude = 135.0
    end
  end

  def update
    @member = Member.find(current_user.member.id)
    if params[:member][:latitude].to_i == 35 and params[:member][:longitude].to_i == 135
      params[:member].delete(:latitude)
      params[:member].delete(:longitude)
    end
    if @member.update_attributes(member_params)
      redirect_to :controller => 'map', :action => 'index'
    else
      render :edit
    end
  end

  def show
    @member = Member.find(params[:id])
  end

  private
    def member_params
      params.require(:member).permit(:name, :city, :term, :link, :facebook, :twitter, :profile, :latitude, :longitude, :image, :image_cache)
    end

end
