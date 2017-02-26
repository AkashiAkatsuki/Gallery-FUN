class AddCommentToIllusts < ActiveRecord::Migration[5.0]
  def change
    add_column :illusts, :comment, :text
    add_index  :illusts, :comment
  end
end
