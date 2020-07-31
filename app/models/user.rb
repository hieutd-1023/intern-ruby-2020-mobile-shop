class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.email_regex
  PERMIT_ATTRIBUTES = %i(name email password password_confirmation).freeze

  validates :name, presence: true
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}

  before_save :downcase_email

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
