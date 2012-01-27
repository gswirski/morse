class Group < ActiveRecord::Base
  has_many :user_groups
  has_many :users, :through => :user_groups
  has_and_belongs_to_many :pastes
end
