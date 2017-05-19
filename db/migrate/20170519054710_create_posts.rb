class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :topic
      t.string :poster
      t.text :comment

      t.timestamps
    end
  end
end
