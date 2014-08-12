 class MembersController < ApplicationController

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
    if params[:latitude] == 35.0 and params[:longitude] == 135.0
      params.delete(:latitude)
      params.delete(:longitude)
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
      params.require(:member).permit(:name, :city, :term, :link, :facebook, :twitter, :profile, :latitude, :longitude)
    end

end
