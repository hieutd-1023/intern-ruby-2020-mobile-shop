class Brand < ApplicationRecord
  has_many :products, dependent: :nullify

  enum status: {unactive: 0, active: 1}, _suffix: true
end
