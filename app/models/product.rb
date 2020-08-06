class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  has_many :images, dependent: :destroy
  has_many :order_items, dependent: :destroy

  delegate :name, to: :category, prefix: true
  delegate :name, to: :brand, prefix: true

  accepts_nested_attributes_for :images, allow_destroy: true

  enum status: {unactive: 0, active: 1}, _suffix: true

  PERMIT_ATTRIBUTES = [:name, :category_id, :brand_id, :amount, :price,
                       :description, :status,
                       images_attributes: [:id, :url, :status, :_destroy]]
                      .freeze
  validates :name, :amount, :price, :description, presence: true

  scope :by_brand, (lambda do |brand_ids|
    where brand_id: brand_ids if brand_ids.present?
  end)

  scope :by_name, (lambda do |value|
    where("products.name LIKE '%#{value}%'") if value.present?
  end)

  scope :by_status_images, (lambda do |value|
    where(images: {status: value}) if value.present?
  end)

  scope :by_category, (lambda do |category_id|
    where(category_id: category_id) if category_id.present?
  end)

  scope :by_from_price, (lambda do |from_price|
    where("price >= ?", from_price) if from_price.present?
  end)

  scope :by_to_price, (lambda do |to_price|
    where("price <= ?", to_price) if to_price.present?
  end)
end
