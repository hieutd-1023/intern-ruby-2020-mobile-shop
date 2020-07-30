class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  has_many :images, dependent: :destroy
  has_many :order_items, dependent: :destroy

  enum status: {unactive: 0, active: 1}, _suffix: true

  scope :by_brand, (lambda do |brand_ids|
    where brand_id: brand_ids if brand_ids.present?
  end)

  scope :by_name, (lambda do |value|
    where("products.name LIKE '%#{value}%'") if value.present?
  end)

  scope :by_status_images, (lambda do |value|
    where(images: {status: value})
  end)

  scope :by_category, (lambda do |category_id|
    where(category_id: category_id)
  end)
end
