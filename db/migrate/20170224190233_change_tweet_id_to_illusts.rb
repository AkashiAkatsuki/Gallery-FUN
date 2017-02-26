class ChangeTweetIdToIllusts < ActiveRecord::Migration[5.0]
  def change
    remove_column :illusts, :tweet_id, :integer
    add_column :illusts, :tweet_id, :string
  end
end
