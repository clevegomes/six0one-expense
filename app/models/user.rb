class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable, :authentication_keys => [ :email ]


  validates :auth_token, uniqueness: true
  # Instead of validatable
  validates_uniqueness_of    :email, case_sensitive: false, allow_blank: true, if: :email_changed?
  validates_format_of    :email, with: Devise.email_regexp, allow_blank: true, if: :email_changed?
  validates_presence_of    :password, on: :create
  validates_confirmation_of    :password
  validates_length_of    :password, within: Devise.password_length, allow_blank: true

  before_create :generate_authentication_token!

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  def set_auth_token
    if self.auth_token.blank?
      self.generate_authentication_token!
      self.save(validate: false)
    end
  end

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
end
