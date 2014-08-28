class Member < ActiveRecord::Base
  has_many :member_keywords
  has_many :keywords, :through => :member_keywords
  belongs_to :user
  mount_uploader :image, ImageUploader
end
