class Province < ApplicationRecord
  has_many :districts, dependent: :destroy
end
