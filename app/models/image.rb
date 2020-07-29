class Image < ApplicationRecord
  belongs_to :product

  enum status: {unactive: 0, active: 1}, _suffix: true
end
