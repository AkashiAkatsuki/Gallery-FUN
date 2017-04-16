class AddTweetIdToBoards < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :tweet_id, :string 
  end
end
