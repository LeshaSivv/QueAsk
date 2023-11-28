class User < ApplicationRecord
  attr_accessor :old_password

  has_secure_password validations: false
  validate :password_presense
  validate :correct_old_password, on: :update
  validates :password, confirmation: true, allow_blank: true,
                       length: { minimum: 6, maximum: 80 }
  validates :email, presence: true, uniqueness: true
  validates :name, uniqueness: true

  private

  def password_presense
    errors.add(:password, :blank) unless password_digest.present?
  end

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add(:old_password, 'is invalid')
  end
end
