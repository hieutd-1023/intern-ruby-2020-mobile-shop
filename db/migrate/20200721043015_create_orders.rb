class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: true, foreign_key: true
      t.string :name_receiver
      t.string :address_receiver
      t.string :phone_receiver
      t.integer :status
    end
  end
end
