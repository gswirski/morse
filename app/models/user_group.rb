class UserGroup < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  default_scope where("is_accepted = ?", true)
  scope :invitations, where("is_accepted = ?", false)
end
