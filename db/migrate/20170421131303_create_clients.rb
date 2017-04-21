class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.text :consumer_key
      t.text :consumer_secret
      t.text :access_token
      t.text :access_token_secret

      t.timestamps
    end
  end
end
