class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.references :category, null: true, foreign_key: true
      t.float :price
      t.integer :amount
      t.references :brand, null: true, foreign_key: true
      t.string :description
      t.integer :status
    end
  end
end
