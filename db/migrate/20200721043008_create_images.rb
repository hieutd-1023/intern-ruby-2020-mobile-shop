class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.references :product, null: false, foreign_key: true
      t.string :url
      t.integer :status
    end
  end
end
