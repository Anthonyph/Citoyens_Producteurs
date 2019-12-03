class CreateStoreProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :store_products do |t|
      t.integer :quantity
      t.references :product, foreign_key: true
      t.references :store, foreign_key: true
      t.references :unit, foreign_key: true

      t.timestamps
    end
  end
end
