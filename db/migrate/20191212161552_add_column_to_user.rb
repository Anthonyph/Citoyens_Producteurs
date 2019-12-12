class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :has_payed, :boolean, default: false
  end
end
