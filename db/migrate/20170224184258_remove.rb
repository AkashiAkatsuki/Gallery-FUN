class Remove < ActiveRecord::Migration[5.0]
  def change
    drop_table :illusts
  end
end
