class RenameIdColumnToIllusts < ActiveRecord::Migration[5.0]
  def change
    rename_column :illusts, :id, :tweet_id
  end
end
