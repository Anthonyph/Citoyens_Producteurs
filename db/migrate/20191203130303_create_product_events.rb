class CreateProductEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :product_events do |t|
      t.integer :quantity
      t.references :product, foreign_key: true
      t.references :event, foreign_key: true
      t.references :unit, foreign_key: true

      t.timestamps
    end
  end
end
