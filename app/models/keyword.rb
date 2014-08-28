class Keyword < ActiveRecord::Base
  has_many :member_keywords
  has_many :members, :through => :member_keywords
end
