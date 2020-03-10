class CreateBlogComments < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs_comments do |t|
      t.text :text
      t.references :user, foreign_key: true
      t.references :blog, foreign_key: true

      t.timestamps
    end
  end
end
