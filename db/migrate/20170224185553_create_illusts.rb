class CreateIllusts < ActiveRecord::Migration[5.0]
  def change
    create_table :illusts do |t|
      t.integer :tweet_id
      t.string :pic_url
      t.string :account
      t.string :comment
      t.string :tags

      t.timestamps
    end
  end
end
