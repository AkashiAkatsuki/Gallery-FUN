class RemoveTitleFromBoards < ActiveRecord::Migration[5.0]
  def change
    remove_column :boards, :title, :string
    remove_column :boards, :body, :text
    add_column :boards, :text, :text
  end
end
