class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start_date
      t.datetime :end_da
      t.references :creator, index: true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end