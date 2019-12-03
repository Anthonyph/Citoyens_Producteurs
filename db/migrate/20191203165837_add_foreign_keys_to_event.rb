class AddForeignKeysToEvent < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :address, foreign_key: true
    add_reference :events, :event_type, foreign_key: true
  end
end
