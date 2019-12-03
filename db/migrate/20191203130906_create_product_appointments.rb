class CreateProductAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :product_appointments do |t|
      t.integer :quantity
      t.references :product, foreign_key: true
      t.references :appointment, foreign_key: true
      t.references :unit, foreign_key: true

      t.timestamps
    end
  end
end
