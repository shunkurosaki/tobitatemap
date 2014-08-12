class Users::RegistrationsController < Devise::RegistrationsController
  after_filter :create_member, :only => 'create'
 
  def new
    super
  end
 
  def create
    super
  end

  def create_member
    if current_user.present?
      @member = Member.new
      @member.user_id = current_user.id
      @member.save(:validate => false)
    end
  end
 
end
