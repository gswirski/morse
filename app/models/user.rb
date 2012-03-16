class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :username, :password, :password_confirmation

  validates :username, uniqueness: true, presence: true, length: 3..30
end
