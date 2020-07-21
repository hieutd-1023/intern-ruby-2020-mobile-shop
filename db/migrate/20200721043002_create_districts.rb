class CreateDistricts < ActiveRecord::Migration[6.0]
  def change
    create_table :districts do |t|
      t.string :name
      t.references :province, null: false, foreign_key: true
      t.integer :status
    end
  end
end
