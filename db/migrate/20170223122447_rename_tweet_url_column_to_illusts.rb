class RenameTweetUrlColumnToIllusts < ActiveRecord::Migration[5.0]
  def change
    rename_column :illusts, :tweet_url, :id
  end
end
