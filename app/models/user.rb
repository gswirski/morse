require 'securerandom'

class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :username, :password, :password_confirmation

  before_save :ensure_authentication_token

  validates :username, uniqueness: true, presence: true, length: 3..30

  def reset_authentication_token
    self.authentication_token = generate_token
  end

  def self.find_for_token_authentication(token)
    User.where(authentication_token: token).first
  end

  private

  def ensure_authentication_token
    reset_authentication_token if authentication_token.blank?
  end

  def generate_token
    loop do
      token = SecureRandom.base64(15).tr('+/=', '-_ ').strip.delete("\n")
      break token unless User.where(authentication_token: token).first
    end
  end
end
