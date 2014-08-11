class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #usernameを必須・一意とする
  validates_uniqueness_of :username
  validates_presence_of :username

  #登録時にemailを不要とする
  def email_required?
    false
  end
  def email_changed?
    false
  end

end
