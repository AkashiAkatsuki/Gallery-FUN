class AddAccountToBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :account, :string
  end
end
