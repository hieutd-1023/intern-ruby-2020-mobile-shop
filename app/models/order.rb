class Order < ApplicationRecord
  PERMIT_CREATE_ATTRIBUTES = [:user_id, :name_receiver, :address_receiver,
                              :phone_receiver, :type, :status,
                              order_items_attributes: [:id, :order_id,
                                                       :product_id, :quantity,
                                                       :amount, :_destroy]]
                             .freeze
  PERMIT_UPDATE_ATTRIBUTES = [:status].freeze

  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items, allow_destroy: true

  enum status: {pending: 3, handing: 2, resolved: 1}, _suffix: true

  after_save :update_code, :update_created_at

  validates :name_receiver, :address_receiver, :phone_receiver, :status,
            presence: true
  validates :status, inclusion: {in: %w(pending handing resolved)}

  scope :order_by_id, (lambda do |option|
    where(id: :option) if option.present?
  end)

  scope :by_name_receiver, (lambda do |key_word|
    where("name_receiver LIKE ?", "%#{key_word}%") if key_word.present?
  end)

  scope :by_status, (lambda do |option|
    where(status: option) if option.present?
  end)

  scope :by_user, (lambda do |user_id|
    where(user_id: user_id) if user_id.present?
  end)

  def total_quantity
    order_items.to_a.sum(&:quantity)
  end

  def total_amount
    order_items.to_a.sum(&:amount)
  end

  def update_code
    update code: (Time.now.to_i * Settings.config_timestamp).to_s
  end

  def update_created_at
    update created_at: Time.zone.now
  end
end
