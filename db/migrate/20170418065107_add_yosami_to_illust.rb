class AddYosamiToIllust < ActiveRecord::Migration[5.0]
  def change
    add_column :illusts, :yosami, :integer
  end
end
