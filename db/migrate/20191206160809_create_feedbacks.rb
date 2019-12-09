class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.text :content
      t.integer :rating
      t.references :feedbackable, polymorphic: true

      t.timestamps
    end
  end
end
