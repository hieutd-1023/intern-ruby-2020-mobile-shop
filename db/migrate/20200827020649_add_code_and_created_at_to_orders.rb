class AddCodeAndCreatedAtToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :code, :string
    add_column :orders, :created_at, :datetime
  end
end
