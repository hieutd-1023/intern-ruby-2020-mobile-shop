class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :gender
      t.string :phone
      t.date :birthday
      t.string :address
      t.references :province, null: true, foreign_key: true
      t.references :district, null: true, foreign_key: true
      t.references :ward, null: true, foreign_key: true
      t.integer :role
      t.integer :status
    end
  end
end
