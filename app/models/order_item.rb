class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, allow_blank: false,
            numericality: {only_integer: true}
  validate :validate_quantity

  enum status: {pending: 3, handing: 2, resolved: 1}, _suffix: true

  after_save :update_amount, :update_total_amount

  scope :filter_by_order, (lambda do |order_id|
    where order_id: order_id if order_id.present?
  end)

  def validate_quantity
    errors.add(:quantity, I18n.t(".out_of_stock")) if quantity > product.amount
  end

  private

  def update_amount
    product_quantity = product.amount - quantity
    product.update amount: product_quantity
  end

  def update_total_amount
    amount = product.price * quantity
    update amount: amount
  end
end
