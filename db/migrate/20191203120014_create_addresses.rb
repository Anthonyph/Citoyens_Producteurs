class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :place
      t.string :zip_code
      t.string :city
      t.string :sector

      t.timestamps
    end
  end
end
