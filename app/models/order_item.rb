class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, :amount, presence: true

  enum status: {pending: 3, handing: 2, resolved: 1}, _suffix: true

  scope :filter_by_order, (lambda do |order_id|
    where order_id: order_id if order_id.present?
  end)
end
