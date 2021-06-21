class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.user.valid_email_regex
  has_secure_password
  validates :name, presence: true, length: { maximum: Settings.user.username_length }
  validates :email, presence: true, length: { maximum: Settings.user.email_username_length }, 
    format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: Settings.user.password_min_length }
  before_save { self.email = email.downcase }

  def User.digest string
    cost = if ActiveModel::SecurePassword.min_cost
      BCrypt::Engine::MIN_COST
    else
      BCrypt::Engine.cost
    end
    BCrypt::Password.create string, cost: cost
  end

end
