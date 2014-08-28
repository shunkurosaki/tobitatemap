class MemberKeyword < ActiveRecord::Base
  belongs_to :member
  belongs_to :keyword
end
