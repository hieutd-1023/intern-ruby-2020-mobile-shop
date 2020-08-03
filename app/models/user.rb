class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.email_regex
  PERMIT_ATTRIBUTES = %i(name email password password_confirmation).freeze

  validates :name, presence: true
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}

  before_save :downcase_email

  has_secure_password

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end
  end

  private

  def downcase_email
    email.downcase!
  end
end
