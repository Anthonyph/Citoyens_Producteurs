class AddIsPassedToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :is_passed, :boolean, default: false
  end
end
