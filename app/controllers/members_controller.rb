class MembersController < ApplicationController

  def new
    @member = Member.find(current_user.member.id)
    if @member
      render :edit
    end
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    @member.user_id = current_user.id
    if @member.save
      redirect_to :controller => 'map', :action => 'index'
    else
      render :new
    end
  end

  def edit
    if current_user.member.id != params[:id].to_i
      redirect_to :controller => 'map', :action => 'index'
    end
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(current_user.member.id)
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
