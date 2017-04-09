class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.text :name
      t.text :account
      t.text :memo

      t.timestamps
    end
  end
end
