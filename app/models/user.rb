class User < ApplicationRecord
  attr_accessor :old_password, :remember_token

  has_secure_password validations: false
  validate :password_presense
  validate :correct_old_password, on: :update, if: -> { password.present? }
  validates :password, confirmation: true, allow_blank: true,
                       length: { minimum: 6, maximum: 80 }
  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true
  validates :name, uniqueness: true

  def remember_me
    self.remember_token = SecureRandom.urlsafe_base64
    update_column(:remember_token_digest, digest(remember_token))
  end

  def forget_me
    update_column(:remember_token_digest, nil)
  end

  def remember_token_authenticated?(remember_token)
    return false unless remember_token_digest.present?

    BCrypt::Password.new(remember_token_digest).is_password?(remember_token)
  end

  private

  def digest(string)
    cost = ActiveModel::SecurePassword.
      min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def password_presense
    errors.add(:password, :blank) unless password_digest.present?
  end

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add(:old_password, 'is invalid')
  end
end
