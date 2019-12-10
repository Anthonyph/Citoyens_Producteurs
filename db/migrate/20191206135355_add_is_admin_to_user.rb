class AddIsAdminToUser < ActiveRecord::Migration[5.2]
  def change
<<<<<<< HEAD
    add_column :users, :is_admin, :boolean,default: false
=======
    add_column :users, :is_admin, :boolean, default: false
>>>>>>> development
  end
end
