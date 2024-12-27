class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, if: :password_required?
  validates :first_name, :last_name, :user_name, :date_of_birth, :gender, :nationality, :phone_number, presence: true
  validates :user_name, uniqueness: true
  validates :phone_number, format: { with: /\A[\d+\-\(\)\s]+\z/, message: 'only allows valid phone numbers' }
  validates :gender, inclusion: { in: %w[Male Female Other], message: 'is not valid' }
  validate :date_of_birth_in_the_past

  # Custom validation
  def date_of_birth_in_the_past
    return if date_of_birth.blank?

    errors.add(:date_of_birth, "must be in the past") if date_of_birth >= Date.today
  end

  # Devise override to check if password is required
  def password_required?
    new_record? || password.present?
  end
end
