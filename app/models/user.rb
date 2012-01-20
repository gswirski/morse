class User < ActiveRecord::Base
  has_many :pastes

  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :token_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :password, :password_confirmation,
                  :remember_me

  before_save :ensure_authentication_token

  validates_presence_of   :username
  validates_uniqueness_of :username, :allow_blank => true, :if => :username_changed?

  validates_presence_of     :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_length_of       :password, :within => 6..128, :allow_blank => true

  protected

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
